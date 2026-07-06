import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rpg_task/core/database/app_database.dart';
import 'package:rpg_task/core/database/seed.dart';
import 'package:rpg_task/core/gamification/balance.dart';
import 'package:rpg_task/core/gamification/reward_service.dart';
import 'package:rpg_task/core/models/enums.dart';
import 'package:rpg_task/core/notifications/notification_service.dart';
import 'package:rpg_task/features/habits/data/habit_repository.dart';
import 'package:rpg_task/features/tasks/data/task_repository.dart';

void main() {
  late AppDatabase db;
  // Уведомления отключены — тесты не трогают нативные плагины.
  final notifications = NotificationService(forceEnabled: false);

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await seedDatabase(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('сидинг создаёт профиль и 6 стандартных осей', () async {
    final profile = await (db.select(db.profiles)
          ..where((p) => p.id.equals(kProfileId)))
        .getSingle();
    expect(profile.totalXp, 0);

    final axes = await db.select(db.skillAxes).get();
    expect(axes, hasLength(6));
  });

  test('завершение задачи начисляет опыт и золото профилю', () async {
    final repo = TaskRepository(db, notifications);
    await repo.addTask(title: 'Тест', difficulty: Difficulty.hard);
    final tasks = await repo.watchTasks().first;
    expect(tasks, hasLength(1));

    final reward = await RewardService(db).completeTask(tasks.first);
    expect(reward.xp, 50);
    expect(reward.gold, 25);

    final profile = await (db.select(db.profiles)
          ..where((p) => p.id.equals(kProfileId)))
        .getSingle();
    expect(profile.totalXp, 50);
    expect(profile.gold, 25);

    final updated = await repo.watchTasks().first;
    expect(updated.first.status, TaskStatus.done);

    final txns = await db.select(db.currencyTransactions).get();
    expect(txns.length, greaterThanOrEqualTo(2)); // xp + gold
  });

  test('опыт задачи начисляется связанной оси навыка', () async {
    final axis = (await db.select(db.skillAxes).get()).first;
    final repo = TaskRepository(db, notifications);
    await repo.addTask(
        title: 'С осью', difficulty: Difficulty.medium, axisId: axis.id);
    final task = (await repo.watchTasks().first).first;

    await RewardService(db).completeTask(task);

    final updatedAxis = await (db.select(db.skillAxes)
          ..where((a) => a.id.equals(axis.id)))
        .getSingle();
    expect(updatedAxis.xp, 25);
  });

  test('завершение привычки создаёт лог и начинает стрик', () async {
    final repo = HabitRepository(db, notifications);
    await repo.addHabit(title: 'Зарядка', difficulty: Difficulty.easy);
    final habit = (await repo.watchHabits().first).first;

    final reward = await RewardService(db).completeHabit(habit);
    expect(reward, isNotNull);

    final updated = (await repo.watchHabits().first).first;
    expect(updated.streakCurrent, 1);
    expect(updated.lastCompletedAt, isNotNull);

    final logs = await db.select(db.habitLogs).get();
    expect(logs, hasLength(1));
  });

  test('повторное выполнение привычки в тот же день не даёт награду', () async {
    final repo = HabitRepository(db, notifications);
    await repo.addHabit(title: 'Чтение', difficulty: Difficulty.easy);
    final habit = (await repo.watchHabits().first).first;

    await RewardService(db).completeHabit(habit);
    final again = (await repo.watchHabits().first).first;
    final secondReward = await RewardService(db).completeHabit(again);
    expect(secondReward, isNull);
  });
}
