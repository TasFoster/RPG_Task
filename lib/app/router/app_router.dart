import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/tasks/presentation/tasks_screen.dart';
import '../../features/habits/presentation/habits_screen.dart';
import '../../features/habits/presentation/habit_detail_screen.dart';
import '../../features/skills/presentation/skills_screen.dart';
import '../../features/skills/presentation/axes_manager_screen.dart';
import '../../features/character/presentation/character_screen.dart';
import '../../features/stats/presentation/stats_screen.dart';
import '../../features/seasons/presentation/season_hall_screen.dart';
import '../../features/auth/presentation/account_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/pomodoro/presentation/pomodoro_screen.dart';
import '../../features/goals/presentation/goals_screen.dart';
import '../../features/goals/presentation/goal_detail_screen.dart';
import '../../features/quests/presentation/quests_screen.dart';
import '../../features/achievements/presentation/achievements_screen.dart';
import '../../features/shop/presentation/shop_screen.dart';
import '../../features/codex/presentation/codex_screen.dart';
import '../../features/sleep/presentation/sleep_screen.dart';
import '../../features/sleep/presentation/chronotype_screen.dart';
import '../../features/notes/presentation/notes_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../widgets/home_shell.dart';

/// Корневой ключ навигатора — нужен, чтобы показывать глобальные диалоги
/// (например, модалку рефлексии по тапу на пуш) вне контекста конкретного экрана.
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// Строит конфигурацию навигации. [initialLocation] задаётся при старте
/// (например, '/onboarding' при первом запуске).
GoRouter buildAppRouter({String initialLocation = '/tasks'}) => GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: initialLocation,
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    // Полноэкранные push-роуты (поверх нижней навигации).
    GoRoute(
      path: '/pomodoro',
      builder: (context, state) => const PomodoroScreen(),
    ),
    GoRoute(
      path: '/skills/manage',
      builder: (context, state) => const AxesManagerScreen(),
    ),
    GoRoute(
      path: '/stats',
      builder: (context, state) => const StatsScreen(),
    ),
    GoRoute(
      path: '/seasons',
      builder: (context, state) => const SeasonHallScreen(),
    ),
    GoRoute(
      path: '/account',
      builder: (context, state) => const AccountScreen(),
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
    GoRoute(
      path: '/codex',
      builder: (context, state) => const CodexScreen(),
    ),
    GoRoute(
      path: '/habit/:id',
      builder: (context, state) =>
          HabitDetailScreen(habitId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/sleep',
      builder: (context, state) => const SleepScreen(),
    ),
    GoRoute(
      path: '/sleep/chronotype',
      builder: (context, state) => const ChronotypeScreen(),
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
              path: '/notes',
              builder: (context, state) => const NotesScreen(),
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
