import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/season_service.dart';

/// «Свиток итогов сезона» — показывается при первом запуске в новом месяце.
class SeasonSummaryDialog extends StatelessWidget {
  final SeasonSummary summary;
  const SeasonSummaryDialog({super.key, required this.summary});

  static Future<void> show(BuildContext context, SeasonSummary summary) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SeasonSummaryDialog(summary: summary),
    );
  }

  String get _monthTitle {
    final name = DateFormat(
      'LLLL yyyy',
      'ru',
    ).format(DateTime(summary.year, summary.month));
    return name.isEmpty ? name : '${name[0].toUpperCase()}${name.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      scrollable: true,
      icon: Icon(
        Icons.workspace_premium,
        color: theme.colorScheme.primary,
        size: 40,
      ),
      title: Column(
        children: [
          const Text('Итоги сезона'),
          Text(
            _monthTitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text('Ранг сезона', style: theme.textTheme.labelMedium),
                Text(
                  summary.rank,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _row(theme, Icons.bolt, 'Опыт сезона', '${summary.xpEarned} XP'),
          _row(theme, Icons.stairs, 'Достигнутый уровень', '${summary.level}'),
          _row(
            theme,
            Icons.task_alt,
            'Задач выполнено',
            '${summary.tasksCompleted}',
          ),
          _row(
            theme,
            Icons.repeat,
            'Привычек отмечено',
            '${summary.habitsCompleted}',
          ),
          _row(
            theme,
            Icons.local_fire_department,
            'Лучший стрик',
            '${summary.bestStreak}',
          ),
          if (summary.topAxisName != null)
            _row(theme, Icons.hexagon, 'Топ-ось', summary.topAxisName!),
          const Divider(height: 20),
          _row(
            theme,
            Icons.diamond,
            'Бонус кристаллов',
            '+${summary.gemsAwarded}',
          ),
          _row(theme, Icons.military_tech, 'Престиж', '${summary.newPrestige}'),
          const SizedBox(height: 8),
          Text(
            'Новый сезон начат! Уровень и оси навыков обнулены — '
            'вперёд к новым свершениям.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('В новый сезон!'),
        ),
      ],
    );
  }

  Widget _row(ThemeData theme, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.secondary),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
