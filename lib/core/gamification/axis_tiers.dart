import 'dart:ui';

/// Градация («звания») уровней оси навыка. Используется на розе навыков:
/// цвет и название звания показывают, насколько прокачана ось.
class AxisTier {
  final String name;
  final int minLevel;
  final Color color;

  const AxisTier(this.name, this.minLevel, this.color);
}

/// Пороги званий по возрастанию уровня оси.
const List<AxisTier> kAxisTiers = [
  AxisTier('Новичок', 1, Color(0xFF9E9E9E)), // серый
  AxisTier('Ученик', 3, Color(0xFF4CAF50)), // зелёный
  AxisTier('Адепт', 5, Color(0xFF2196F3)), // синий
  AxisTier('Эксперт', 8, Color(0xFF9C27B0)), // фиолетовый
  AxisTier('Мастер', 12, Color(0xFFFF9800)), // оранжевый
  AxisTier('Грандмастер', 17, Color(0xFFE53935)), // красный
  AxisTier('Легенда', 25, Color(0xFFD4AF37)), // золотой
];

/// Наивысшее звание, порог которого не превышает [level].
AxisTier axisTierForLevel(int level) {
  var result = kAxisTiers.first;
  for (final tier in kAxisTiers) {
    if (level >= tier.minLevel) result = tier;
  }
  return result;
}

/// Следующее звание после [level] (null — достигнуто высшее).
AxisTier? nextAxisTier(int level) {
  for (final tier in kAxisTiers) {
    if (tier.minLevel > level) return tier;
  }
  return null;
}
