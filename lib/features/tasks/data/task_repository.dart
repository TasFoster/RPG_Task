import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/gamification/balance.dart';
import '../../../core/notifications/notification_service.dart';

const _uuid = Uuid();

/// Доступ к задачам в локальной БД.
class TaskRepository {
  final AppDatabase db;
  final NotificationService notifications;
  TaskRepository(this.db, this.notifications);

  /// Активные (не удалённые, не в архиве) задачи:
  /// невыполненные сверху, внутри — новые сверху.
  Stream<List<Task>> watchTasks() {
    return (db.select(db.tasks)
          ..where((t) => t.isDeleted.equals(false) & t.archivedAt.isNull())
          ..orderBy([
            (t) => OrderingTerm(expression: t.status),
            (t) => OrderingTerm(
                expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  /// Архив задач: недавно архивированные сверху.
  Stream<List<Task>> watchArchivedTasks() {
    return (db.select(db.tasks)
          ..where((t) => t.isDeleted.equals(false) & t.archivedAt.isNotNull())
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.archivedAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  /// Перенос задачи в архив (напоминание снимается — задача отложена).
  Future<void> archive(String id) async {
    await (db.update(db.tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        archivedAt: Value(DateTime.now()),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await notifications.cancel(id);
  }

  /// Возврат задачи из архива.
  Future<void> unarchive(String id) async {
    await (db.update(db.tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        archivedAt: const Value(null),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> addTask({
    required String title,
    String? notes,
    String? axisId,
    Difficulty difficulty = Difficulty.auto,
    int estimatedMinutes = 25,
    DateTime? dueAt,
    DateTime? reminderAt,
  }) async {
    final id = _uuid.v4();
    await db.into(db.tasks).insert(
          TasksCompanion.insert(
            id: id,
            title: title,
            notes: Value(notes),
            axisId: Value(axisId),
            difficulty: Value(difficulty),
            estimatedMinutes: Value(estimatedMinutes),
            dueAt: Value(dueAt),
            reminderAt: Value(reminderAt),
          ),
        );
    if (reminderAt != null) {
      await notifications.scheduleTaskReminder(
        entityId: id,
        title: title,
        when: reminderAt,
      );
    }
  }

  /// Редактирование задачи. Переустанавливает напоминание согласно [reminderAt]
  /// (null — снять напоминание).
  Future<void> updateTask({
    required String id,
    required String title,
    String? notes,
    String? axisId,
    required Difficulty difficulty,
    required int estimatedMinutes,
    DateTime? dueAt,
    DateTime? reminderAt,
  }) async {
    await (db.update(db.tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        title: Value(title),
        notes: Value(notes),
        axisId: Value(axisId),
        difficulty: Value(difficulty),
        estimatedMinutes: Value(estimatedMinutes),
        dueAt: Value(dueAt),
        reminderAt: Value(reminderAt),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
    // Перепланируем напоминание: сначала снимаем старое, затем ставим новое.
    await notifications.cancel(id);
    if (reminderAt != null && reminderAt.isAfter(DateTime.now())) {
      await notifications.scheduleTaskReminder(
        entityId: id,
        title: title,
        when: reminderAt,
      );
    }
  }

  /// Отмена напоминания (при выполнении задачи оно больше не нужно).
  Future<void> cancelReminder(String id) => notifications.cancel(id);

  /// Восстановление мягко удалённой задачи (для отмены удаления).
  Future<void> restore(String id) async {
    await (db.update(db.tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        isDeleted: const Value(false),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Мягкое удаление (тумбстоун для будущей синхронизации).
  Future<void> softDelete(String id) async {
    await (db.update(db.tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        isDeleted: const Value(true),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await notifications.cancel(id);
  }
}

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(
    ref.watch(databaseProvider),
    ref.watch(notificationServiceProvider),
  );
});

final tasksStreamProvider = StreamProvider<List<Task>>((ref) {
  return ref.watch(taskRepositoryProvider).watchTasks();
});

final archivedTasksStreamProvider = StreamProvider<List<Task>>((ref) {
  return ref.watch(taskRepositoryProvider).watchArchivedTasks();
});
