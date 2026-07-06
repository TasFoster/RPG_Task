import 'package:flutter_test/flutter_test.dart';
import 'package:rpg_task/core/notifications/notification_scheduler.dart';

void main() {
  group('notificationIdFor', () {
    test('детерминирован и неотрицателен', () {
      const uuid = '9f1c2b7a-0000-4a11-8bcd-111122223333';
      final a = notificationIdFor(uuid);
      final b = notificationIdFor(uuid);
      expect(a, b);
      expect(a, greaterThanOrEqualTo(0));
    });

    test('разные uuid дают разные id', () {
      expect(notificationIdFor('a'), isNot(notificationIdFor('b')));
    });
  });

  group('minuteOfDay helpers', () {
    test('round-trip час/минута', () {
      final m = minuteOfDay(9, 30);
      expect(m, 570);
      expect(hourOf(m), 9);
      expect(minuteOf(m), 30);
    });
  });

  group('nextDailyOccurrence', () {
    test('время сегодня ещё впереди → сегодня', () {
      final now = DateTime(2026, 7, 6, 8, 0);
      final next = nextDailyOccurrence(minuteOfDay: minuteOfDay(9, 0), now: now);
      expect(next, DateTime(2026, 7, 6, 9, 0));
    });

    test('время сегодня уже прошло → завтра', () {
      final now = DateTime(2026, 7, 6, 10, 0);
      final next = nextDailyOccurrence(minuteOfDay: minuteOfDay(9, 0), now: now);
      expect(next, DateTime(2026, 7, 7, 9, 0));
    });

    test('ровно текущий момент → завтра (не в прошлое и не «сейчас»)', () {
      final now = DateTime(2026, 7, 6, 9, 0);
      final next = nextDailyOccurrence(minuteOfDay: minuteOfDay(9, 0), now: now);
      expect(next, DateTime(2026, 7, 7, 9, 0));
    });

    test('переход через конец месяца', () {
      final now = DateTime(2026, 7, 31, 23, 30);
      final next = nextDailyOccurrence(minuteOfDay: minuteOfDay(9, 0), now: now);
      expect(next, DateTime(2026, 8, 1, 9, 0));
    });
  });
}
