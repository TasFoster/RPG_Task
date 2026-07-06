/// Статус задачи.
enum TaskStatus { pending, done }

/// Тип привычки: полезная (награда за выполнение) или вредная (штраф).
enum HabitType { positive, negative }

/// Вид внутренней валюты / ресурса.
enum CurrencyKind { xp, gold, gems }

/// Причина начисления/списания (для журнала транзакций).
enum RewardReason {
  taskCompleted,
  habitCompleted,
  habitFailed,
  goalStep,
  bossKilled,
  streakBonus,
  achievement,
  dailyQuest,
  focusSession,
  purchase,
  manual,
}
