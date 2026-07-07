import 'package:flutter_test/flutter_test.dart';
import 'package:rpg_task/features/sleep/data/sleep_cycle.dart';

void main() {
  group('калькулятор циклов', () {
    test('bedtimesForWake: время = подъём − циклы×90 − засыпание', () {
      final wake = DateTime(2026, 7, 8, 7, 0);
      final opts = bedtimesForWake(wake);
      expect(opts.map((o) => o.cycles), [6, 5, 4]);
      // 6 циклов = 9ч + 15м засыпания = 9:15 до подъёма → 21:45
      expect(opts.first.time, DateTime(2026, 7, 7, 21, 45));
    });

    test('wakeTimesForBed: время = отход + засыпание + циклы×90', () {
      final bed = DateTime(2026, 7, 7, 23, 0);
      final opts = wakeTimesForBed(bed);
      expect(opts.map((o) => o.cycles), [4, 5, 6]);
      // 4 цикла: 23:00 +15м +6ч = 05:15
      expect(opts.first.time, DateTime(2026, 7, 8, 5, 15));
    });
  });

  group('длительность сна', () {
    test('через полночь считается корректно', () {
      final bed = DateTime(2026, 7, 7, 23, 30);
      final wake = DateTime(2026, 7, 8, 7, 0);
      expect(sleepDuration(bed, wake), const Duration(hours: 7, minutes: 30));
    });
  });

  group('хронотип', () {
    test('крайние баллы дают жаворонка и сову', () {
      expect(chronoTypeFromScore(0, 4), ChronoType.lark);
      expect(chronoTypeFromScore(12, 4), ChronoType.owl);
      expect(chronoTypeFromScore(6, 4), ChronoType.neutral);
    });
  });
}
