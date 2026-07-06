import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rpg_task/core/database/app_database.dart';
import 'package:rpg_task/core/database/seed.dart';
import 'package:rpg_task/core/gamification/reward_service.dart';
import 'package:rpg_task/core/models/enums.dart';
import 'package:rpg_task/features/quests/data/quest_repository.dart';

void main() {
  late AppDatabase db;
  late QuestRepository repo;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await seedDatabase(db);
    repo = QuestRepository(db, RewardService(db));
  });
  tearDown(() => db.close());

  test('loadToday генерирует 3 квеста один раз', () async {
    final first = await repo.loadToday();
    expect(first, hasLength(3));
    final second = await repo.loadToday();
    expect(second, hasLength(3)); // не дублируются
  });

  test('прогресс задач считается по выполненным сегодня', () async {
    final now = DateTime.now();
    // Две выполненные сегодня задачи.
    for (var i = 0; i < 2; i++) {
      await db.into(db.tasks).insert(TasksCompanion.insert(
            id: 't$i',
            title: 'T$i',
            status: const Value(TaskStatus.done),
            completedAt: Value(now),
          ));
    }
    final quests = await repo.loadToday(now);
    final tasksQuest =
        quests.firstWhere((v) => v.quest.type == QuestType.completeTasks);
    expect(tasksQuest.progress, 2);
    expect(tasksQuest.isComplete, false); // target 3
  });

  test('claim начисляет награду только при выполнении', () async {
    final now = DateTime.now();
    for (var i = 0; i < 3; i++) {
      await db.into(db.tasks).insert(TasksCompanion.insert(
            id: 't$i',
            title: 'T$i',
            status: const Value(TaskStatus.done),
            completedAt: Value(now),
          ));
    }
    final quests = await repo.loadToday(now);
    final q =
        quests.firstWhere((v) => v.quest.type == QuestType.completeTasks).quest;

    final reward = await repo.claim(q, now);
    expect(reward, isNotNull);
    expect(reward!.xp, q.rewardXp);

    // Повторный claim не начисляет.
    final fresh = (await repo.loadToday(now))
        .firstWhere((v) => v.quest.type == QuestType.completeTasks)
        .quest;
    expect(await repo.claim(fresh, now), isNull);
  });
}
