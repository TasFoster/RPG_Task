import 'package:flutter_test/flutter_test.dart';
import 'package:rpg_task/features/tips/data/tip.dart';
import 'package:rpg_task/features/tips/data/tips_catalog.dart';
import 'package:rpg_task/features/tips/data/tips_service.dart';

void main() {
  const service = TipsService();

  group('каталог', () {
    test('непустой и достаточного объёма', () {
      expect(tipsCatalog.length, greaterThanOrEqualTo(100));
    });

    test('у каждой цитаты есть автор; у советов и реакций — нет', () {
      for (final t in tipsCatalog) {
        if (t.type == TipType.quote) {
          expect(t.author, isNotNull, reason: 'цитата без автора: "${t.text}"');
        } else {
          expect(t.author, isNull, reason: 'не-цитата с автором: "${t.text}"');
        }
        expect(t.text.trim(), isNotEmpty);
      }
    });

    test('во всех категориях есть контент для контекстных подсказок', () {
      for (final c in TipCategory.values) {
        expect(service.byCategory(c), isNotEmpty, reason: 'пусто: ${c.label}');
      }
    });
  });

  group('Совет дня', () {
    test('детерминирован в пределах суток и не берётся из RPG-реакций', () {
      final d = DateTime(2026, 7, 7, 9);
      final again = DateTime(2026, 7, 7, 23);
      expect(service.dailyTip(d).text, service.dailyTip(again).text);
      expect(service.dailyTip(d).type, isNot(TipType.flavor));
    });

    test('меняется день ото дня (в целом по году не залипает)', () {
      final texts = <String>{};
      for (var i = 0; i < 60; i++) {
        texts.add(service.dailyTip(DateTime(2026, 1, 1).add(Duration(days: i))).text);
      }
      // За 60 дней должно смениться много разных советов.
      expect(texts.length, greaterThan(10));
    });
  });

  group('контекстные подсказки', () {
    test('возвращают элемент нужной категории', () {
      final tip = service.contextual(TipCategory.focus, salt: 3);
      expect(tip, isNotNull);
      expect(tip!.category, TipCategory.focus);
    });

    test('salt устойчив к большим и отрицательным значениям', () {
      expect(service.contextual(TipCategory.discipline, salt: 99999), isNotNull);
      expect(service.contextual(TipCategory.discipline, salt: -7), isNotNull);
    });
  });
}
