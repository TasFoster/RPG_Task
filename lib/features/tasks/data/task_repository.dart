import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/gamification/balance.dart';

const _uuid = Uuid();

/// Доступ к задачам в локальной БД.
class TaskRepository {
  final AppDatabase db;
  TaskRepository(this.db);

  /// Активные (не удалённые) задачи: невыполненные сверху, внутри — новые сверху.
  Stream<List<Task>> watchTasks() {
    return (db.select(db.tasks)
          ..where((t) => t.isDeleted.equals(false))
          ..orderBy([
            (t) => OrderingTerm(expression: t.status),
            (t) => OrderingTerm(
                expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Future<void> addTask({
    required String title,
    String? notes,
    String? axisId,
    Difficulty difficulty = Difficulty.auto,
    int estimatedMinutes = 25,
    DateTime? dueAt,
  }) {
    return db.into(db.tasks).insert(
          TasksCompanion.insert(
            id: _uuid.v4(),
            title: title,
            notes: Value(notes),
            axisId: Value(axisId),
            difficulty: Value(difficulty),
            estimatedMinutes: Value(estimatedMinutes),
            dueAt: Value(dueAt),
          ),
        );
  }

  /// Мягкое удаление (тумбстоун для будущей синхронизации).
  Future<void> softDelete(String id) {
    return (db.update(db.tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        isDeleted: const Value(true),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(ref.watch(databaseProvider));
});

final tasksStreamProvider = StreamProvider<List<Task>>((ref) {
  return ref.watch(taskRepositoryProvider).watchTasks();
});
