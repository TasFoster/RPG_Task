import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/seasons/data/season_service.dart';
import '../../features/seasons/presentation/season_summary_dialog.dart';
import '../../l10n/app_localizations.dart';

/// Каркас главного экрана с нижней навигацией между вкладками.
class HomeShell extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  const HomeShell({super.key, required this.navigationShell});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  @override
  void initState() {
    super.initState();
    // Если при запуске случился месячный пересчёт — показываем свиток итогов.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final summary = ref.read(pendingSeasonSummaryProvider);
      if (summary != null && mounted) {
        SeasonSummaryDialog.show(context, summary);
      }
    });
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      // Повторный тап по активной вкладке возвращает к её корню.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.check_circle_outline),
            selectedIcon: const Icon(Icons.check_circle),
            label: l.navTasks,
          ),
          NavigationDestination(
            icon: const Icon(Icons.local_fire_department_outlined),
            selectedIcon: const Icon(Icons.local_fire_department),
            label: l.navHabits,
          ),
          NavigationDestination(
            icon: const Icon(Icons.hexagon_outlined),
            selectedIcon: const Icon(Icons.hexagon),
            label: l.navSkills,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l.navCharacter,
          ),
          const NavigationDestination(
            icon: Icon(Icons.auto_stories_outlined),
            selectedIcon: Icon(Icons.auto_stories),
            label: 'Дневник',
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l.navSettings,
          ),
        ],
      ),
    );
  }
}
