import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rpg_task/app/app.dart';

void main() {
  testWidgets('Приложение запускается и показывает нижнюю навигацию',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: RpgTaskApp()));
    await tester.pump();

    // Присутствует нижняя навигация с вкладкой «Задачи».
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Задачи'), findsWidgets);
  });
}
