# Геймификация: формулы наград и прогрессии

Все коэффициенты — **стартовые** и вынесены в `lib/core/gamification/balance.dart` для тюнинга.
Движок реализован чистыми функциями (легко тестируется).

## Базовый опыт за выполнение

```
baseXp: easy = 10, medium = 25, hard = 50
```

Если сложность = `auto`, оценивается автоматически:
```
autoScore = 10*typeFactor + 8*freqFactor + 7*durFactor

typeFactor: task = 1.0, habit = 0.8, goal-step = 1.3, boss-hit = 2.0
freqFactor: daily = 0.8, weekly = 1.2, редко/one-off = 1.5
durFactor:  clamp(estimatedMinutes / 25, 0.5, 3.0)   // 25 минут = 1 «помидор»
```

## Множители

```
streakMultiplier   = 1 + min(streak, 30) * 0.03      // до +90% при 30-дневном стрике
regularityBonus    = 1 + consistency30d * 0.25       // consistency30d ∈ [0..1] — доля дней с выполнением за 30 дней
priorityMultiplier = boss ? 1.5 : 1.0
```

## Итоговое начисление

```
finalXp = round(baseXp * streakMultiplier * regularityBonus * priorityMultiplier)
gold    = round(finalXp * 0.5)

gems (премиум-валюта, редко):
  - убийство босса        = 5
  - 7-дневный стрик       = 1
  - 30-дневный стрик      = 5
  - за достижения         = по каталогу

Штраф (negative-привычка / пропуск):
  xp -= round(baseXp * 0.5)   // не ниже пола текущего уровня
  стрик сбрасывается
```

## Кривая уровней

Общая формула для персонажа и для каждой оси навыков:
```
xpToNext(level)      = round(100 * level^1.5)
totalXpForLevel(L)   = сумма xpToNext(1..L-1)
```
Примеры: L1→2 = 100, L2→3 ≈ 283, L3→4 = 520, L5 ≈ 1118, L10 ≈ 3162, L20 ≈ 8944, L50 ≈ 35355.

Текущий уровень вычисляется из накопленного `total_xp` итерацией/бинарным поиском.
«Роза навыков» отображает уровень (или нормализованный XP) по каждой оси.

## Боссы (крупные цели)

```
boss.hp_total = Σ(ожидаемый XP подзадач) * 1.2
урон за подзадачу = finalXp этой подзадачи
kill (hp_current <= 0) → reward_gems + бонусный XP (напр. +boss.hp_total * 0.2)
```
