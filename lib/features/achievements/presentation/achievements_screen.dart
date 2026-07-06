import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/achievement_defs.dart';
import '../data/achievement_service.dart';

/// Экран достижений: сетка карточек, разблокированные подсвечены.
class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unlockedAsync = ref.watch(achievementsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Достижения')),
      body: unlockedAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (unlocked) => GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(12),
          childAspectRatio: 0.95,
          children: [
            for (final def in kAchievements)
              _AchievementCard(
                def: def,
                unlocked: unlocked.contains(def.key),
              ),
          ],
        ),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final AchievementDef def;
  final bool unlocked;
  const _AchievementCard({required this.def, required this.unlocked});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = unlocked
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4);

    return Card(
      color: unlocked ? theme.colorScheme.primaryContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(unlocked ? def.icon : Icons.lock_outline, size: 40, color: color),
            const SizedBox(height: 10),
            Text(def.title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(def.description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall),
            const SizedBox(height: 6),
            Text(
              [
                if (def.rewardGems > 0) '+${def.rewardGems}💎',
                if (def.rewardXp > 0) '+${def.rewardXp} XP',
              ].join('  '),
              style: theme.textTheme.labelSmall?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
