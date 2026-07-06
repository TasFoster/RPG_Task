import 'package:go_router/go_router.dart';

import '../../features/tasks/presentation/tasks_screen.dart';
import '../../features/habits/presentation/habits_screen.dart';
import '../../features/skills/presentation/skills_screen.dart';
import '../../features/character/presentation/character_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../widgets/home_shell.dart';

/// Конфигурация навигации приложения.
final GoRouter appRouter = GoRouter(
  initialLocation: '/tasks',
  routes: [
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
