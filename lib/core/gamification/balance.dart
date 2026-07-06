// Баланс геймификации: все стартовые коэффициенты в одном месте для удобного тюнинга.
// См. docs/GAMIFICATION_RU.md

/// Сложность активности.
enum Difficulty { easy, medium, hard, auto }

/// Тип активности (влияет на авто-оценку сложности).
enum ActivityType { task, habit, goalStep, bossHit }

/// Периодичность (влияет на авто-оценку: чем реже, тем ценнее).
enum Frequency { daily, weekly, rare }

/// Стартовые коэффициенты геймификации.
class GamificationBalance {
  const GamificationBalance();

  // Базовый опыт за фиксированную сложность.
  int get baseXpEasy => 10;
  int get baseXpMedium => 25;
  int get baseXpHard => 50;

  // Веса авто-оценки сложности.
  double get weightType => 10;
  double get weightFreq => 8;
  double get weightDur => 7;

  // Коэффициент длительности: minutes / pomodoroMinutes, ограничен [durMin, durMax].
  double get pomodoroMinutes => 25;
  double get durMin => 0.5;
  double get durMax => 3.0;

  // Множители.
  int get streakCap => 30;
  double get streakStep => 0.03; // +3% за день стрика, максимум +90%
  double get regularityWeight => 0.25; // до +25% за регулярность
  double get bossPriority => 1.5;

  // Валюта.
  double get goldPerXp => 0.5;
  int get gemsBossKill => 5;
  int get gemsStreak7 => 1;
  int get gemsStreak30 => 5;
  double get penaltyFactor => 0.5; // штраф = -baseXp * 0.5

  // Кривая уровней: xpToNext = levelBase * level^levelExp.
  double get levelBase => 100;
  double get levelExp => 1.5;

  // Боссы.
  double get bossHpFactor => 1.2; // hp = sum(ожидаемый XP подзадач) * 1.2
  double get bossKillXpBonus => 0.2; // бонус = hp_total * 0.2
}
