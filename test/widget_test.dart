import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rpg_task/app/app.dart';
import 'package:rpg_task/app/router/app_router.dart';
import 'package:rpg_task/core/database/app_database.dart';
import 'package:rpg_task/features/profile/data/profile_repository.dart';
import 'package:rpg_task/features/tasks/data/task_repository.dart';
import 'package:rpg_task/features/skills/data/skill_repository.dart';

void main() {
  testWidgets('Приложение запускается и показывает нижнюю навигацию',
      (WidgetTester tester) async {
    // Фиксируем русскую локаль, чтобы подписи навигации были предсказуемы.
    tester.platformDispatcher.localeTestValue = const Locale('ru');
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Подменяем потоки данных, чтобы smoke-тест не поднимал реальную БД.
          tasksStreamProvider
              .overrideWith((ref) => Stream.value(const <Task>[])),
          axesStreamProvider
              .overrideWith((ref) => Stream.value(const <SkillAxe>[])),
          // Слушатель уровня героя в RpgTaskApp не должен трогать реальную БД.
          profileStreamProvider
              .overrideWith((ref) => Stream<Profile?>.value(null)),
        ],
        child: RpgTaskApp(router: buildAppRouter()),
      ),
    );
    await tester.pump();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Задачи'), findsWidgets);
  });
}
