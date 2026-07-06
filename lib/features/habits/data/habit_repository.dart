import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/gamification/balance.dart';
import '../../../core/models/enums.dart';

const _uuid = Uuid();

/// Доступ к привычкам в локальной БД.
class HabitRepository {
  final AppDatabase db;
  HabitRepository(this.db);

  Stream<List<Habit>> watchHabits() {
    return (db.select(db.habits)
          ..where((h) => h.isDeleted.equals(false))
          ..orderBy([
            (h) => OrderingTerm(
                expression: h.createdAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Future<void> addHabit({
    required String title,
    String? axisId,
    HabitType type = HabitType.positive,
    Frequency frequency = Frequency.daily,
    Difficulty difficulty = Difficulty.auto,
  }) {
    return db.into(db.habits).insert(
          HabitsCompanion.insert(
            id: _uuid.v4(),
            title: title,
            axisId: Value(axisId),
            type: Value(type),
            frequency: Value(frequency),
            difficulty: Value(difficulty),
          ),
        );
  }

  Future<void> softDelete(String id) {
    return (db.update(db.habits)..where((h) => h.id.equals(id))).write(
      HabitsCompanion(
        isDeleted: const Value(true),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  return HabitRepository(ref.watch(databaseProvider));
});

final habitsStreamProvider = StreamProvider<List<Habit>>((ref) {
  return ref.watch(habitRepositoryProvider).watchHabits();
});
