import 'package:flutter/material.dart';

/// Сводка показателей игрока для проверки условий достижений.
class AchievementStats {
  final int totalXp;
  final int level;
  final int tasksDone;
  final int habitBestStreak;
  final int bossesKilled;
  final int focusSessions;

  const AchievementStats({
    required this.totalXp,
    required this.level,
    required this.tasksDone,
    required this.habitBestStreak,
    required this.bossesKilled,
    required this.focusSessions,
  });
}

/// Определение достижения (статическое, в коде). id хранится в БД при разблокировке.
class AchievementDef {
  final String key;
  final String title;
  final String description;
  final IconData icon;
  final int rewardGems;
  final int rewardXp;
  final bool Function(AchievementStats s) isUnlocked;

  const AchievementDef({
    required this.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.rewardGems,
    required this.rewardXp,
    required this.isUnlocked,
  });
}

/// Каталог достижений.
const List<AchievementDef> kAchievements = [
  AchievementDef(
    key: 'first_task',
    title: 'Первый шаг',
    description: 'Выполните первую задачу',
    icon: Icons.emoji_events,
    rewardGems: 1,
    rewardXp: 10,
    isUnlocked: _firstTask,
  ),
  AchievementDef(
    key: 'ten_tasks',
    title: 'Продуктивность',
    description: 'Выполните 10 задач',
    icon: Icons.workspace_premium,
    rewardGems: 2,
    rewardXp: 25,
    isUnlocked: _tenTasks,
  ),
  AchievementDef(
    key: 'streak_7',
    title: 'Неделя дисциплины',
    description: 'Серия привычки 7 дней',
    icon: Icons.local_fire_department,
    rewardGems: 2,
    rewardXp: 25,
    isUnlocked: _streak7,
  ),
  AchievementDef(
    key: 'streak_30',
    title: 'Железная воля',
    description: 'Серия привычки 30 дней',
    icon: Icons.whatshot,
    rewardGems: 5,
    rewardXp: 100,
    isUnlocked: _streak30,
  ),
  AchievementDef(
    key: 'level_5',
    title: 'Искатель',
    description: 'Достигните 5 уровня',
    icon: Icons.military_tech,
    rewardGems: 3,
    rewardXp: 0,
    isUnlocked: _level5,
  ),
  AchievementDef(
    key: 'first_boss',
    title: 'Победитель боссов',
    description: 'Победите первого босса',
    icon: Icons.shield,
    rewardGems: 3,
    rewardXp: 30,
    isUnlocked: _firstBoss,
  ),
  AchievementDef(
    key: 'focus_10',
    title: 'В потоке',
    description: 'Завершите 10 фокус-сессий',
    icon: Icons.timer,
    rewardGems: 3,
    rewardXp: 30,
    isUnlocked: _focus10,
  ),
];

// Условия вынесены в top-level функции — const-список требует const-tearoff'ов.
bool _firstTask(AchievementStats s) => s.tasksDone >= 1;
bool _tenTasks(AchievementStats s) => s.tasksDone >= 10;
bool _streak7(AchievementStats s) => s.habitBestStreak >= 7;
bool _streak30(AchievementStats s) => s.habitBestStreak >= 30;
bool _level5(AchievementStats s) => s.level >= 5;
bool _firstBoss(AchievementStats s) => s.bossesKilled >= 1;
bool _focus10(AchievementStats s) => s.focusSessions >= 10;
