import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../data/season_service.dart';

/// «Зал славы» — архив завершённых сезонов с их итогами и рангами.
class SeasonHallScreen extends ConsumerWidget {
  const SeasonHallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seasonsAsync = ref.watch(seasonsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Зал славы')),
      body: seasonsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (seasons) {
          if (seasons.isEmpty) {
            return const _EmptyHall();
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: seasons.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, i) => _SeasonCard(season: seasons[i]),
          );
        },
      ),
    );
  }
}

class _SeasonCard extends StatelessWidget {
  final Season season;
  const _SeasonCard({required this.season});

  String get _monthTitle {
    final name = DateFormat(
      'LLLL yyyy',
      'ru',
    ).format(DateTime(season.year, season.month));
    return name.isEmpty ? name : '${name[0].toUpperCase()}${name.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.workspace_premium, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(_monthTitle, style: theme.textTheme.titleMedium),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    season.rank,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: [
                _stat(theme, Icons.bolt, '${season.xpEarned} XP'),
                _stat(theme, Icons.stairs, 'ур. ${season.level}'),
                _stat(theme, Icons.task_alt, '${season.tasksCompleted} задач'),
                _stat(
                  theme,
                  Icons.repeat,
                  '${season.habitsCompleted} привычек',
                ),
                _stat(
                  theme,
                  Icons.local_fire_department,
                  'стрик ${season.bestStreak}',
                ),
                _stat(theme, Icons.diamond, '+${season.gemsAwarded}'),
                if (season.topAxisName != null)
                  _stat(theme, Icons.hexagon, season.topAxisName!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(ThemeData theme, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.secondary),
        const SizedBox(width: 4),
        // В Wrap ширина не ограничена, поэтому вместо Flexible ограничиваем
        // ширину явно — длинное имя оси обрежется, а не переполнит строку.
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Text(
            text,
            style: theme.textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _EmptyHall extends StatelessWidget {
  const _EmptyHall();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.workspace_premium,
              size: 64,
              color: theme.colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 16),
            Text('Зал славы пуст', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Итоги первого сезона появятся здесь в начале следующего месяца.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
