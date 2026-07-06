import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rpg_task/features/pomodoro/presentation/pomodoro_notifier.dart';

void main() {
  late ProviderContainer container;
  PomodoroState get() => container.read(pomodoroProvider);
  PomodoroNotifier notifier() => container.read(pomodoroProvider.notifier);

  setUp(() => container = ProviderContainer());
  tearDown(() => container.dispose());

  test('стартовое состояние — фаза «работа», таймер стоит', () {
    final s = get();
    expect(s.phase, PomodoroPhase.work);
    expect(s.isRunning, false);
    expect(s.remainingSeconds, 25 * 60);
    expect(s.completedWorkSessions, 0);
  });

  test('после работы — короткий перерыв, счётчик сессий растёт', () {
    notifier().skip(); // завершили работу
    final s = get();
    expect(s.phase, PomodoroPhase.shortBreak);
    expect(s.completedWorkSessions, 1);
    expect(s.isRunning, false); // новая фаза не стартует автоматически
  });

  test('каждая 4-я работа ведёт к длинному перерыву', () {
    final n = notifier();
    // work→short→work→short→work→short→work→LONG
    for (var i = 0; i < 3; i++) {
      n.skip(); // work → short break
      n.skip(); // short break → work
    }
    n.skip(); // 4-я работа завершена
    final s = get();
    expect(s.completedWorkSessions, 4);
    expect(s.phase, PomodoroPhase.longBreak);
  });

  test('reset возвращает полную длительность текущей фазы', () {
    final n = notifier();
    n.start();
    n.reset();
    final s = get();
    expect(s.remainingSeconds, s.totalSeconds);
    expect(s.isRunning, false);
  });
}
