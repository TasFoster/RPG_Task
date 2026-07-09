import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rpg_task/core/database/app_database.dart';
import 'package:rpg_task/core/database/seed.dart';
import 'package:rpg_task/core/gamification/balance.dart';
import 'package:rpg_task/core/gamification/gamification_engine.dart';
import 'package:rpg_task/core/gamification/reward_service.dart';
import 'package:rpg_task/core/models/enums.dart';
import 'package:rpg_task/features/goals/data/goal_repository.dart';

void main() {
  late AppDatabase db;
  late GoalRepository repo;
  const engine = GamificationEngine();

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await seedDatabase(db);
    repo = GoalRepository(db, RewardService(db), engine);
  });
  tearDown(() => db.close());

  test('HP босса = округл. сумма ожидаемого XP шагов * 1.2', () async {
    final id = await repo.createGoal(title: 'Дракон', isBoss: true);
    await repo.addStep(
        goalId: id, title: 'Шаг 1', difficulty: Difficulty.easy);
    await repo.addStep(
        goalId: id, title: 'Шаг 2', difficulty: Difficulty.easy);

    final goal = await repo.watchGoal(id).first;
    // easy baseXp=10 → sum=20 → hp=round(20*1.2)=24
    expect(goal!.hpTotal, 24);
    expect(goal.hpRemaining, 24);
  });

  test('выполнение всех шагов убивает босса и даёт кристаллы', () async {
    final id = await repo.createGoal(title: 'Дракон', isBoss: true);
    await repo.addStep(
        goalId: id, title: 'Шаг 1', difficulty: Difficulty.easy);
    await repo.addStep(
        goalId: id, title: 'Шаг 2', difficulty: Difficulty.easy);

    var steps = await repo.watchSteps(id).first;
    for (final s in steps) {
      await repo.completeStep(s);
    }

    final goal = await repo.watchGoal(id).first;
    expect(goal!.status, GoalStatus.completed);
    expect(goal.hpRemaining, 0);

    final profile = await (db.select(db.profiles)
          ..where((p) => p.id.equals(kProfileId)))
        .getSingle();
    // Кристаллы приходят только за убийство босса.
    expect(profile.gems, const GamificationBalance().gemsBossKill);
    expect(profile.totalXp, greaterThan(0));
  });

  test('обычная цель (не босс) завершается без кристаллов', () async {
    final id = await repo.createGoal(title: 'Ремонт', isBoss: false);
    await repo.addStep(goalId: id, title: 'Шаг', difficulty: Difficulty.easy);
    final steps = await repo.watchSteps(id).first;
    await repo.completeStep(steps.first);

    final goal = await repo.watchGoal(id).first;
    expect(goal!.status, GoalStatus.completed);

    final profile = await (db.select(db.profiles)
          ..where((p) => p.id.equals(kProfileId)))
        .getSingle();
    expect(profile.gems, 0);
  });

  test('удаление невыполненного шага НЕ убивает босса', () async {
    final id = await repo.createGoal(title: 'Дракон', isBoss: true);
    await repo.addStep(
        goalId: id, title: 'Шаг 1', difficulty: Difficulty.easy);
    await repo.addStep(
        goalId: id, title: 'Шаг 2', difficulty: Difficulty.easy);

    var steps = await repo.watchSteps(id).first;
    await repo.completeStep(steps.first);

    steps = await repo.watchSteps(id).first;
    final pending =
        steps.firstWhere((s) => s.status == TaskStatus.pending);
    await repo.softDeleteStep(pending);

    final goal = await repo.watchGoal(id).first;
    // Босс повержен только выполнением шагов, а не их удалением.
    expect(goal!.status, GoalStatus.active);
  });

  test('completeStep сообщает о победе над боссом', () async {
    final id = await repo.createGoal(title: 'Дракон', isBoss: true);
    await repo.addStep(goalId: id, title: 'Шаг', difficulty: Difficulty.easy);
    final steps = await repo.watchSteps(id).first;
    final result = await repo.completeStep(steps.first);
    expect(result.goalCompleted, isTrue);
    expect(result.isBoss, isTrue);
  });

  test('снятие шага переоткрывает босса и откатывает награды', () async {
    final id = await repo.createGoal(title: 'Дракон', isBoss: true);
    await repo.addStep(goalId: id, title: 'Шаг', difficulty: Difficulty.easy);
    var steps = await repo.watchSteps(id).first;
    await repo.completeStep(steps.first);

    steps = await repo.watchSteps(id).first;
    await repo.uncompleteStep(steps.first);

    final goal = await repo.watchGoal(id).first;
    expect(goal!.status, GoalStatus.active);
    expect(goal.hpRemaining, greaterThan(0));

    final step = (await repo.watchSteps(id).first).first;
    expect(step.status, TaskStatus.pending);

    final profile = await (db.select(db.profiles)
          ..where((p) => p.id.equals(kProfileId)))
        .getSingle();
    // Награда шага и бонус за босса (XP, золото, кристаллы) откатились.
    expect(profile.gems, 0);
    expect(profile.totalXp, 0);
    expect(profile.gold, 0);
  });
}
