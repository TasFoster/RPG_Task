/// Тип единицы контента «советов и цитат».
enum TipType {
  /// Цитата реального автора (с указанием автора).
  quote,

  /// Практический совет/техника (тайм-менеджмент, дисциплина).
  tip,

  /// Короткая RPG-реакция во вселенной игры (без автора).
  flavor,
}

/// Тематическая категория контента.
enum TipCategory {
  timeManagement,
  discipline,
  motivation,
  focus,
  selfGrowth,
  resilience,
}

extension TipCategoryLabel on TipCategory {
  /// Человекочитаемое название категории (RU).
  String get label => switch (this) {
        TipCategory.timeManagement => 'Тайм-менеджмент',
        TipCategory.discipline => 'Дисциплина',
        TipCategory.motivation => 'Мотивация',
        TipCategory.focus => 'Фокус',
        TipCategory.selfGrowth => 'Саморазвитие',
        TipCategory.resilience => 'Стойкость',
      };
}

/// Единица контента: цитата, совет или RPG-реакция.
///
/// Каталог хранится в коде (см. `tips_catalog.dart`) по образцу достижений —
/// офлайн-first, без миграции БД. Пользовательские цитаты и «Кодекс героя»
/// (избранное/коллекция) — отдельная таблица на этапе B (см. docs/ROADMAP_RU.md).
class Tip {
  final TipType type;
  final TipCategory category;
  final String text;

  /// Автор для [TipType.quote]; null для советов и RPG-реакций.
  final String? author;

  const Tip(this.type, this.category, this.text, [this.author]);

  /// Стабильный ключ для Кодекса (хранится в БД). Детерминирован по тексту
  /// (FNV-1a): не меняется, пока не меняется сам текст цитаты/совета.
  String get key {
    var h = 0x811c9dc5;
    for (final c in text.codeUnits) {
      h ^= c;
      h = (h * 0x01000193) & 0xFFFFFFFF;
    }
    return 't${h.toRadixString(16)}';
  }
}
