import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/habit_repository.dart';
import 'heatmap_grid.dart';

/// Карточка с хитмапом выполнений. [habitId] == null — сводка по всем привычкам.
class HabitHeatmapCard extends ConsumerWidget {
  final String? habitId;
  final String title;
  final IconData icon;

  const HabitHeatmapCard({
    super.key,
    this.habitId,
    required this.title,
    this.icon = Icons.grid_view,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final async = ref.watch(habitHeatmapProvider(habitId));

    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(title, style: theme.textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 12),
            async.when(
              loading: () => const SizedBox(
                  height: 110,
                  child: Center(child: CircularProgressIndicator())),
              error: (e, _) => Text('Ошибка: $e'),
              data: (counts) => HabitHeatmap(counts: counts),
            ),
          ],
        ),
      ),
    );
  }
}
