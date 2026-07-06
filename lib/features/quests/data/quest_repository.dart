import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../../core/gamification/reward_service.dart';
import '../../../core/models/enums.dart';

const _uuid = Uuid();

/// Квест с вычисленным на текущий момент прогрессом.
class QuestView {
  final DailyQuest quest;
  final int progress;
  const QuestView(this.quest, this.progress);

  bool get isComplete => progress >= quest.target;
}

/// Шаблон ежедневного квеста.
class _QuestTemplate {
  final QuestType type;
  final int target;
  final int rewardXp;
  final int rewardGold;
  const _QuestTemplate(this.type, this.target, this.rewardXp, this.rewardGold);
}

const List<_QuestTemplate> _dailyTemplates = [
  _QuestTemplate(QuestType.completeTasks, 3, 30, 15),
  _QuestTemplate(QuestType.completeHabits, 2, 20, 10),
  _QuestTemplate(QuestType.focusSessions, 1, 15, 8),
];

/// Ежедневные квесты: генерация набора на день и начисление награды.
/// Прогресс не хранится — считается из данных за текущий день.
class QuestRepository {
  final AppDatabase db;
  final RewardService rewards;
  QuestRepository(this.db, this.rewards);

  static String dateKeyFor(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  /// Гарантирует наличие квестов на сегодня, возвращает их с прогрессом.
  Future<List<QuestView>> loadToday([DateTime? now]) async {
    final today = now ?? DateTime.now();
    final key = dateKeyFor(today);

    final existing = await (db.select(db.dailyQuests)
          ..where((q) => q.dateKey.equals(key) & q.isDeleted.equals(false)))
        .get();

    if (existing.isEmpty) {
      for (final t in _dailyTemplates) {
        await db.into(db.dailyQuests).insert(
              DailyQuestsCompanion.insert(
                id: _uuid.v4(),
                dateKey: key,
                type: t.type,
                target: t.target,
                rewardXp: t.rewardXp,
                rewardGold: t.rewardGold,
              ),
            );
      }
    }

    final quests = await (db.select(db.dailyQuests)
          ..where((q) => q.dateKey.equals(key) & q.isDeleted.equals(false))
          ..orderBy([(q) => OrderingTerm(expression: q.type)]))
        .get();

    final views = <QuestView>[];
    for (final q in quests) {
      views.add(QuestView(q, await _progress(q.type, today)));
    }
    return views;
  }

  /// Начисляет награду за выполненный квест. Возвращает null, если рано/уже.
  Future<RewardResult?> claim(DailyQuest quest, [DateTime? now]) async {
    if (quest.claimed) return null;
    final progress = await _progress(quest.type, now ?? DateTime.now());
    if (progress < quest.target) return null;

    final reward =
        RewardResult(xp: quest.rewardXp, gold: quest.rewardGold, gems: 0);
    await rewards.applyReward(reward, reason: RewardReason.dailyQuest);
    await (db.update(db.dailyQuests)..where((q) => q.id.equals(quest.id)))
        .write(DailyQuestsCompanion(
      claimed: const Value(true),
      dirty: const Value(true),
      updatedAt: Value(DateTime.now()),
    ));
    return reward;
  }

  Future<int> _progress(QuestType type, DateTime day) async {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    switch (type) {
      case QuestType.completeTasks:
        final rows = await (db.select(db.tasks)
              ..where((t) =>
                  t.status.equalsValue(TaskStatus.done) &
                  t.completedAt.isBetweenValues(start, end)))
            .get();
        return rows.length;
      case QuestType.completeHabits:
        final rows = await (db.select(db.habitLogs)
              ..where((l) => l.completedAt.isBetweenValues(start, end)))
            .get();
        return rows.length;
      case QuestType.focusSessions:
        final rows = await (db.select(db.currencyTransactions)
              ..where((c) =>
                  c.reason.equalsValue(RewardReason.focusSession) &
                  c.kind.equalsValue(CurrencyKind.xp) &
                  c.createdAt.isBetweenValues(start, end)))
            .get();
        return rows.length;
    }
  }
}

final questRepositoryProvider = Provider<QuestRepository>((ref) {
  return QuestRepository(
    ref.watch(databaseProvider),
    ref.watch(rewardServiceProvider),
  );
});

final todayQuestsProvider = FutureProvider<List<QuestView>>((ref) {
  return ref.watch(questRepositoryProvider).loadToday();
});
