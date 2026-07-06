import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rpg_task/app/app.dart';
import 'package:rpg_task/core/database/app_database.dart';
import 'package:rpg_task/features/tasks/data/task_repository.dart';
import 'package:rpg_task/features/skills/data/skill_repository.dart';

void main() {
  testWidgets('Приложение запускается и показывает нижнюю навигацию',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Подменяем потоки данных, чтобы smoke-тест не поднимал реальную БД.
          tasksStreamProvider
              .overrideWith((ref) => Stream.value(const <Task>[])),
          axesStreamProvider
              .overrideWith((ref) => Stream.value(const <SkillAxe>[])),
        ],
        child: const RpgTaskApp(),
      ),
    );
    await tester.pump();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Задачи'), findsWidgets);
  });
}
