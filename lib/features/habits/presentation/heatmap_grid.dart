import 'package:flutter/material.dart';

import '../data/habit_repository.dart';

/// Хитмап выполнений привычки в стиле GitHub: столбцы — недели, строки — дни.
/// Число недель подстраивается под ширину (адаптивно, ~17–26). Цвет клетки —
/// интенсивность по числу выполнений за день.
class HabitHeatmap extends StatelessWidget {
  final Map<DateTime, int> counts;
  final DateTime? now;

  const HabitHeatmap({super.key, required this.counts, this.now});

  static const _gap = 3.0;

  @override
  Widget build(BuildContext context) {
    final today = HabitRepository.dayOnly(now ?? DateTime.now());

    return LayoutBuilder(
      builder: (context, constraints) {
        const minCell = 12.0;
        final avail = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : 320.0;
        var weeks = ((avail + _gap) / (minCell + _gap)).floor();
        weeks = weeks.clamp(12, 26);
        final cell =
            ((avail - _gap * (weeks - 1)) / weeks).clamp(8.0, 18.0);

        var maxCount = 1;
        for (final v in counts.values) {
          if (v > maxCount) maxCount = v;
        }

        // Понедельник текущей недели, отступаем на (weeks-1) недель назад.
        final mondayThisWeek =
            today.subtract(Duration(days: today.weekday - 1));
        final start = mondayThisWeek
            .subtract(Duration(days: (weeks - 1) * 7));

        final columns = <Widget>[];
        for (var w = 0; w < weeks; w++) {
          final cells = <Widget>[];
          for (var d = 0; d < 7; d++) {
            final date = start.add(Duration(days: w * 7 + d));
            final level = date.isAfter(today)
                ? -1
                : _level(counts[date] ?? 0, maxCount);
            cells.add(Padding(
              padding: const EdgeInsets.only(bottom: _gap),
              child: _Cell(size: cell, level: level),
            ));
          }
          columns.add(Padding(
            padding: const EdgeInsets.only(right: _gap),
            child: Column(mainAxisSize: MainAxisSize.min, children: cells),
          ));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: columns),
            ),
            const SizedBox(height: 8),
            _Legend(cellSize: cell.clamp(10.0, 14.0)),
          ],
        );
      },
    );
  }

  static int _level(int count, int maxCount) {
    if (count <= 0) return 0;
    final ratio = count / maxCount;
    return (ratio * 4).ceil().clamp(1, 4);
  }
}

Color _levelColor(ThemeData theme, int level) {
  if (level < 0) return Colors.transparent;
  if (level == 0) {
    return theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6);
  }
  const alphas = [0.3, 0.5, 0.72, 1.0];
  return theme.colorScheme.primary.withValues(alpha: alphas[level - 1]);
}

class _Cell extends StatelessWidget {
  final double size;
  final int level;
  const _Cell({required this.size, required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _levelColor(Theme.of(context), level),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final double cellSize;
  const _Legend({required this.cellSize});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('меньше',
            style: theme.textTheme.labelSmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(width: 6),
        for (var l = 0; l <= 4; l++) ...[
          _Cell(size: cellSize, level: l),
          const SizedBox(width: 3),
        ],
        Text('больше',
            style: theme.textTheme.labelSmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}
