import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Демонстрационная ось навыка (в Фазе 1 данные придут из БД).
class _SkillAxis {
  final String name;
  final double value; // 0..100 — условный прогресс
  const _SkillAxis(this.name, this.value);
}

/// Экран «Роза навыков» — радарная диаграмма прокачки по осям жизни.
/// Пока показывает демо-данные; в Фазе 1 будет считать из локальной БД.
class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  static const List<_SkillAxis> _demoAxes = [
    _SkillAxis('Здоровье', 70),
    _SkillAxis('Спорт', 45),
    _SkillAxis('Учёба', 80),
    _SkillAxis('Работа', 60),
    _SkillAxis('Творчество', 35),
    _SkillAxis('Отношения', 55),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Роза навыков')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Прокачивайте оси жизни выполнением задач и привычек',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: RadarChart(
                RadarChartData(
                  radarShape: RadarShape.polygon,
                  tickCount: 4,
                  ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 10),
                  radarBackgroundColor: Colors.transparent,
                  borderData: FlBorderData(show: false),
                  radarBorderData: BorderSide(color: theme.dividerColor, width: 1),
                  gridBorderData: BorderSide(color: theme.dividerColor, width: 1),
                  tickBorderData: BorderSide(color: theme.dividerColor.withValues(alpha: 0.5)),
                  getTitle: (index, angle) =>
                      RadarChartTitle(text: _demoAxes[index].name),
                  titleTextStyle: theme.textTheme.labelMedium,
                  dataSets: [
                    RadarDataSet(
                      fillColor: primary.withValues(alpha: 0.25),
                      borderColor: primary,
                      borderWidth: 2,
                      entryRadius: 3,
                      dataEntries: [
                        for (final axis in _demoAxes)
                          RadarEntry(value: axis.value),
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
                for (final axis in _demoAxes)
                  Chip(label: Text('${axis.name}: ${axis.value.toInt()}')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
