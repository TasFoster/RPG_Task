import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Настройки помодоро-таймера: длительности фаз, число циклов до длинного
/// перерыва и автостарт следующей фазы. Хранится в SharedPreferences.
class PomodoroSettings {
  final int workMinutes;
  final int shortBreakMinutes;
  final int longBreakMinutes;
  final int cyclesBeforeLongBreak;
  final bool autoStartNext;

  const PomodoroSettings({
    this.workMinutes = 25,
    this.shortBreakMinutes = 5,
    this.longBreakMinutes = 15,
    this.cyclesBeforeLongBreak = 4,
    this.autoStartNext = false,
  });

  PomodoroSettings copyWith({
    int? workMinutes,
    int? shortBreakMinutes,
    int? longBreakMinutes,
    int? cyclesBeforeLongBreak,
    bool? autoStartNext,
  }) {
    return PomodoroSettings(
      workMinutes: workMinutes ?? this.workMinutes,
      shortBreakMinutes: shortBreakMinutes ?? this.shortBreakMinutes,
      longBreakMinutes: longBreakMinutes ?? this.longBreakMinutes,
      cyclesBeforeLongBreak:
          cyclesBeforeLongBreak ?? this.cyclesBeforeLongBreak,
      autoStartNext: autoStartNext ?? this.autoStartNext,
    );
  }

  static PomodoroSettings _read(SharedPreferences p) => PomodoroSettings(
        workMinutes: p.getInt('pomo_work') ?? 25,
        shortBreakMinutes: p.getInt('pomo_short') ?? 5,
        longBreakMinutes: p.getInt('pomo_long') ?? 15,
        cyclesBeforeLongBreak: p.getInt('pomo_cycles') ?? 4,
        autoStartNext: p.getBool('pomo_autostart') ?? false,
      );

  Future<void> _write(SharedPreferences p) async {
    await p.setInt('pomo_work', workMinutes);
    await p.setInt('pomo_short', shortBreakMinutes);
    await p.setInt('pomo_long', longBreakMinutes);
    await p.setInt('pomo_cycles', cyclesBeforeLongBreak);
    await p.setBool('pomo_autostart', autoStartNext);
  }
}

/// Готовые пресеты (название → настройки длительностей; автостарт сохраняется).
class PomodoroPreset {
  final String name;
  final int work;
  final int shortBreak;
  final int longBreak;
  final int cycles;
  const PomodoroPreset(
      this.name, this.work, this.shortBreak, this.longBreak, this.cycles);
}

const List<PomodoroPreset> kPomodoroPresets = [
  PomodoroPreset('Классика', 25, 5, 15, 4),
  PomodoroPreset('Длинный фокус', 50, 10, 20, 3),
  PomodoroPreset('Короткий', 15, 3, 10, 4),
];

/// Синхронный нотифаер: стартует со значениями по умолчанию и подгружает
/// сохранённые настройки асинхронно (таймеру удобно читать значение сразу).
class PomodoroSettingsNotifier extends Notifier<PomodoroSettings> {
  @override
  PomodoroSettings build() {
    _load();
    return const PomodoroSettings();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = PomodoroSettings._read(prefs);
  }

  Future<void> save(PomodoroSettings next) async {
    state = next;
    final prefs = await SharedPreferences.getInstance();
    await next._write(prefs);
  }
}

final pomodoroSettingsProvider =
    NotifierProvider<PomodoroSettingsNotifier, PomodoroSettings>(
        PomodoroSettingsNotifier.new);
