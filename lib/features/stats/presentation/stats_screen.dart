import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/gamification/ranks.dart';
import '../../../shared/utils/icons.dart';
import '../data/stats_repository.dart';

/// «Летопись героя» — статистика динамики и показателей в RPG-стилистике.
class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  StatsRange _range = StatsRange.week;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statsAsync = ref.watch(statsProvider(_range));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Летопись героя'),
        actions: [
          IconButton(
            icon: const Icon(Icons.workspace_premium_outlined),
            tooltip: 'Зал славы',
            onPressed: () => context.push('/seasons'),
          ),
        ],
      ),
      body: statsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (data) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            children: [
              SegmentedButton<StatsRange>(
                segments: [
                  for (final r in StatsRange.values)
                    ButtonSegment(value: r, label: Text(r.label)),
                ],
                selected: {_range},
                onSelectionChanged: (s) => setState(() => _range = s.first),
              ),
              const SizedBox(height: 16),
              _HeroBanner(data: data),
              const SizedBox(height: 16),
              _SummaryGrid(data: data),
              const SizedBox(height: 20),
              Text('Опыт по дням', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              _DailyBars(
                days: data.days,
                valueByDay: data.xpByDay,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                'Задачи и привычки по дням',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              _DailyBars(
                days: data.days,
                valueByDay: {
                  for (final d in data.days)
                    d: (data.tasksByDay[d] ?? 0) + (data.habitsByDay[d] ?? 0),
                },
                color: theme.colorScheme.tertiary,
              ),
              const SizedBox(height: 20),
              Text('Рост по осям навыков', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              _AxisBars(data: data),
            ],
          );
        },
      ),
    );
  }
}

/// Баннер героя: сезонный уровень, престиж, ранг за диапазон.
class _HeroBanner extends StatelessWidget {
  final StatsData data;
  const _HeroBanner({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rank = rankForXp(data.xpTotal);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.auto_awesome,
                color: theme.colorScheme.primary,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ранг ${data.range.label.toLowerCase()}: ${rank.name}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Уровень сезона: ${data.seasonLevel}  •  '
                    'Престиж: ${data.prestige}',
                  ),
                  Text(
                    'Опыт за всё время: ${data.lifetimeXp} XP',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Сетка сводных показателей за диапазон.
class _SummaryGrid extends StatelessWidget {
  final StatsData data;
  const _SummaryGrid({required this.data});

  @override
  Widget build(BuildContext context) {
    final tiles = <_Metric>[
      _Metric(Icons.bolt, 'Опыт', '${data.xpTotal}', Colors.amber),
      _Metric(Icons.task_alt, 'Задачи', '${data.tasksTotal}', Colors.green),
      _Metric(Icons.repeat, 'Привычки', '${data.habitsTotal}', Colors.teal),
      _Metric(Icons.timer, 'Фокус-сессии', '${data.focusTotal}', Colors.indigo),
      _Metric(
        Icons.monetization_on,
        'Золото',
        '${data.goldTotal}',
        Colors.orange,
      ),
      _Metric(
        Icons.local_fire_department,
        'Лучший стрик',
        '${data.bestStreak}',
        Colors.red,
      ),
    ];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.95,
      children: [for (final m in tiles) _MetricTile(metric: m)],
    );
  }
}

class _Metric {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _Metric(this.icon, this.label, this.value, this.color);
}

class _MetricTile extends StatelessWidget {
  final _Metric metric;
  const _MetricTile({required this.metric});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(metric.icon, color: metric.color, size: 26),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                metric.value,
                maxLines: 1,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: Text(
                metric.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Лёгкий столбчатый график «по дням» (горизонтальная прокрутка при нужде).
class _DailyBars extends StatelessWidget {
  final List<DateTime> days;
  final Map<DateTime, int> valueByDay;
  final Color color;
  const _DailyBars({
    required this.days,
    required this.valueByDay,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxVal = days.fold<int>(
      1,
      (m, d) => (valueByDay[d] ?? 0) > m ? (valueByDay[d] ?? 0) : m,
    );
    final fmt = DateFormat('d.MM');

    if (days.isEmpty) {
      return const SizedBox(
        height: 120,
        child: Center(child: Text('Нет данных')),
      );
    }

    return SizedBox(
      height: 140,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true, // свежие дни у правого края
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final d in days)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${valueByDay[d] ?? 0}',
                      style: theme.textTheme.labelSmall,
                    ),
                    const SizedBox(height: 2),
                    Container(
                      width: 16,
                      height: 90 * ((valueByDay[d] ?? 0) / maxVal),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      fmt.format(d),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Горизонтальные полосы прокачки осей навыков.
class _AxisBars extends StatelessWidget {
  final StatsData data;
  const _AxisBars({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (data.axes.isEmpty) {
      return const Text('Нет осей навыков');
    }
    final maxXp = data.axes.fold<int>(1, (m, a) => a.xp > m ? a.xp : m);
    return Column(
      children: [
        for (final a in data.axes)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Icon(
                  materialIcon(a.iconCodePoint),
                  size: 18,
                  color: Color(a.colorValue),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 90,
                  child: Text(
                    a.name,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: a.xp / maxXp,
                      minHeight: 12,
                      backgroundColor: Color(
                        a.colorValue,
                      ).withValues(alpha: 0.15),
                      valueColor: AlwaysStoppedAnimation(Color(a.colorValue)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('ур.${a.level}', style: theme.textTheme.bodySmall),
              ],
            ),
          ),
      ],
    );
  }
}
