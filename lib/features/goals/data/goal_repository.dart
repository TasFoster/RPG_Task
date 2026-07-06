import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/gamification/balance.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../../core/gamification/reward_service.dart';
import '../../../core/models/enums.dart';

const _uuid = Uuid();

/// Доступ к целям и боссам. HP босса — производная от ожидаемого XP шагов:
/// hpRemaining пересчитывается как «босс-HP невыполненных шагов».
class GoalRepository {
  final AppDatabase db;
  final RewardService rewards;
  final GamificationEngine engine;

  GoalRepository(this.db, this.rewards, [this.engine = const GamificationEngine()]);

  Stream<List<Goal>> watchGoals() {
    return (db.select(db.goals)
          ..where((g) => g.isDeleted.equals(false))
          ..orderBy([
            (g) => OrderingTerm(expression: g.status),
            (g) => OrderingTerm(
                expression: g.createdAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Stream<Goal?> watchGoal(String id) {
    return (db.select(db.goals)..where((g) => g.id.equals(id)))
        .watchSingleOrNull();
  }

  Stream<List<GoalStep>> watchSteps(String goalId) {
    return (db.select(db.goalSteps)
          ..where((s) => s.goalId.equals(goalId) & s.isDeleted.equals(false))
          ..orderBy([(s) => OrderingTerm(expression: s.sortOrder)]))
        .watch();
  }

  Future<String> createGoal({
    required String title,
    String? notes,
    String? axisId,
    bool isBoss = false,
  }) async {
    final id = _uuid.v4();
    await db.into(db.goals).insert(
          GoalsCompanion.insert(
            id: id,
            title: title,
            notes: Value(notes),
            axisId: Value(axisId),
            isBoss: Value(isBoss),
          ),
        );
    return id;
  }

  Future<void> addStep({
    required String goalId,
    required String title,
    Difficulty difficulty = Difficulty.auto,
    int estimatedMinutes = 25,
  }) async {
    final goal = await _goalById(goalId);
    if (goal == null) return;
    final expectedXp = engine.baseXp(RewardInput(
      type: ActivityType.goalStep,
      difficulty: difficulty,
      frequency: Frequency.rare,
      estimatedMinutes: estimatedMinutes,
    ));
    final count = await _stepCount(goalId);
    await db.into(db.goalSteps).insert(
          GoalStepsCompanion.insert(
            id: _uuid.v4(),
            goalId: goalId,
            title: title,
            difficulty: Value(difficulty),
            estimatedMinutes: Value(estimatedMinutes),
            expectedXp: Value(expectedXp),
            sortOrder: Value(count),
          ),
        );
    await _recomputeHp(goalId);
  }

  /// Выполнение шага: начисляет XP, наносит урон боссу, при завершении
  /// всех шагов закрывает цель (босс — с бонусом и кристаллами).
  Future<RewardResult> completeStep(GoalStep step) async {
    final goal = await _goalById(step.goalId);

    // Награда за сам шаг — обычная (без множителя/кристаллов босса).
    // Кристаллы и бонус за босса начисляются только при убийстве.
    final reward = engine.reward(RewardInput(
      type: ActivityType.goalStep,
      difficulty: step.difficulty,
      frequency: Frequency.rare,
      estimatedMinutes: step.estimatedMinutes,
    ));
    await rewards.applyReward(reward,
        reason: RewardReason.goalStep, refId: step.id, axisId: goal?.axisId);

    await (db.update(db.goalSteps)..where((s) => s.id.equals(step.id))).write(
      GoalStepsCompanion(
        status: const Value(TaskStatus.done),
        completedAt: Value(DateTime.now()),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await _recomputeHp(step.goalId);
    await _maybeComplete(step.goalId);
    return reward;
  }

  Future<void> softDeleteGoal(String id) {
    return (db.update(db.goals)..where((g) => g.id.equals(id))).write(
      GoalsCompanion(
        isDeleted: const Value(true),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  // ---- Внутреннее ----

  Future<Goal?> _goalById(String id) =>
      (db.select(db.goals)..where((g) => g.id.equals(id))).getSingleOrNull();

  Future<int> _stepCount(String goalId) async {
    final steps = await (db.select(db.goalSteps)
          ..where((s) => s.goalId.equals(goalId) & s.isDeleted.equals(false)))
        .get();
    return steps.length;
  }

  Future<void> _recomputeHp(String goalId) async {
    final goal = await _goalById(goalId);
    if (goal == null) return;
    final steps = await (db.select(db.goalSteps)
          ..where((s) => s.goalId.equals(goalId) & s.isDeleted.equals(false)))
        .get();
    final all = steps.map((s) => s.expectedXp);
    final pending = steps
        .where((s) => s.status == TaskStatus.pending)
        .map((s) => s.expectedXp);
    int hp(Iterable<int> xps) =>
        goal.isBoss ? engine.bossHp(xps) : xps.fold(0, (a, b) => a + b);
    await (db.update(db.goals)..where((g) => g.id.equals(goalId))).write(
      GoalsCompanion(
        hpTotal: Value(hp(all)),
        hpRemaining: Value(hp(pending)),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> _maybeComplete(String goalId) async {
    final goal = await _goalById(goalId);
    if (goal == null || goal.status == GoalStatus.completed) return;
    final steps = await (db.select(db.goalSteps)
          ..where((s) => s.goalId.equals(goalId) & s.isDeleted.equals(false)))
        .get();
    if (steps.isEmpty) return;
    final pending = steps.where((s) => s.status == TaskStatus.pending).length;
    if (pending > 0) return;

    await (db.update(db.goals)..where((g) => g.id.equals(goalId))).write(
      GoalsCompanion(
        status: const Value(GoalStatus.completed),
        completedAt: Value(DateTime.now()),
        hpRemaining: const Value(0),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );

    if (goal.isBoss) {
      final bonusXp = engine.bossKillBonus(goal.hpTotal);
      await rewards.applyReward(
        RewardResult(
          xp: bonusXp,
          gold: (bonusXp * engine.b.goldPerXp).round(),
          gems: engine.b.gemsBossKill,
        ),
        reason: RewardReason.bossKilled,
        refId: goalId,
        axisId: goal.axisId,
      );
    }
  }
}

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return GoalRepository(
    ref.watch(databaseProvider),
    ref.watch(rewardServiceProvider),
  );
});

final goalsStreamProvider = StreamProvider<List<Goal>>((ref) {
  return ref.watch(goalRepositoryProvider).watchGoals();
});

final goalStreamProvider =
    StreamProvider.family<Goal?, String>((ref, id) {
  return ref.watch(goalRepositoryProvider).watchGoal(id);
});

final goalStepsStreamProvider =
    StreamProvider.family<List<GoalStep>, String>((ref, goalId) {
  return ref.watch(goalRepositoryProvider).watchSteps(goalId);
});
