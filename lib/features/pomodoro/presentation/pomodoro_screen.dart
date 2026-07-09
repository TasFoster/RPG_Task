import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/audio/sound_service.dart';
import '../../../core/gamification/reward_service.dart';
import '../../../shared/widgets/reward_snackbar.dart';
import '../../tips/data/tip.dart';
import '../../tips/presentation/tip_widgets.dart';
import 'pomodoro_notifier.dart';
import 'pomodoro_settings_sheet.dart';

/// Экран помодоро-таймера (мягкий фокус, этап 1: полноэкранный таймер).
/// За каждую завершённую рабочую сессию начисляется опыт.
class PomodoroScreen extends ConsumerWidget {
  const PomodoroScreen({super.key});

  static String _phaseTitle(PomodoroPhase p) => switch (p) {
    PomodoroPhase.work => 'Фокус',
    PomodoroPhase.shortBreak => 'Короткий перерыв',
    PomodoroPhase.longBreak => 'Длинный перерыв',
  };

  static String _fmt(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(pomodoroProvider);
    final notifier = ref.read(pomodoroProvider.notifier);

    // Рост числа завершённых рабочих сессий — сигнал начислить награду.
    ref.listen<PomodoroState>(pomodoroProvider, (prev, next) async {
      if (prev != null &&
          next.completedWorkSessions > prev.completedWorkSessions) {
        // Награждаем за фактически отработанное время фазы, а не за плановую
        // длительность — иначе «Пропустить фазу» давало бы полный XP даром.
        // Округляем до ближайшей минуты: при штатном завершении _tick уходит
        // в _advance со remainingSeconds == 1, поэтому полная сессия = +total.
        final workedSeconds = prev.totalSeconds - prev.remainingSeconds;
        final reward = await ref
            .read(rewardServiceProvider)
            .awardFocusSession(minutes: (workedSeconds + 30) ~/ 60);
        // Колокольчики: фокус-сессия завершена.
        ref.read(soundServiceProvider).play(AppSound.pomodoroDone);
        if (context.mounted) showRewardSnackBar(context, reward);
      }
    });

    final accent = state.isWork
        ? theme.colorScheme.primary
        : theme.colorScheme.tertiary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Помодоро'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Настройки интервалов',
            onPressed: () => PomodoroSettingsSheet.show(context),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _phaseTitle(state.phase),
                style: theme.textTheme.titleLarge?.copyWith(color: accent),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 240,
                height: 240,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 240,
                      height: 240,
                      child: CircularProgressIndicator(
                        value: state.progress,
                        strokeWidth: 10,
                        backgroundColor: accent.withValues(alpha: 0.15),
                        valueColor: AlwaysStoppedAnimation(accent),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _fmt(state.remainingSeconds),
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Сессий завершено: ${state.completedWorkSessions}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filledTonal(
                    onPressed: notifier.reset,
                    icon: const Icon(Icons.replay),
                    tooltip: 'Сброс',
                  ),
                  const SizedBox(width: 16),
                  FilledButton.icon(
                    onPressed: state.isRunning
                        ? notifier.pause
                        : notifier.start,
                    icon: Icon(
                      state.isRunning ? Icons.pause : Icons.play_arrow,
                    ),
                    label: Text(state.isRunning ? 'Пауза' : 'Старт'),
                  ),
                  const SizedBox(width: 16),
                  IconButton.filledTonal(
                    onPressed: notifier.skip,
                    icon: const Icon(Icons.skip_next),
                    tooltip: 'Пропустить фазу',
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ContextualTip(
                category: TipCategory.focus,
                salt: state.completedWorkSessions,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
