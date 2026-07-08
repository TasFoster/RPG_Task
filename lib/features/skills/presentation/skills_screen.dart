import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/gamification/axis_tiers.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../../shared/utils/icons.dart';
import '../data/skill_repository.dart';

/// Экран «Роза навыков»: радарная диаграмма прокачки по осям жизни
/// с градацией уровней (деления на кольцах, звания и прогресс осей).
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
          final maxLevel = levels.reduce(math.max);
          // Шкала радара — до кратного 5, чтобы кольца шли по целым уровням.
          final scaleMax = math.max(5, ((maxLevel + 4) ~/ 5) * 5);
          final primary = theme.colorScheme.primary;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Прокачивайте оси жизни выполнением задач и привычек',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 300,
                child: RadarChart(
                  RadarChartData(
                    radarShape: RadarShape.polygon,
                    tickCount: 5,
                    // Видимая градация: подписи уровней на кольцах.
                    ticksTextStyle: theme.textTheme.labelSmall!.copyWith(
                      fontSize: 9,
                      color: theme.colorScheme.onSurfaceVariant
                          .withValues(alpha: 0.8),
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
                      // Невидимый набор фиксирует шкалу 0..scaleMax,
                      // чтобы деления колец шли по целым уровням.
                      RadarDataSet(
                        fillColor: Colors.transparent,
                        borderColor: Colors.transparent,
                        borderWidth: 0,
                        entryRadius: 0,
                        dataEntries: [
                          for (var i = 0; i < axes.length; i++)
                            RadarEntry(value: i == 0 ? scaleMax.toDouble() : 0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const _TierLegend(),
              const SizedBox(height: 12),
              for (var i = 0; i < axes.length; i++)
                _AxisCard(axis: axes[i], level: levels[i]),
            ],
          );
        },
      ),
    );
  }
}

/// Обрезает длинные имена осей для подписей радар-диаграммы, чтобы они не
/// вылезали за края экрана (RadarChartTitle не поддерживает ellipsis).
/// Крайние (левая/правая) вершины близко к краю экрана, поэтому лимит короткий;
/// полное имя оси всегда видно в карточках под диаграммой.
String _radarLabel(String s, [int max = 10]) =>
    s.length <= max ? s : '${s.substring(0, max - 1).trimRight()}…';

/// Легенда градации: звания осей и пороговые уровни.
class _TierLegend extends StatelessWidget {
  const _TierLegend();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: 10,
      runSpacing: 6,
      alignment: WrapAlignment.center,
      children: [
        for (final tier in kAxisTiers)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: tier.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${tier.name} ${tier.minLevel}+',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

/// Карточка оси: звание, уровень и прогресс до следующего уровня.
class _AxisCard extends StatelessWidget {
  final SkillAxe axis;
  final int level;
  const _AxisCard({required this.axis, required this.level});

  static const _engine = GamificationEngine();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tier = axisTierForLevel(level);
    final next = nextAxisTier(level);

    final xpAtStart = _engine.totalXpForLevel(level);
    final xpForLevel = _engine.xpToNext(level);
    final xpInLevel = axis.xp - xpAtStart;
    final progress = (xpInLevel / xpForLevel).clamp(0.0, 1.0);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  materialIcon(axis.iconCodePoint),
                  size: 20,
                  color: Color(axis.colorValue),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    axis.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: tier.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: tier.color.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Text(
                    'ур. $level · ${tier.name}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: tier.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) => LinearProgressIndicator(
                  value: value,
                  minHeight: 6,
                  color: tier.color,
                  backgroundColor: tier.color.withValues(alpha: 0.15),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              next == null
                  ? '$xpInLevel / $xpForLevel XP до ур. ${level + 1} · высшее звание'
                  : '$xpInLevel / $xpForLevel XP до ур. ${level + 1} · '
                      '${next.name} с ур. ${next.minLevel}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
