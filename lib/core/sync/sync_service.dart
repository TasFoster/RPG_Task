import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';
import 'supabase_config.dart';

/// Имя таблицы-хранилища на стороне Supabase (одна на все локальные таблицы).
const String _kRemoteTable = 'sync_rows';
const String _kLastPullKey = 'sync_last_pull';
const String _kSyncUserKey = 'sync_user_id';

/// «Нахлёст» окна подтягивания: каждую синхронизацию перечитываем ещё и строки
/// за последние [_kPullOverlap] до курсора. Это защищает от расхождения часов
/// между устройствами (изменение с чуть «отставшей» датой иначе навсегда
/// проскочило бы мимо курсора). Повторное применение безопасно —
/// работает last-write-wins по `updated_at`.
const Duration _kPullOverlap = Duration(days: 2);

/// Обёртка над локальной таблицей Drift для универсальной синхронизации.
/// Все синхронизируемые таблицы имеют столбцы id/updated_at/is_deleted/dirty
/// (миксин _SyncColumns), поэтому доступ к ним однотипный.
class SyncEntity<T extends Table, D extends DataClass> {
  final TableInfo<T, D> table;
  SyncEntity(this.table);

  String get name => table.actualTableName;

  /// «Грязные» (изменённые локально) строки как сырые карты столбцов.
  Future<List<Map<String, dynamic>>> dirtyRows(GeneratedDatabase db) async {
    final rows =
        await db.customSelect('SELECT * FROM $name WHERE dirty = 1').get();
    return rows.map((r) => r.data).toList();
  }

  Future<void> clearDirty(GeneratedDatabase db, List<String> ids) async {
    if (ids.isEmpty) return;
    final placeholders = List.filled(ids.length, '?').join(',');
    await db.customStatement(
        'UPDATE $name SET dirty = 0 WHERE id IN ($placeholders)', ids);
  }

  /// Локальное время изменения строки (unix-секунды) или null, если строки нет.
  Future<int?> localUpdatedAt(GeneratedDatabase db, String id) async {
    final rows = await db.customSelect(
        'SELECT updated_at FROM $name WHERE id = ?', variables: [
      Variable<String>(id)
    ]).get();
    if (rows.isEmpty) return null;
    return rows.first.data['updated_at'] as int?;
  }

  /// Применяет удалённую строку локально (dirty=0, чтобы не пушить обратно).
  Future<void> applyRemote(
      GeneratedDatabase db, Map<String, dynamic> data) async {
    final obj = await table.map({...data, 'dirty': 0});
    await db.into(table).insertOnConflictUpdate(obj as Insertable<D>);
  }
}

/// Список синхронизируемых таблиц в порядке применения (родители раньше детей,
/// чтобы не нарушать внешние ключи при вставке из облака).
List<SyncEntity> syncEntities(AppDatabase db) => [
      SyncEntity(db.profiles),
      SyncEntity(db.skillAxes),
      SyncEntity(db.notes), // FK: notes.axisId → skill_axes
      SyncEntity(db.habits),
      SyncEntity(db.goals),
      SyncEntity(db.tasks),
      SyncEntity(db.habitLogs),
      SyncEntity(db.goalSteps),
      SyncEntity(db.dailyQuests),
      SyncEntity(db.userAchievements),
      SyncEntity(db.inventoryItems),
      SyncEntity(db.sleepLogs),
      SyncEntity(db.codexEntries),
      SyncEntity(db.currencyTransactions),
      SyncEntity(db.statSnapshots),
      SyncEntity(db.seasons),
    ];

enum SyncStatus { idle, syncing, success, error, offline }

class SyncState {
  final SyncStatus status;
  final DateTime? lastSyncedAt;
  final String? error;
  const SyncState(
      {this.status = SyncStatus.idle, this.lastSyncedAt, this.error});

  SyncState copyWith(
          {SyncStatus? status, DateTime? lastSyncedAt, String? error}) =>
      SyncState(
        status: status ?? this.status,
        lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
        error: error,
      );
}

DateTime _dateFromDbSeconds(int seconds) =>
    DateTime.fromMillisecondsSinceEpoch(seconds * 1000, isUtc: true);

/// Управляет двусторонней синхронизацией локальной БД с Supabase.
class SyncController extends Notifier<SyncState> {
  bool _running = false;

  @override
  SyncState build() => const SyncState();

  SupabaseClient get _client => Supabase.instance.client;
  bool get _ready =>
      SupabaseConfig.isConfigured && _client.auth.currentUser != null;

  /// Полная синхронизация: пуш локальных изменений, затем подтягивание облачных.
  Future<void> syncNow() async {
    if (!_ready) {
      state = state.copyWith(status: SyncStatus.offline, error: null);
      return;
    }
    if (_running) return;
    _running = true;
    state = state.copyWith(status: SyncStatus.syncing, error: null);
    try {
      final db = ref.read(databaseProvider);
      await _ensureSameUser(db);
      await _pushAll(db);
      await _pullAll(db);
      state = SyncState(
          status: SyncStatus.success, lastSyncedAt: DateTime.now());
    } catch (e, st) {
      if (kDebugMode) debugPrint('Sync failed: $e\n$st');
      state = state.copyWith(status: SyncStatus.error, error: '$e');
    } finally {
      _running = false;
    }
  }

  /// Восстановление после рассинхронизации: делает ДАННЫЕ ЭТОГО УСТРОЙСТВА
  /// источником истины. Помечает все локальные строки как изменённые и
  /// проставляет им свежую дату, после чего запускает синхронизацию — так они
  /// гарантированно «выигрывают» last-write-wins на других устройствах.
  ///
  /// Нужно, если из-за прежней ошибки на одном из устройств данные (опыт,
  /// золото, статусы задач) затёрлись пустыми. Запускать на устройстве с
  /// ПРАВИЛЬНЫМИ данными.
  Future<void> forceUploadLocal() async {
    if (!_ready) {
      state = state.copyWith(status: SyncStatus.offline, error: null);
      return;
    }
    if (_running) return;
    final db = ref.read(databaseProvider);
    // Drift хранит DateTime как unix-секунды — ставим текущее время.
    final nowSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    for (final entity in syncEntities(db)) {
      await db.customStatement(
        'UPDATE ${entity.name} SET dirty = 1, updated_at = ?',
        [nowSeconds],
      );
    }
    await syncNow();
  }

  /// Если на устройстве сменился аккаунт — сбрасываем «точку подтягивания»
  /// (иначе данные разных пользователей смешаются). Полная очистка локальных
  /// данных при смене пользователя описана в docs/SUPABASE_RU.md.
  Future<void> _ensureSameUser(AppDatabase db) async {
    final prefs = await SharedPreferences.getInstance();
    final current = _client.auth.currentUser!.id;
    final stored = prefs.getString(_kSyncUserKey);
    if (stored != current) {
      await prefs.remove(_kLastPullKey);
      await prefs.setString(_kSyncUserKey, current);
    }
  }

  Future<void> _pushAll(AppDatabase db) async {
    final userId = _client.auth.currentUser!.id;
    for (final entity in syncEntities(db)) {
      final dirty = await entity.dirtyRows(db);
      if (dirty.isEmpty) continue;
      final payloads = <Map<String, dynamic>>[];
      final ids = <String>[];
      for (final row in dirty) {
        final id = row['id'] as String;
        final updatedAt = (row['updated_at'] as int?) ?? 0;
        final isDeleted = (row['is_deleted'] as int? ?? 0) == 1;
        payloads.add({
          'user_id': userId,
          'table_name': entity.name,
          'row_id': id,
          'updated_at': _dateFromDbSeconds(updatedAt).toIso8601String(),
          'is_deleted': isDeleted,
          'data': row,
        });
        ids.add(id);
      }
      await _client
          .from(_kRemoteTable)
          .upsert(payloads, onConflict: 'user_id,table_name,row_id');
      await entity.clearDirty(db, ids);
    }
  }

  Future<void> _pullAll(AppDatabase db) async {
    final prefs = await SharedPreferences.getInstance();
    final lastPull = prefs.getString(_kLastPullKey);

    // Выбираем изменения с курсора минус «нахлёст» (защита от расхождения часов).
    // Сам курсор при этом назад не сдвигаем — только раздвигаем окно чтения.
    String? since = lastPull;
    if (lastPull != null) {
      final parsed = DateTime.tryParse(lastPull);
      if (parsed != null) {
        since = parsed.toUtc().subtract(_kPullOverlap).toIso8601String();
      }
    }

    var query = _client.from(_kRemoteTable).select();
    if (since != null) {
      query = query.gt('updated_at', since);
    }
    final remote = await query;
    if (remote.isEmpty) return;

    final byName = {for (final e in syncEntities(db)) e.name: e};
    String maxUpdated = lastPull ?? '';

    // Применяем в порядке зависимостей (как в syncEntities).
    for (final entity in syncEntities(db)) {
      final rows = remote.where((r) => r['table_name'] == entity.name);
      for (final r in rows) {
        // Ошибка на одной строке (несовместимая схема, битые данные, FK)
        // не должна срывать весь пул — логируем и продолжаем со следующей.
        try {
          final data = Map<String, dynamic>.from(r['data'] as Map);
          final id = r['row_id'] as String;
          final remoteSeconds = (data['updated_at'] as int?) ?? 0;
          final localSeconds = await entity.localUpdatedAt(db, id);
          // Last-write-wins: применяем только если облачная версия новее.
          if (localSeconds == null || remoteSeconds > localSeconds) {
            await entity.applyRemote(db, data);
          }
        } catch (e, st) {
          if (kDebugMode) {
            debugPrint(
                'Sync: пропущена строка ${entity.name}/${r['row_id']}: $e\n$st');
          }
        }
        final upd = r['updated_at'] as String;
        if (upd.compareTo(maxUpdated) > 0) maxUpdated = upd;
      }
    }
    // Строки могли прийти в любом порядке — учитываем и те, что не по entity.
    for (final r in remote) {
      final entity = byName[r['table_name']];
      if (entity == null) continue; // неизвестная таблица (др. версия схемы)
      final upd = r['updated_at'] as String;
      if (upd.compareTo(maxUpdated) > 0) maxUpdated = upd;
    }

    if (maxUpdated.isNotEmpty) {
      await prefs.setString(_kLastPullKey, maxUpdated);
    }
  }
}

final syncControllerProvider =
    NotifierProvider<SyncController, SyncState>(SyncController.new);
