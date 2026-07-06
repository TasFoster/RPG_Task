/// Чистая (без платформенных зависимостей) логика планирования напоминаний.
/// Вынесена отдельно, чтобы покрывать unit-тестами без Flutter/каналов.
library;

/// Стабильный положительный 31-битный id уведомления из строкового UUID.
///
/// `flutter_local_notifications` требует int-id; наши сущности имеют UUID.
/// Функция детерминирована: один и тот же UUID → один и тот же id, поэтому
/// повторное планирование перезаписывает прежнее уведомление, а не плодит дубли.
int notificationIdFor(String uuid) {
  // FNV-1a 32-бит, затем обрезаем до 31 бита (id должен быть неотрицательным).
  var hash = 0x811c9dc5;
  for (var i = 0; i < uuid.length; i++) {
    hash ^= uuid.codeUnitAt(i);
    hash = (hash * 0x01000193) & 0xffffffff;
  }
  return hash & 0x7fffffff;
}

/// Минута суток [0..1439] из часа и минуты.
int minuteOfDay(int hour, int minute) => hour * 60 + minute;

/// Час из минуты суток.
int hourOf(int minuteOfDay) => minuteOfDay ~/ 60;

/// Минута часа из минуты суток.
int minuteOf(int minuteOfDay) => minuteOfDay % 60;

/// Ближайшее наступление ежедневного напоминания на минуту суток [minuteOfDay].
///
/// Возвращает сегодняшний момент, если он ещё впереди относительно [now],
/// иначе — завтрашний. Секунды/миллисекунды обнуляются. Часовой пояс/локаль
/// наследуются от [now] (вызывающий код передаёт tz-время устройства).
DateTime nextDailyOccurrence({
  required int minuteOfDay,
  required DateTime now,
}) {
  assert(minuteOfDay >= 0 && minuteOfDay < 1440, 'minuteOfDay вне [0,1440)');
  var candidate = DateTime(
    now.year,
    now.month,
    now.day,
    hourOf(minuteOfDay),
    minuteOf(minuteOfDay),
  );
  if (!candidate.isAfter(now)) {
    candidate = candidate.add(const Duration(days: 1));
  }
  return candidate;
}
