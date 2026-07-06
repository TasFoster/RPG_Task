import 'dart:math' as math;
import 'balance.dart';

/// Входные данные для расчёта награды за одну выполненную активность.
class RewardInput {
  final ActivityType type;
  final Difficulty difficulty;
  final Frequency frequency;
  final int estimatedMinutes;
  final int streak; // текущая длина серии (в днях)
  final double consistency30d; // доля дней с выполнением за 30 дней [0..1]
  final bool isBoss;

  const RewardInput({
    required this.type,
    this.difficulty = Difficulty.auto,
    this.frequency = Frequency.daily,
    this.estimatedMinutes = 25,
    this.streak = 0,
    this.consistency30d = 0,
    this.isBoss = false,
  });
}

/// Результат начисления.
class RewardResult {
  final int xp;
  final int gold;
  final int gems;
  const RewardResult({required this.xp, required this.gold, required this.gems});

  @override
  String toString() => 'RewardResult(xp: $xp, gold: $gold, gems: $gems)';
}

/// Чистый движок геймификации. Без побочных эффектов — легко тестируется.
class GamificationEngine {
  final GamificationBalance b;
  const GamificationEngine([this.b = const GamificationBalance()]);

  double _typeFactor(ActivityType t) => switch (t) {
        ActivityType.task => 1.0,
        ActivityType.habit => 0.8,
        ActivityType.goalStep => 1.3,
        ActivityType.bossHit => 2.0,
      };

  double _freqFactor(Frequency f) => switch (f) {
        Frequency.daily => 0.8,
        Frequency.weekly => 1.2,
        Frequency.rare => 1.5,
      };

  double _durFactor(int minutes) =>
      (minutes / b.pomodoroMinutes).clamp(b.durMin, b.durMax);

  /// Базовый XP: фиксированный по сложности или авто-оценка.
  int baseXp(RewardInput i) {
    switch (i.difficulty) {
      case Difficulty.easy:
        return b.baseXpEasy;
      case Difficulty.medium:
        return b.baseXpMedium;
      case Difficulty.hard:
        return b.baseXpHard;
      case Difficulty.auto:
        final score = b.weightType * _typeFactor(i.type) +
            b.weightFreq * _freqFactor(i.frequency) +
            b.weightDur * _durFactor(i.estimatedMinutes);
        return score.round();
    }
  }

  double streakMultiplier(int streak) =>
      1 + math.min(streak, b.streakCap) * b.streakStep;

  double regularityBonus(double consistency30d) =>
      1 + consistency30d.clamp(0, 1) * b.regularityWeight;

  /// Итоговое начисление за выполнение.
  RewardResult reward(RewardInput i) {
    final base = baseXp(i);
    final priority = i.isBoss ? b.bossPriority : 1.0;
    final xp = (base *
            streakMultiplier(i.streak) *
            regularityBonus(i.consistency30d) *
            priority)
        .round();
    final gold = (xp * b.goldPerXp).round();

    var gems = 0;
    if (i.isBoss) gems += b.gemsBossKill;
    if (i.streak == 7) gems += b.gemsStreak7;
    if (i.streak == 30) gems += b.gemsStreak30;

    return RewardResult(xp: xp, gold: gold, gems: gems);
  }

  /// Штраф за пропуск / negative-привычку (XP отрицательный).
  int penalty(RewardInput i) => -(baseXp(i) * b.penaltyFactor).round();

  // ---- Кривая уровней ----

  /// Сколько XP нужно, чтобы уйти с [level] на [level] + 1.
  int xpToNext(int level) =>
      (b.levelBase * math.pow(level, b.levelExp)).round();

  /// Суммарный XP, необходимый для достижения [level] (считая с 1-го).
  int totalXpForLevel(int level) {
    var sum = 0;
    for (var l = 1; l < level; l++) {
      sum += xpToNext(l);
    }
    return sum;
  }

  /// Текущий уровень по накопленному [totalXp].
  int levelForXp(int totalXp) {
    var level = 1;
    var acc = 0;
    while (true) {
      final need = xpToNext(level);
      if (acc + need > totalXp) break;
      acc += need;
      level++;
    }
    return level;
  }

  // ---- Боссы ----

  /// Полное HP босса по ожидаемому XP подзадач.
  int bossHp(Iterable<int> subtaskXps) =>
      (subtaskXps.fold<int>(0, (a, x) => a + x) * b.bossHpFactor).round();

  /// Бонусный XP за убийство босса.
  int bossKillBonus(int bossHpTotal) =>
      (bossHpTotal * b.bossKillXpBonus).round();
}
