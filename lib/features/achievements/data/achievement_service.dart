import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../../core/gamification/reward_service.dart';
import '../../../core/models/enums.dart';
import 'achievement_defs.dart';

/// Проверяет условия достижений, разблокирует новые и начисляет награду.
class AchievementService {
  final AppDatabase db;
  final RewardService rewards;
  final GamificationEngine engine;

  AchievementService(this.db, this.rewards,
      [this.engine = const GamificationEngine()]);

  Future<AchievementStats> gatherStats() async {
    final profile =
        await (db.select(db.profiles)).getSingleOrNull();
    final totalXp = profile?.totalXp ?? 0;

    final tasksDone = (await (db.select(db.tasks)
              ..where((t) =>
                  t.status.equalsValue(TaskStatus.done) &
                  t.isDeleted.equals(false)))
            .get())
        .length;

    final habits = await (db.select(db.habits)
          ..where((h) => h.isDeleted.equals(false)))
        .get();
    final bestStreak = habits.fold<int>(0, (a, h) => h.streakBest > a ? h.streakBest : a);

    final bossesKilled = (await (db.select(db.goals)
              ..where((g) =>
                  g.isBoss.equals(true) &
                  g.status.equalsValue(GoalStatus.completed) &
                  g.isDeleted.equals(false)))
            .get())
        .length;

    final focusSessions = (await (db.select(db.currencyTransactions)
              ..where((c) =>
                  c.reason.equalsValue(RewardReason.focusSession) &
                  c.kind.equalsValue(CurrencyKind.xp)))
            .get())
        .length;

    return AchievementStats(
      totalXp: totalXp,
      level: engine.levelForXp(totalXp),
      tasksDone: tasksDone,
      habitBestStreak: bestStreak,
      bossesKilled: bossesKilled,
      focusSessions: focusSessions,
    );
  }

  Future<Set<String>> unlockedKeys() async {
    final rows = await (db.select(db.userAchievements)
          ..where((a) => a.isDeleted.equals(false)))
        .get();
    return rows.map((r) => r.id).toSet();
  }

  /// Проверяет все достижения, разблокирует выполненные и начисляет награду.
  /// Возвращает список только что разблокированных.
  Future<List<AchievementDef>> checkAndUnlock() async {
    final stats = await gatherStats();
    final already = await unlockedKeys();
    final newly = <AchievementDef>[];

    for (final def in kAchievements) {
      if (already.contains(def.key)) continue;
      if (!def.isUnlocked(stats)) continue;

      await db.into(db.userAchievements).insert(
            UserAchievementsCompanion.insert(id: def.key),
          );
      if (def.rewardGems > 0 || def.rewardXp > 0) {
        await rewards.applyReward(
          RewardResult(xp: def.rewardXp, gold: 0, gems: def.rewardGems),
          reason: RewardReason.achievement,
          refId: def.key,
        );
      }
      newly.add(def);
    }
    return newly;
  }
}

final achievementServiceProvider = Provider<AchievementService>((ref) {
  return AchievementService(
    ref.watch(databaseProvider),
    ref.watch(rewardServiceProvider),
  );
});

/// Запускает проверку и возвращает множество разблокированных ключей.
final achievementsProvider = FutureProvider<Set<String>>((ref) async {
  final service = ref.watch(achievementServiceProvider);
  await service.checkAndUnlock();
  return service.unlockedKeys();
});
