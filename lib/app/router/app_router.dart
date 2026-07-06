import 'package:go_router/go_router.dart';

import '../../features/tasks/presentation/tasks_screen.dart';
import '../../features/habits/presentation/habits_screen.dart';
import '../../features/skills/presentation/skills_screen.dart';
import '../../features/character/presentation/character_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/pomodoro/presentation/pomodoro_screen.dart';
import '../../features/goals/presentation/goals_screen.dart';
import '../../features/goals/presentation/goal_detail_screen.dart';
import '../../features/quests/presentation/quests_screen.dart';
import '../../features/achievements/presentation/achievements_screen.dart';
import '../../features/shop/presentation/shop_screen.dart';
import '../widgets/home_shell.dart';

/// Конфигурация навигации приложения.
final GoRouter appRouter = GoRouter(
  initialLocation: '/tasks',
  routes: [
    // Полноэкранные push-роуты (поверх нижней навигации).
    GoRoute(
      path: '/pomodoro',
      builder: (context, state) => const PomodoroScreen(),
    ),
    GoRoute(
      path: '/goals',
      builder: (context, state) => const GoalsScreen(),
    ),
    GoRoute(
      path: '/goals/:id',
      builder: (context, state) =>
          GoalDetailScreen(goalId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/quests',
      builder: (context, state) => const QuestsScreen(),
    ),
    GoRoute(
      path: '/achievements',
      builder: (context, state) => const AchievementsScreen(),
    ),
    GoRoute(
      path: '/shop',
      builder: (context, state) => const ShopScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tasks',
              builder: (context, state) => const TasksScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/habits',
              builder: (context, state) => const HabitsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/skills',
              builder: (context, state) => const SkillsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/character',
              builder: (context, state) => const CharacterScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
