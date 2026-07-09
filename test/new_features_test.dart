import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rpg_task/core/database/app_database.dart';
import 'package:rpg_task/core/database/seed.dart';
import 'package:rpg_task/core/gamification/gamification_engine.dart';
import 'package:rpg_task/core/gamification/ledger_reconciliation.dart';
import 'package:rpg_task/core/gamification/reward_service.dart';
import 'package:rpg_task/core/models/enums.dart';
import 'package:rpg_task/features/goals/data/goal_repository.dart';

void main() {
  late AppDatabase db;
  late RewardService rewards;
  late GoalRepository goals;
  const engine = GamificationEngine();

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await seedDatabase(db);
    rewards = RewardService(db);
    goals = GoalRepository(db, rewards, engine);
  });
  tearDown(() => db.close());

  Future<Profile> profile() => (db.select(db.profiles)
        ..where((p) => p.id.equals(kProfileId)))
      .getSingle();

  Future<Habit> insertHabit() async {
    await db.into(db.habits).insert(
          HabitsCompanion.insert(id: 'h1', title: 'Зарядка'),
        );
    return (db.select(db.habits)..where((h) => h.id.equals('h1'))).getSingle();
  }

  group('Отмена сегодняшней отметки привычки', () {
    test('откатывает награду, лог и серию', () async {
      var habit = await insertHabit();
      final reward = await rewards.completeHabit(habit);
      expect(reward, isNotNull);

      habit = (await (db.select(db.habits)
            ..where((h) => h.id.equals('h1')))
          .getSingle());
      expect(habit.streakCurrent, 1);
      expect((await profile()).totalXp, reward!.xp);

      final undone = await rewards.uncompleteHabitToday(habit);
      expect(undone, isTrue);

      habit = (await (db.select(db.habits)
            ..where((h) => h.id.equals('h1')))
          .getSingle());
      expect(habit.streakCurrent, 0);
      expect(habit.lastCompletedAt, isNull);

      final p = await profile();
      expect(p.totalXp, 0);
      expect(p.gold, 0);

      // Активных логов не осталось.
      final logs = await (db.select(db.habitLogs)
            ..where((l) => l.isDeleted.equals(false)))
          .get();
      expect(logs, isEmpty);
    });

    test('без отметки за сегодня возвращает false', () async {
      final habit = await insertHabit();
      expect(await rewards.uncompleteHabitToday(habit), isFalse);
    });

    test('серия из вчерашней отметки сохраняется', () async {
      var habit = await insertHabit();
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      await rewards.completeHabitOn(habit, yesterday);
      habit = (await (db.select(db.habits)
            ..where((h) => h.id.equals('h1')))
          .getSingle());
      await rewards.completeHabit(habit);

      habit = (await (db.select(db.habits)
            ..where((h) => h.id.equals('h1')))
          .getSingle());
      expect(habit.streakCurrent, 2);

      await rewards.uncompleteHabitToday(habit);
      habit = (await (db.select(db.habits)
            ..where((h) => h.id.equals('h1')))
          .getSingle());
      // Вчерашняя отметка на месте — серия 1, а не 0.
      expect(habit.streakCurrent, 1);
      expect(habit.streakBest, 1);
      expect(habit.lastCompletedAt, isNotNull);
    });
  });

  group('Подшаги шагов цели', () {
    test('добавление, переключение и удаление вместе с шагом', () async {
      final goalId = await goals.createGoal(title: 'Дракон', isBoss: true);
      await goals.addStep(goalId: goalId, title: 'Шаг 1');
      final step = (await goals.watchSteps(goalId).first).first;

      await goals.addSubStep(stepId: step.id, title: 'Подшаг А');
      await goals.addSubStep(stepId: step.id, title: 'Подшаг Б');

      var subs = await goals.watchSubSteps(goalId).first;
      expect(subs.length, 2);
      expect(subs.map((s) => s.title), ['Подшаг А', 'Подшаг Б']);

      await goals.toggleSubStep(subs.first);
      subs = await goals.watchSubSteps(goalId).first;
      expect(subs.firstWhere((s) => s.title == 'Подшаг А').done, isTrue);

      // Подшаги не влияют на HP босса.
      final goal = await goals.watchGoal(goalId).first;
      expect(goal!.hpRemaining, goal.hpTotal);

      await goals.softDeleteStep(step);
      subs = await goals.watchSubSteps(goalId).first;
      expect(subs, isEmpty);
    });
  });

  group('Автокоррекция журнала', () {
    test('расхождение закрывается корректировкой', () async {
      // Начисление мимо журнала: правим счётчики профиля напрямую.
      await (db.update(db.profiles)..where((p) => p.id.equals(kProfileId)))
          .write(const ProfilesCompanion(
        totalXp: Value(100),
        lifetimeXp: Value(100),
        gold: Value(40),
        gems: Value(2),
      ));

      final added = await LedgerReconciliation(db).reconcile();
      expect(added, 3); // XP, золото и кристаллы

      final rows = await db.customSelect(
        'SELECT kind, SUM(amount) AS total FROM currency_transactions '
        'WHERE is_deleted = 0 GROUP BY kind',
      ).get();
      final totals = {
        for (final r in rows)
          CurrencyKind.values[r.data['kind'] as int]: r.data['total'] as int,
      };
      expect(totals[CurrencyKind.xp], 100);
      expect(totals[CurrencyKind.gold], 40);
      expect(totals[CurrencyKind.gems], 2);

      // Повторный запуск ничего не добавляет.
      expect(await LedgerReconciliation(db).reconcile(), 0);
    });

    test('согласованный журнал не трогается', () async {
      final task = TasksCompanion.insert(id: 't1', title: 'Задача');
      await db.into(db.tasks).insert(task);
      final t = await (db.select(db.tasks)..where((x) => x.id.equals('t1')))
          .getSingle();
      await rewards.completeTask(t);

      expect(await LedgerReconciliation(db).reconcile(), 0);
    });
  });
}
