import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rpg_task/core/database/app_database.dart';
import 'package:rpg_task/core/database/seed.dart';
import 'package:rpg_task/core/gamification/reward_service.dart';
import 'package:rpg_task/core/models/enums.dart';
import 'package:rpg_task/features/achievements/data/achievement_service.dart';

void main() {
  late AppDatabase db;
  late AchievementService service;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await seedDatabase(db);
    service = AchievementService(db, RewardService(db));
  });
  tearDown(() => db.close());

  test('без активности достижений не разблокировано', () async {
    final newly = await service.checkAndUnlock();
    expect(newly, isEmpty);
    expect(await service.unlockedKeys(), isEmpty);
  });

  test('первая выполненная задача разблокирует «Первый шаг»', () async {
    await db.into(db.tasks).insert(TasksCompanion.insert(
          id: 't1',
          title: 'Дело',
          status: const Value(TaskStatus.done),
          completedAt: Value(DateTime.now()),
        ));

    final newly = await service.checkAndUnlock();
    expect(newly.map((d) => d.key), contains('first_task'));

    // Кристалл начислен.
    final profile = await (db.select(db.profiles)
          ..where((p) => p.id.equals(kProfileId)))
        .getSingle();
    expect(profile.gems, greaterThanOrEqualTo(1));

    // Повторная проверка не разблокирует и не начисляет заново.
    final again = await service.checkAndUnlock();
    expect(again, isEmpty);
  });
}
