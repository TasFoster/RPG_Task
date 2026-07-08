import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../../shared/utils/icons.dart';
import '../data/skill_repository.dart';

/// Экран «Роза навыков»: радарная диаграмма прокачки по осям жизни.
/// Данные — реальные (уровень оси считается из накопленного XP).
class SkillsScreen extends ConsumerWidget {
  const SkillsScreen({super.key});

  static const _engine = GamificationEngine();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final axesAsync = ref.watch(axesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Роза навыков'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Управление осями',
            onPressed: () => context.push('/skills/manage'),
          ),
        ],
      ),
      body: axesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (axes) {
          if (axes.length < 3) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'Нужно минимум 3 оси навыков для диаграммы.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          final levels = [for (final a in axes) _engine.levelForXp(a.xp)];
          final maxLevel = levels.reduce((a, b) => a > b ? a : b);
          final primary = theme.colorScheme.primary;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Прокачивайте оси жизни выполнением задач и привычек',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: RadarChart(
                    RadarChartData(
                      radarShape: RadarShape.polygon,
                      tickCount: maxLevel.clamp(4, 6),
                      ticksTextStyle: const TextStyle(
                        color: Colors.transparent,
                        fontSize: 10,
                      ),
                      radarBackgroundColor: Colors.transparent,
                      borderData: FlBorderData(show: false),
                      radarBorderData: BorderSide(
                        color: theme.dividerColor,
                        width: 1,
                      ),
                      gridBorderData: BorderSide(
                        color: theme.dividerColor,
                        width: 1,
                      ),
                      tickBorderData: BorderSide(
                        color: theme.dividerColor.withValues(alpha: 0.5),
                      ),
                      getTitle: (index, angle) =>
                          RadarChartTitle(text: _radarLabel(axes[index].name)),
                      titleTextStyle: theme.textTheme.labelMedium,
                      dataSets: [
                        RadarDataSet(
                          fillColor: primary.withValues(alpha: 0.25),
                          borderColor: primary,
                          borderWidth: 2,
                          entryRadius: 3,
                          dataEntries: [
                            for (final level in levels)
                              RadarEntry(value: level.toDouble()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    for (var i = 0; i < axes.length; i++)
                      _AxisChip(axis: axes[i], level: levels[i]),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Обрезает длинные имена осей для подписей радар-диаграммы, чтобы они не
/// вылезали за края экрана (RadarChartTitle не поддерживает ellipsis).
/// Крайние (левая/правая) вершины близко к краю экрана, поэтому лимит короткий;
/// полное имя оси всегда видно в чипах под диаграммой.
String _radarLabel(String s, [int max = 10]) =>
    s.length <= max ? s : '${s.substring(0, max - 1).trimRight()}…';

class _AxisChip extends StatelessWidget {
  final SkillAxe axis;
  final int level;
  const _AxisChip({required this.axis, required this.level});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        materialIcon(axis.iconCodePoint),
        size: 18,
        color: Color(axis.colorValue),
      ),
      label: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 220),
        child: Text(
          '${axis.name}: ур. $level',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
