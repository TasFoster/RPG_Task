import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tip.dart';
import 'tips_catalog.dart';

/// Логика выбора советов/цитат. Чистая и детерминированная — легко тестируется.
class TipsService {
  final List<Tip> catalog;
  const TipsService([this.catalog = tipsCatalog]);

  /// Пул для «Совета дня»: цитаты и практические советы (без RPG-реакций).
  List<Tip> get dailyPool =>
      catalog.where((t) => t.type != TipType.flavor).toList(growable: false);

  /// «Совет дня» — детерминированный: один и тот же в течение суток,
  /// меняется в полночь. Не зависит от порядка каталога по времени.
  Tip dailyTip(DateTime date) {
    final pool = dailyPool;
    final key = date.year * 10000 + date.month * 100 + date.day;
    return pool[key % pool.length];
  }

  /// Все элементы заданной категории.
  List<Tip> byCategory(TipCategory category) =>
      catalog.where((t) => t.category == category).toList(growable: false);

  /// Контекстная подсказка выбранной категории.
  /// [salt] варьирует выбор между показами (например, минута/сессия).
  Tip? contextual(TipCategory category, {int salt = 0}) {
    final pool = byCategory(category);
    if (pool.isEmpty) return null;
    return pool[salt.abs() % pool.length];
  }
}

final tipsServiceProvider = Provider<TipsService>((_) => const TipsService());
