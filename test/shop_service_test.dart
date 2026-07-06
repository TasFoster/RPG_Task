import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rpg_task/core/database/app_database.dart';
import 'package:rpg_task/core/database/seed.dart';
import 'package:rpg_task/core/gamification/reward_service.dart';
import 'package:rpg_task/features/shop/data/shop_catalog.dart';
import 'package:rpg_task/features/shop/data/shop_service.dart';

void main() {
  late AppDatabase db;
  late ShopService shop;

  final mage = shopItemByKey('avatar_mage')!; // 100 золота
  final ranger = shopItemByKey('avatar_ranger')!; // 150 золота

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await seedDatabase(db);
    shop = ShopService(db, RewardService(db));
  });
  tearDown(() => db.close());

  Future<void> setGold(int gold) => (db.update(db.profiles)
        ..where((p) => p.id.equals(kProfileId)))
      .write(ProfilesCompanion(gold: Value(gold)));

  test('без золота покупка отклоняется', () async {
    expect(await shop.buy(mage), PurchaseResult.notEnoughGold);
  });

  test('покупка списывает золото и добавляет в инвентарь', () async {
    await setGold(300);
    expect(await shop.buy(mage), PurchaseResult.success);

    final profile = await (db.select(db.profiles)
          ..where((p) => p.id.equals(kProfileId)))
        .getSingle();
    expect(profile.gold, 200); // 300 - 100

    final inv = await shop.watchInventory().first;
    expect(inv.map((i) => i.id), contains('avatar_mage'));

    // Повторная покупка — уже куплено.
    expect(await shop.buy(mage), PurchaseResult.alreadyOwned);
  });

  test('экипировка снимает другой предмет той же категории', () async {
    await setGold(1000);
    await shop.buy(mage);
    await shop.buy(ranger);

    await shop.equip(mage);
    await shop.equip(ranger);

    final inv = await shop.watchInventory().first;
    final equipped =
        inv.where((i) => i.equipped).map((i) => i.id).toList();
    expect(equipped, ['avatar_ranger']); // только последний надетый
  });
}
