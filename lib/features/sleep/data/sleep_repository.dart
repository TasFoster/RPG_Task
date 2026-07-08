import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../../core/gamification/reward_service.dart';
import '../../../core/models/enums.dart';
import 'sleep_cycle.dart';

/// Доступ к записям сна + начисление опыта в ось «Здоровье».
class SleepRepository {
  final AppDatabase db;
  final RewardService rewards;
  SleepRepository(this.db, this.rewards);

  static String dateKeyFor(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  Stream<List<SleepLog>> watchLogs() {
    return (db.select(db.sleepLogs)
          ..where((s) => s.isDeleted.equals(false))
          ..orderBy([
            (s) => OrderingTerm(expression: s.wakeTime, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  /// XP за сон: максимум за сон в целевом окне 7–9 часов.
  static int sleepXp(Duration d) {
    final h = d.inMinutes / 60.0;
    if (h >= 7 && h <= 9) return 20;
    if (h >= 6 && h < 7) return 10;
    if (h > 9 && h <= 10) return 12;
    return 5; // за сам факт ведения дневника
  }

  Future<String?> _healthAxisId() async {
    final axis = await (db.select(db.skillAxes)
          ..where((a) => a.name.equals('Здоровье')))
        .getSingleOrNull();
    return axis?.id;
  }

  /// Добавляет запись сна и начисляет опыт в «Здоровье».
  Future<RewardResult> addSleep({
    required DateTime bed,
    required DateTime wake,
    String? note,
  }) async {
    final dur = sleepDuration(bed, wake);
    final xp = sleepXp(dur);
    final key = dateKeyFor(wake);
    // Стабильный id по натуральному ключу (дата подъёма): разные устройства
    // создают ОДНУ и ту же строку — синхронизация не плодит дубликаты.
    final id = 'sleep_$key';

    // Если запись за эту дату уже есть (в т.ч. со старым случайным id) —
    // обновляем её вместо дубликата; опыт повторно не начисляем.
    final existing = await (db.select(db.sleepLogs)
          ..where((s) => s.dateKey.equals(key) & s.isDeleted.equals(false)))
        .get();
    if (existing.isNotEmpty) {
      await updateSleep(
          id: existing.first.id, bed: bed, wake: wake, note: note);
      return const RewardResult(xp: 0, gold: 0, gems: 0);
    }

    await db.into(db.sleepLogs).insertOnConflictUpdate(
          SleepLogsCompanion.insert(
            id: id,
            dateKey: key,
            bedTime: bed,
            wakeTime: wake,
            note: Value(note),
            xpAwarded: Value(xp),
            isDeleted: const Value(false),
            dirty: const Value(true),
            updatedAt: Value(DateTime.now()),
          ),
        );

    final reward = RewardResult(xp: xp, gold: 0, gems: 0);
    await rewards.applyReward(
      reward,
      reason: RewardReason.sleepReward,
      refId: id,
      axisId: await _healthAxisId(),
    );
    return reward;
  }

  /// Правит время/заметку записи (без повторного начисления опыта).
  Future<void> updateSleep({
    required String id,
    required DateTime bed,
    required DateTime wake,
    String? note,
  }) async {
    await (db.update(db.sleepLogs)..where((s) => s.id.equals(id))).write(
      SleepLogsCompanion(
        bedTime: Value(bed),
        wakeTime: Value(wake),
        dateKey: Value(dateKeyFor(wake)),
        note: Value(note),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteSleep(String id) async {
    await (db.update(db.sleepLogs)..where((s) => s.id.equals(id))).write(
      SleepLogsCompanion(
        isDeleted: const Value(true),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

final sleepRepositoryProvider = Provider<SleepRepository>((ref) {
  return SleepRepository(
    ref.watch(databaseProvider),
    ref.watch(rewardServiceProvider),
  );
});

final sleepLogsProvider = StreamProvider<List<SleepLog>>((ref) {
  return ref.watch(sleepRepositoryProvider).watchLogs();
});
