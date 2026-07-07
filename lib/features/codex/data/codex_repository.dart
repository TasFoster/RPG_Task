import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../../core/gamification/reward_service.dart';
import '../../../core/models/enums.dart';
import '../../tips/data/tip.dart';
import '../../tips/data/tips_catalog.dart';

final _rng = Random();

/// Кодекс героя: коллекция цитат/советов, открываемых как лут за активность.
class CodexRepository {
  final AppDatabase db;
  final RewardService rewards;
  CodexRepository(this.db, this.rewards);

  Stream<List<CodexEntry>> watchEntries() =>
      (db.select(db.codexEntries)..where((c) => c.isDeleted.equals(false)))
          .watch();

  Future<Set<String>> _discoveredKeys() async {
    final rows = await (db.select(db.codexEntries)
          ..where((c) => c.isDeleted.equals(false)))
        .get();
    return rows.map((e) => e.id).toSet();
  }

  /// Открывает одну случайную ещё не открытую цитату (лут за активность).
  /// Возвращает открытую цитату или null, если всё уже собрано.
  Future<Tip?> grantLoot() async {
    final discovered = await _discoveredKeys();
    final locked =
        tipsCatalog.where((t) => !discovered.contains(t.key)).toList();
    if (locked.isEmpty) return null;

    final tip = locked[_rng.nextInt(locked.length)];
    await db.into(db.codexEntries).insert(
          CodexEntriesCompanion.insert(id: tip.key),
          mode: InsertMode.insertOrIgnore,
        );
    await _maybeAwardCompletion();
    return tip;
  }

  /// Переключает избранное для цитаты (создаёт запись, если открывали лутом).
  Future<void> toggleFavorite(String key) async {
    final now = DateTime.now();
    final existing = await (db.select(db.codexEntries)
          ..where((c) => c.id.equals(key)))
        .getSingleOrNull();
    if (existing == null) {
      await db.into(db.codexEntries).insert(
            CodexEntriesCompanion.insert(id: key, isFavorite: const Value(true)),
          );
    } else {
      await (db.update(db.codexEntries)..where((c) => c.id.equals(key))).write(
        CodexEntriesCompanion(
          isFavorite: Value(!existing.isFavorite),
          isDeleted: const Value(false),
          dirty: const Value(true),
          updatedAt: Value(now),
        ),
      );
    }
  }

  /// Награда за полностью открытую категорию и за весь Кодекс.
  /// Идемпотентно: факт выдачи фиксируется в таблице достижений.
  Future<void> _maybeAwardCompletion() async {
    final discovered = await _discoveredKeys();

    for (final category in TipCategory.values) {
      final all = tipsCatalog.where((t) => t.category == category);
      final done = all.every((t) => discovered.contains(t.key));
      if (done && all.isNotEmpty) {
        await _awardOnce('codex_cat_${category.name}',
            const RewardResult(xp: 0, gold: 0, gems: 5));
      }
    }

    final allDone = tipsCatalog.every((t) => discovered.contains(t.key));
    if (allDone) {
      await _awardOnce(
          'codex_full', const RewardResult(xp: 0, gold: 0, gems: 25));
    }
  }

  Future<void> _awardOnce(String achievementKey, RewardResult reward) async {
    final existing = await (db.select(db.userAchievements)
          ..where((a) => a.id.equals(achievementKey)))
        .getSingleOrNull();
    if (existing != null) return;
    await db.into(db.userAchievements).insert(
          UserAchievementsCompanion.insert(id: achievementKey),
          mode: InsertMode.insertOrIgnore,
        );
    await rewards.applyReward(reward, reason: RewardReason.codexComplete);
  }
}

final codexRepositoryProvider = Provider<CodexRepository>((ref) {
  return CodexRepository(
    ref.watch(databaseProvider),
    ref.watch(rewardServiceProvider),
  );
});

final codexEntriesProvider = StreamProvider<List<CodexEntry>>((ref) {
  return ref.watch(codexRepositoryProvider).watchEntries();
});
