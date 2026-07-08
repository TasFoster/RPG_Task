import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/pomodoro_settings.dart';

/// Нижняя панель настройки интервалов помодоро.
class PomodoroSettingsSheet extends ConsumerWidget {
  const PomodoroSettingsSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const PomodoroSettingsSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(pomodoroSettingsProvider);
    final notifier = ref.read(pomodoroSettingsProvider.notifier);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Настройки помодоро', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              Text('Пресеты', style: theme.textTheme.labelLarge),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  for (final p in kPomodoroPresets)
                    ActionChip(
                      label: Text(p.name),
                      onPressed: () => notifier.save(
                        settings.copyWith(
                          workMinutes: p.work,
                          shortBreakMinutes: p.shortBreak,
                          longBreakMinutes: p.longBreak,
                          cyclesBeforeLongBreak: p.cycles,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              _Stepper(
                label: 'Фокус (работа)',
                value: settings.workMinutes,
                min: 5,
                max: 120,
                step: 5,
                unit: 'мин',
                onChanged: (v) =>
                    notifier.save(settings.copyWith(workMinutes: v)),
              ),
              _Stepper(
                label: 'Короткий перерыв',
                value: settings.shortBreakMinutes,
                min: 1,
                max: 30,
                step: 1,
                unit: 'мин',
                onChanged: (v) =>
                    notifier.save(settings.copyWith(shortBreakMinutes: v)),
              ),
              _Stepper(
                label: 'Длинный перерыв',
                value: settings.longBreakMinutes,
                min: 5,
                max: 60,
                step: 5,
                unit: 'мин',
                onChanged: (v) =>
                    notifier.save(settings.copyWith(longBreakMinutes: v)),
              ),
              _Stepper(
                label: 'Циклов до длинного перерыва',
                value: settings.cyclesBeforeLongBreak,
                min: 2,
                max: 8,
                step: 1,
                unit: '',
                onChanged: (v) =>
                    notifier.save(settings.copyWith(cyclesBeforeLongBreak: v)),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Автостарт следующей фазы'),
                subtitle: const Text(
                  'Перерыв и работа запускаются автоматически',
                ),
                value: settings.autoStartNext,
                onChanged: (v) =>
                    notifier.save(settings.copyWith(autoStartNext: v)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  final String label;
  final int value;
  final int min;
  final int max;
  final int step;
  final String unit;
  final ValueChanged<int> onChanged;

  const _Stepper({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.step,
    required this.unit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: theme.textTheme.bodyLarge)),
          IconButton.filledTonal(
            icon: const Icon(Icons.remove),
            onPressed: value > min ? () => onChanged(value - step) : null,
          ),
          SizedBox(
            width: 64,
            child: Text(
              unit.isEmpty ? '$value' : '$value $unit',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
          ),
          IconButton.filledTonal(
            icon: const Icon(Icons.add),
            onPressed: value < max ? () => onChanged(value + step) : null,
          ),
        ],
      ),
    );
  }
}
