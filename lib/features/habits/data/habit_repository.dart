import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/gamification/balance.dart';
import '../../../core/models/enums.dart';
import '../../../core/notifications/notification_service.dart';

const _uuid = Uuid();

/// Доступ к привычкам в локальной БД.
class HabitRepository {
  final AppDatabase db;
  final NotificationService notifications;
  HabitRepository(this.db, this.notifications);

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
    int? reminderMinutes,
  }) async {
    final id = _uuid.v4();
    await db.into(db.habits).insert(
          HabitsCompanion.insert(
            id: id,
            title: title,
            axisId: Value(axisId),
            type: Value(type),
            frequency: Value(frequency),
            difficulty: Value(difficulty),
            reminderMinutes: Value(reminderMinutes),
          ),
        );
    if (reminderMinutes != null) {
      await notifications.scheduleDailyHabitReminder(
        entityId: id,
        title: title,
        minuteOfDay: reminderMinutes,
      );
    }
  }

  Future<void> softDelete(String id) async {
    await (db.update(db.habits)..where((h) => h.id.equals(id))).write(
      HabitsCompanion(
        isDeleted: const Value(true),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await notifications.cancel(id);
  }
}

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  return HabitRepository(
    ref.watch(databaseProvider),
    ref.watch(notificationServiceProvider),
  );
});

final habitsStreamProvider = StreamProvider<List<Habit>>((ref) {
  return ref.watch(habitRepositoryProvider).watchHabits();
});
