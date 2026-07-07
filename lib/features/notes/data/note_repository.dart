import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../../core/gamification/reward_service.dart';
import '../../../core/models/enums.dart';

const _uuid = Uuid();

/// Небольшая награда за первую запись «Дневника» за день.
const _journalDailyXp = 15;

DateTime _dayOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Доступ к заметкам «Дневника героя» в локальной БД.
class NoteRepository {
  final AppDatabase db;
  final RewardService rewards;
  NoteRepository(this.db, this.rewards);

  /// Все заметки: закреплённые сверху, затем по дате создания (новые выше).
  Stream<List<Note>> watchNotes() {
    return (db.select(db.notes)
          ..where((n) => n.isDeleted.equals(false))
          ..orderBy([
            (n) => OrderingTerm(
                expression: n.pinned, mode: OrderingMode.desc),
            (n) => OrderingTerm(
                expression: n.createdAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Stream<Note?> watchNote(String id) {
    return (db.select(db.notes)..where((n) => n.id.equals(id)))
        .watchSingleOrNull();
  }

  /// Была ли уже сегодня хотя бы одна запись (для награды «раз в день»).
  Future<bool> hasEntryToday() async {
    final start = _dayOnly(DateTime.now());
    final count = await (db.select(db.notes)
          ..where((n) =>
              n.isDeleted.equals(false) &
              n.createdAt.isBiggerOrEqualValue(start)))
        .get();
    return count.isNotEmpty;
  }

  /// Создаёт заметку. За первую запись за день начисляет небольшой опыт
  /// ([RewardReason.journalEntry]); если задана ось — опыт бустит и её.
  Future<RewardResult?> addNote({
    required String title,
    required String body,
    String? axisId,
    String? mood,
    bool pinned = false,
  }) async {
    final firstToday = !await hasEntryToday();
    await db.into(db.notes).insert(
          NotesCompanion.insert(
            id: _uuid.v4(),
            title: Value(title),
            body: Value(body),
            axisId: Value(axisId),
            mood: Value(mood),
            pinned: Value(pinned),
          ),
        );
    if (!firstToday) return null;
    final reward =
        const RewardResult(xp: _journalDailyXp, gold: 0, gems: 0);
    await rewards.applyReward(
      reward,
      reason: RewardReason.journalEntry,
      axisId: axisId,
    );
    return reward;
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String body,
    String? axisId,
    String? mood,
    required bool pinned,
  }) async {
    await (db.update(db.notes)..where((n) => n.id.equals(id))).write(
      NotesCompanion(
        title: Value(title),
        body: Value(body),
        axisId: Value(axisId),
        mood: Value(mood),
        pinned: Value(pinned),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> togglePin(Note note) async {
    await (db.update(db.notes)..where((n) => n.id.equals(note.id))).write(
      NotesCompanion(
        pinned: Value(!note.pinned),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> softDelete(String id) async {
    await (db.update(db.notes)..where((n) => n.id.equals(id))).write(
      NotesCompanion(
        isDeleted: const Value(true),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> restore(String id) async {
    await (db.update(db.notes)..where((n) => n.id.equals(id))).write(
      NotesCompanion(
        isDeleted: const Value(false),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return NoteRepository(
    ref.watch(databaseProvider),
    ref.watch(rewardServiceProvider),
  );
});

final notesStreamProvider = StreamProvider<List<Note>>((ref) {
  return ref.watch(noteRepositoryProvider).watchNotes();
});

final noteByIdProvider =
    StreamProvider.family<Note?, String>((ref, id) {
  return ref.watch(noteRepositoryProvider).watchNote(id);
});
