import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/seed.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../../core/gamification/reward_service.dart';
import '../../../core/models/enums.dart';
import 'shop_catalog.dart';

/// Результат покупки.
enum PurchaseResult { success, alreadyOwned, notEnoughGold, notEnoughGems }

/// Магазин кастомизации: покупка за золото/кристаллы и экипировка.
class ShopService {
  final AppDatabase db;
  final RewardService rewards;
  ShopService(this.db, this.rewards);

  Stream<List<InventoryItem>> watchInventory() {
    return (db.select(db.inventoryItems)
          ..where((i) => i.isDeleted.equals(false)))
        .watch();
  }

  Future<PurchaseResult> buy(ShopItem item) async {
    final owned = await (db.select(db.inventoryItems)
          ..where((i) => i.id.equals(item.key)))
        .getSingleOrNull();
    if (owned != null && !owned.isDeleted) return PurchaseResult.alreadyOwned;

    final profile = await (db.select(db.profiles)
          ..where((p) => p.id.equals(kProfileId)))
        .getSingle();
    if (profile.gold < item.costGold) return PurchaseResult.notEnoughGold;
    if (profile.gems < item.costGems) return PurchaseResult.notEnoughGems;

    // Списание валюты через event-log (отрицательные суммы, причина purchase).
    if (item.costGold > 0 || item.costGems > 0) {
      await rewards.applyReward(
        RewardResult(xp: 0, gold: -item.costGold, gems: -item.costGems),
        reason: RewardReason.purchase,
        refId: item.key,
      );
    }

    await db.into(db.inventoryItems).insertOnConflictUpdate(
          InventoryItemsCompanion.insert(
            id: item.key,
            isDeleted: const Value(false),
            dirty: const Value(true),
          ),
        );
    return PurchaseResult.success;
  }

  /// Надеть предмет; снимает другие предметы той же категории.
  Future<void> equip(ShopItem item) async {
    final inventory = await (db.select(db.inventoryItems)
          ..where((i) => i.isDeleted.equals(false)))
        .get();
    for (final row in inventory) {
      final def = shopItemByKey(row.id);
      if (def == null || def.category != item.category) continue;
      final shouldEquip = row.id == item.key;
      if (row.equipped == shouldEquip) continue;
      await (db.update(db.inventoryItems)..where((i) => i.id.equals(row.id)))
          .write(InventoryItemsCompanion(
        equipped: Value(shouldEquip),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ));
    }
  }
}

final shopServiceProvider = Provider<ShopService>((ref) {
  return ShopService(
    ref.watch(databaseProvider),
    ref.watch(rewardServiceProvider),
  );
});

final inventoryStreamProvider = StreamProvider<List<InventoryItem>>((ref) {
  return ref.watch(shopServiceProvider).watchInventory();
});

/// Надетый предмет заданной категории (или null).
final equippedItemProvider =
    Provider.family<ShopItem?, ShopCategory>((ref, category) {
  final inventory = ref.watch(inventoryStreamProvider).value ?? const [];
  for (final row in inventory) {
    if (!row.equipped) continue;
    final def = shopItemByKey(row.id);
    if (def != null && def.category == category) return def;
  }
  return null;
});
