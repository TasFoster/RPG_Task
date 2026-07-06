import 'package:flutter_test/flutter_test.dart';
import 'package:rpg_task/core/gamification/balance.dart';
import 'package:rpg_task/core/gamification/gamification_engine.dart';

void main() {
  const engine = GamificationEngine();

  group('Базовый опыт', () {
    test('фиксированная сложность даёт табличные значения', () {
      expect(engine.baseXp(const RewardInput(type: ActivityType.task, difficulty: Difficulty.easy)), 10);
      expect(engine.baseXp(const RewardInput(type: ActivityType.task, difficulty: Difficulty.medium)), 25);
      expect(engine.baseXp(const RewardInput(type: ActivityType.task, difficulty: Difficulty.hard)), 50);
    });

    test('авто-сложность считается по весам', () {
      // task(1.0), daily(0.8), 25 мин -> durFactor=1.0
      // 10*1.0 + 8*0.8 + 7*1.0 = 23.4 -> 23
      final xp = engine.baseXp(const RewardInput(
        type: ActivityType.task,
        difficulty: Difficulty.auto,
        frequency: Frequency.daily,
        estimatedMinutes: 25,
      ));
      expect(xp, 23);
    });
  });

  group('Множители', () {
    test('стрик увеличивает награду, но не бесконечно (кап 30)', () {
      expect(engine.streakMultiplier(0), 1.0);
      expect(engine.streakMultiplier(10), closeTo(1.3, 1e-9));
      expect(engine.streakMultiplier(30), closeTo(1.9, 1e-9));
      expect(engine.streakMultiplier(100), closeTo(1.9, 1e-9)); // кап
    });

    test('регулярность добавляет до +25%', () {
      expect(engine.regularityBonus(0), 1.0);
      expect(engine.regularityBonus(1), closeTo(1.25, 1e-9));
    });
  });

  group('Итоговое начисление', () {
    test('золото ~ половина опыта', () {
      final r = engine.reward(const RewardInput(
        type: ActivityType.task,
        difficulty: Difficulty.hard,
      ));
      expect(r.xp, 50);
      expect(r.gold, 25);
      expect(r.gems, 0);
    });

    test('убийство босса даёт кристаллы и приоритет x1.5', () {
      final r = engine.reward(const RewardInput(
        type: ActivityType.bossHit,
        difficulty: Difficulty.hard,
        isBoss: true,
      ));
      expect(r.xp, 75); // 50 * 1.5
      expect(r.gems, 5);
    });

    test('7-дневный стрик даёт 1 кристалл', () {
      final r = engine.reward(const RewardInput(
        type: ActivityType.habit,
        difficulty: Difficulty.easy,
        streak: 7,
      ));
      expect(r.gems, 1);
    });
  });

  group('Кривая уровней', () {
    test('xpToNext растёт сверхлинейно', () {
      expect(engine.xpToNext(1), 100);
      expect(engine.xpToNext(2), 283);
      expect(engine.xpToNext(4), 800);
    });

    test('levelForXp согласован с totalXpForLevel', () {
      for (var lvl = 1; lvl <= 20; lvl++) {
        final start = engine.totalXpForLevel(lvl);
        expect(engine.levelForXp(start), lvl);
        // на 1 XP меньше — предыдущий уровень
        if (lvl > 1) {
          expect(engine.levelForXp(start - 1), lvl - 1);
        }
      }
    });
  });

  group('Боссы', () {
    test('HP = сумма XP подзадач * 1.2', () {
      expect(engine.bossHp([50, 50, 50]), 180);
    });

    test('штраф отрицательный', () {
      final p = engine.penalty(const RewardInput(
        type: ActivityType.habit,
        difficulty: Difficulty.medium,
      ));
      expect(p, -13); // -(25 * 0.5) = -12.5 -> -13
    });
  });
}
