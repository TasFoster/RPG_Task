/// Чистая логика сна: расчёт циклов (90 мин) и хронотипов. Без зависимостей —
/// покрывается unit-тестами.
library;

/// Длительность одного цикла сна.
const Duration kSleepCycle = Duration(minutes: 90);

/// Среднее время засыпания.
const Duration kFallAsleep = Duration(minutes: 15);

/// Рекомендуемое число циклов (5–6 = 7.5–9 часов сна).
const List<int> kRecommendedCycles = [6, 5, 4];

/// Вариант отхода ко сну/подъёма: сколько циклов и во сколько.
class CycleOption {
  final int cycles;
  final DateTime time;
  const CycleOption(this.cycles, this.time);

  /// Часы сна (без учёта времени засыпания).
  double get hours => cycles * kSleepCycle.inMinutes / 60.0;
}

/// Во сколько лечь, чтобы проснуться в [wake] на границе цикла.
/// Возвращает варианты для 6/5/4 циклов (более длинный сон — первым).
List<CycleOption> bedtimesForWake(DateTime wake) {
  return kRecommendedCycles
      .map((c) => CycleOption(
          c, wake.subtract(kSleepCycle * c).subtract(kFallAsleep)))
      .toList();
}

/// Во сколько встать, если лечь в [bed] сейчас (учитывая засыпание).
/// Возвращает варианты для 4/5/6 циклов (более короткий сон — первым).
List<CycleOption> wakeTimesForBed(DateTime bed) {
  final asleep = bed.add(kFallAsleep);
  return kRecommendedCycles.reversed
      .map((c) => CycleOption(c, asleep.add(kSleepCycle * c)))
      .toList();
}

/// Хронотип.
enum ChronoType { lark, neutral, owl }

extension ChronoTypeInfo on ChronoType {
  String get label => switch (this) {
        ChronoType.lark => 'Жаворонок',
        ChronoType.neutral => 'Голубь (промежуточный)',
        ChronoType.owl => 'Сова',
      };

  /// Рекомендуемое окно отхода ко сну (минуты суток), для подсказки.
  ({int bed, int wake}) get window => switch (this) {
        ChronoType.lark => (bed: 22 * 60, wake: 6 * 60),
        ChronoType.neutral => (bed: 23 * 60, wake: 7 * 60),
        ChronoType.owl => (bed: 24 * 60, wake: 8 * 60), // 00:00 → 08:00
      };

  String get advice => switch (this) {
        ChronoType.lark =>
          'Пик энергии — утром. Планируйте сложное на первую половину дня.',
        ChronoType.neutral =>
          'Сбалансированный ритм. Держите постоянное время сна и подъёма.',
        ChronoType.owl =>
          'Пик энергии — вечером. Избегайте важных дел рано утром, берегите утренний свет.',
      };
}

/// Определяет хронотип по сумме баллов короткого опросника (0..N*3).
/// Меньше баллов — жаворонок, больше — сова.
ChronoType chronoTypeFromScore(int score, int questions) {
  final maxScore = questions * 3;
  final ratio = maxScore == 0 ? 0.5 : score / maxScore;
  if (ratio < 0.4) return ChronoType.lark;
  if (ratio > 0.6) return ChronoType.owl;
  return ChronoType.neutral;
}

/// Продолжительность сна между [bed] и [wake] (учитывает переход через полночь).
Duration sleepDuration(DateTime bed, DateTime wake) {
  var d = wake.difference(bed);
  if (d.isNegative) d += const Duration(days: 1);
  return d;
}

/// Целевая длительность сна (для «долга сна»).
const double kTargetSleepHours = 8.0;
