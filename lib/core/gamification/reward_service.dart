import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';
import '../database/seed.dart';
import '../models/enums.dart';
import 'balance.dart';
import 'gamification_engine.dart';

const _uuid = Uuid();

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Применяет награды (опыт/валюту) к профилю, осям и журналам транзакций.
/// Все операции идут в одной транзакции — состояние всегда согласовано.
class RewardService {
  final AppDatabase db;
  final GamificationEngine engine;

  RewardService(this.db, [this.engine = const GamificationEngine()]);

  /// Завершение задачи: считает награду, помечает выполненной, начисляет ресурсы.
  Future<RewardResult> completeTask(Task task) {
    return db.transaction(() async {
      final input = RewardInput(
        type: ActivityType.task,
        difficulty: task.difficulty,
        frequency: Frequency.rare, // разовая активность
        estimatedMinutes: task.estimatedMinutes,
      );
      final reward = engine.reward(input);
      final now = DateTime.now();

      await (db.update(db.tasks)..where((t) => t.id.equals(task.id))).write(
        TasksCompanion(
          status: const Value(TaskStatus.done),
          completedAt: Value(now),
          xpAwarded: Value(reward.xp),
          goldAwarded: Value(reward.gold),
          dirty: const Value(true),
          updatedAt: Value(now),
        ),
      );

      await _applyRewards(reward,
          reason: RewardReason.taskCompleted,
          refId: task.id,
          axisId: task.axisId);
      return reward;
    });
  }

  /// Завершение привычки за сегодня. Возвращает null, если уже выполнена сегодня.
  Future<RewardResult?> completeHabit(Habit habit) {
    return db.transaction(() async {
      final now = DateTime.now();
      final today = _dateOnly(now);

      int newStreak;
      if (habit.lastCompletedAt != null) {
        final diff = today.difference(_dateOnly(habit.lastCompletedAt!)).inDays;
        if (diff == 0) return null; // уже выполнено сегодня
        newStreak = diff == 1 ? habit.streakCurrent + 1 : 1;
      } else {
        newStreak = 1;
      }

      final input = RewardInput(
        type: ActivityType.habit,
        difficulty: habit.difficulty,
        frequency: habit.frequency,
        streak: newStreak,
      );
      final reward = engine.reward(input);

      await (db.update(db.habits)..where((h) => h.id.equals(habit.id))).write(
        HabitsCompanion(
          streakCurrent: Value(newStreak),
          streakBest: Value(math.max(newStreak, habit.streakBest)),
          lastCompletedAt: Value(now),
          dirty: const Value(true),
          updatedAt: Value(now),
        ),
      );

      await db.into(db.habitLogs).insert(
            HabitLogsCompanion.insert(
              id: _uuid.v4(),
              habitId: habit.id,
              value: const Value(1),
              xp: Value(reward.xp),
              gold: Value(reward.gold),
            ),
          );

      await _applyRewards(reward,
          reason: RewardReason.habitCompleted,
          refId: habit.id,
          axisId: habit.axisId);
      return reward;
    });
  }

  /// Начисление за завершённый фокус-сеанс (помодоро) на [minutes] минут.
  /// Опционально относится к оси навыка [axisId].
  Future<RewardResult> awardFocusSession({
    required int minutes,
    String? axisId,
  }) {
    return db.transaction(() async {
      final reward = engine.reward(RewardInput(
        type: ActivityType.task,
        difficulty: Difficulty.auto,
        frequency: Frequency.rare,
        estimatedMinutes: minutes,
      ));
      await _applyRewards(reward,
          reason: RewardReason.focusSession, axisId: axisId);
      return reward;
    });
  }

  /// Публичное начисление произвольной награды в одной транзакции
  /// (для квестов, достижений, шагов целей и т.п.).
  Future<void> applyReward(
    RewardResult reward, {
    required RewardReason reason,
    String? refId,
    String? axisId,
  }) {
    return db.transaction(
        () => _applyRewards(reward, reason: reason, refId: refId, axisId: axisId));
  }

  Future<void> _applyRewards(
    RewardResult reward, {
    required RewardReason reason,
    String? refId,
    String? axisId,
  }) async {
    final now = DateTime.now();
    final profile = await (db.select(db.profiles)
          ..where((p) => p.id.equals(kProfileId)))
        .getSingle();

    await (db.update(db.profiles)..where((p) => p.id.equals(kProfileId))).write(
      ProfilesCompanion(
        totalXp: Value(profile.totalXp + reward.xp),
        gold: Value(profile.gold + reward.gold),
        gems: Value(profile.gems + reward.gems),
        dirty: const Value(true),
        updatedAt: Value(now),
      ),
    );

    if (axisId != null && reward.xp != 0) {
      final axis = await (db.select(db.skillAxes)
            ..where((a) => a.id.equals(axisId)))
          .getSingleOrNull();
      if (axis != null) {
        await (db.update(db.skillAxes)..where((a) => a.id.equals(axisId)))
            .write(SkillAxesCompanion(
          xp: Value(axis.xp + reward.xp),
          dirty: const Value(true),
          updatedAt: Value(now),
        ));
      }
    }

    await _logCurrency(CurrencyKind.xp, reward.xp, reason, refId);
    await _logCurrency(CurrencyKind.gold, reward.gold, reason, refId);
    await _logCurrency(CurrencyKind.gems, reward.gems, reason, refId);
  }

  Future<void> _logCurrency(
      CurrencyKind kind, int amount, RewardReason reason, String? refId) async {
    if (amount == 0) return;
    await db.into(db.currencyTransactions).insert(
          CurrencyTransactionsCompanion.insert(
            id: _uuid.v4(),
            kind: kind,
            amount: amount,
            reason: reason,
            refEntity: Value(refId),
          ),
        );
  }
}

final rewardServiceProvider = Provider<RewardService>((ref) {
  return RewardService(ref.watch(databaseProvider));
});
