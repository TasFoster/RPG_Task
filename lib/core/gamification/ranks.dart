/// Ранги (звания) героя по набранному опыту. Используются в статистике
/// («ранг за диапазон») и при подведении итогов сезона (звание + бонус
/// кристаллов за достигнутый ранг).
class RankTier {
  final String name;
  final int minXp;

  /// Бонус кристаллов при закрытии сезона с этим рангом.
  final int seasonGems;

  const RankTier(this.name, this.minXp, this.seasonGems);
}

/// Пороги рангов по возрастанию опыта.
const List<RankTier> kRankTiers = [
  RankTier('Новичок', 0, 1),
  RankTier('Искатель', 200, 2),
  RankTier('Странник', 600, 3),
  RankTier('Воитель', 1500, 5),
  RankTier('Герой', 3500, 8),
  RankTier('Легенда', 7000, 12),
];

/// Наивысший ранг, порог которого не превышает [xp].
RankTier rankForXp(int xp) {
  var result = kRankTiers.first;
  for (final tier in kRankTiers) {
    if (xp >= tier.minXp) result = tier;
  }
  return result;
}
