import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/pomodoro_settings.dart';

/// Фаза помодоро-цикла.
enum PomodoroPhase { work, shortBreak, longBreak }

/// Состояние таймера помодоро.
class PomodoroState {
  final PomodoroPhase phase;
  final int remainingSeconds;
  final int totalSeconds;
  final bool isRunning;

  /// Сколько рабочих сессий завершено за текущий подход.
  final int completedWorkSessions;

  const PomodoroState({
    required this.phase,
    required this.remainingSeconds,
    required this.totalSeconds,
    required this.isRunning,
    required this.completedWorkSessions,
  });

  double get progress =>
      totalSeconds == 0 ? 0 : 1 - remainingSeconds / totalSeconds;

  bool get isWork => phase == PomodoroPhase.work;

  PomodoroState copyWith({
    PomodoroPhase? phase,
    int? remainingSeconds,
    int? totalSeconds,
    bool? isRunning,
    int? completedWorkSessions,
  }) {
    return PomodoroState(
      phase: phase ?? this.phase,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      isRunning: isRunning ?? this.isRunning,
      completedWorkSessions:
          completedWorkSessions ?? this.completedWorkSessions,
    );
  }
}

/// Управляет таймером помодоро. DB не трогает — начисление XP делает экран,
/// подписавшись на рост [PomodoroState.completedWorkSessions].
class PomodoroNotifier extends Notifier<PomodoroState> {
  Timer? _timer;

  int _durationFor(PomodoroPhase phase, PomodoroSettings s) => switch (phase) {
        PomodoroPhase.work => s.workMinutes * 60,
        PomodoroPhase.shortBreak => s.shortBreakMinutes * 60,
        PomodoroPhase.longBreak => s.longBreakMinutes * 60,
      };

  @override
  PomodoroState build() {
    ref.onDispose(() => _timer?.cancel());

    // При изменении настроек, если таймер стоит, пересобираем текущую фазу
    // под новую длительность (запущенный отсчёт не трогаем).
    ref.listen<PomodoroSettings>(pomodoroSettingsProvider, (_, next) {
      if (!state.isRunning) {
        final total = _durationFor(state.phase, next);
        state = state.copyWith(remainingSeconds: total, totalSeconds: total);
      }
    });

    final total =
        _durationFor(PomodoroPhase.work, ref.read(pomodoroSettingsProvider));
    return PomodoroState(
      phase: PomodoroPhase.work,
      remainingSeconds: total,
      totalSeconds: total,
      isRunning: false,
      completedWorkSessions: 0,
    );
  }

  void start() {
    if (state.isRunning) return;
    state = state.copyWith(isRunning: true);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void pause() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  /// Сброс текущей фазы к началу (счётчик сессий сохраняется).
  void reset() {
    _timer?.cancel();
    final total =
        _durationFor(state.phase, ref.read(pomodoroSettingsProvider));
    state = state.copyWith(
      remainingSeconds: total,
      totalSeconds: total,
      isRunning: false,
    );
  }

  /// Пропустить текущую фазу и перейти к следующей.
  void skip() {
    _timer?.cancel();
    _advance();
  }

  void _tick() {
    final next = state.remainingSeconds - 1;
    if (next > 0) {
      state = state.copyWith(remainingSeconds: next);
    } else {
      _timer?.cancel();
      _advance();
    }
  }

  /// Переход к следующей фазе. После рабочей сессии инкрементит счётчик
  /// (это сигнал экрану начислить награду) и выбирает длинный/короткий перерыв.
  void _advance() {
    final s = ref.read(pomodoroSettingsProvider);
    late PomodoroPhase nextPhase;
    var completed = state.completedWorkSessions;

    if (state.phase == PomodoroPhase.work) {
      completed += 1;
      final longDue = completed % s.cyclesBeforeLongBreak == 0;
      nextPhase = longDue ? PomodoroPhase.longBreak : PomodoroPhase.shortBreak;
    } else {
      nextPhase = PomodoroPhase.work;
    }

    final total = _durationFor(nextPhase, s);
    state = PomodoroState(
      phase: nextPhase,
      remainingSeconds: total,
      totalSeconds: total,
      isRunning: false,
      completedWorkSessions: completed,
    );

    // Автостарт следующей фазы, если включён в настройках.
    if (s.autoStartNext) start();
  }
}

final pomodoroProvider =
    NotifierProvider<PomodoroNotifier, PomodoroState>(PomodoroNotifier.new);
