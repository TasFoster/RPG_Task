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

  /// Редактирование привычки. Напоминание перепланируется (или снимается).
  /// Смена сложности/периодичности влияет только на будущие награды.
  Future<void> updateHabit({
    required String id,
    required String title,
    String? axisId,
    Frequency frequency = Frequency.daily,
    Difficulty difficulty = Difficulty.auto,
    int? reminderMinutes,
  }) async {
    await (db.update(db.habits)..where((h) => h.id.equals(id))).write(
      HabitsCompanion(
        title: Value(title),
        axisId: Value(axisId),
        frequency: Value(frequency),
        difficulty: Value(difficulty),
        reminderMinutes: Value(reminderMinutes),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
    if (reminderMinutes != null) {
      await notifications.scheduleDailyHabitReminder(
        entityId: id,
        title: title,
        minuteOfDay: reminderMinutes,
      );
    } else {
      await notifications.cancel(id);
    }
  }

  /// Дата без времени (ключ дня для хитмапа).
  static DateTime dayOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  /// Поток «количество выполнений по дням» для хитмапа.
  /// [habitId] == null — сводка по всем привычкам («жизнь героя»).
  Stream<Map<DateTime, int>> watchDailyCounts({String? habitId}) {
    final query = db.select(db.habitLogs)
      ..where((l) => l.value.isBiggerThanValue(0));
    if (habitId != null) {
      query.where((l) => l.habitId.equals(habitId));
    }
    return query.watch().map((logs) {
      final map = <DateTime, int>{};
      for (final l in logs) {
        final d = dayOnly(l.completedAt);
        map[d] = (map[d] ?? 0) + 1;
      }
      return map;
    });
  }

  Future<Habit?> habitById(String id) {
    return (db.select(db.habits)..where((h) => h.id.equals(id)))
        .getSingleOrNull();
  }

  Stream<Habit?> watchHabit(String id) {
    return (db.select(db.habits)..where((h) => h.id.equals(id)))
        .watchSingleOrNull();
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

/// Хитмап выполнений по дням. Ключ семьи — id привычки или null (сводка).
final habitHeatmapProvider =
    StreamProvider.family<Map<DateTime, int>, String?>((ref, habitId) {
  return ref.watch(habitRepositoryProvider).watchDailyCounts(habitId: habitId);
});

final habitByIdProvider =
    StreamProvider.family<Habit?, String>((ref, id) {
  return ref.watch(habitRepositoryProvider).watchHabit(id);
});
