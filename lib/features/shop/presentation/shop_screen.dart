import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_theme.dart';
import '../../profile/data/profile_repository.dart';
import '../data/shop_catalog.dart';
import '../data/shop_service.dart';

/// Магазин кастомизации: аватары, питомцы, рамки.
class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  static String _categoryTitle(ShopCategory c) => switch (c) {
        ShopCategory.avatar => 'Аватары',
        ShopCategory.pet => 'Питомцы',
        ShopCategory.frame => 'Рамки',
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final profile = ref.watch(profileStreamProvider).value;
    final inventory = ref.watch(inventoryStreamProvider).value ?? const [];
    final ownedKeys = {for (final i in inventory) i.id};
    final equippedKeys = {for (final i in inventory) if (i.equipped) i.id};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Магазин'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  const Icon(Icons.monetization_on,
                      color: AppTheme.guildGold, size: 18),
                  Text(' ${profile?.gold ?? 0}   '),
                  const Icon(Icons.diamond,
                      color: AppTheme.crystalBlue, size: 18),
                  Text(' ${profile?.gems ?? 0}'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          for (final category in ShopCategory.values) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(_categoryTitle(category),
                  style: theme.textTheme.titleMedium),
            ),
            for (final item
                in kShopItems.where((i) => i.category == category))
              _ShopTile(
                item: item,
                owned: ownedKeys.contains(item.key),
                equipped: equippedKeys.contains(item.key),
              ),
          ],
        ],
      ),
    );
  }
}

class _ShopTile extends ConsumerWidget {
  final ShopItem item;
  final bool owned;
  final bool equipped;
  const _ShopTile({
    required this.item,
    required this.owned,
    required this.equipped,
  });

  String get _price {
    if (item.costGems > 0) return '${item.costGems} 💎';
    if (item.costGold > 0) return '${item.costGold} 💰';
    return 'Бесплатно';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    Future<void> buy() async {
      final result = await ref.read(shopServiceProvider).buy(item);
      if (!context.mounted) return;
      final msg = switch (result) {
        PurchaseResult.success => 'Куплено: ${item.name}',
        PurchaseResult.alreadyOwned => 'Уже куплено',
        PurchaseResult.notEnoughGold => 'Недостаточно золота',
        PurchaseResult.notEnoughGems => 'Недостаточно кристаллов',
      };
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(msg), behavior: SnackBarBehavior.floating));
    }

    Future<void> equip() => ref.read(shopServiceProvider).equip(item);

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.secondaryContainer,
          child: Icon(item.icon, color: theme.colorScheme.onSecondaryContainer),
        ),
        title: Text(item.name),
        subtitle: Text(item.description),
        trailing: owned
            ? (equipped
                ? const Chip(label: Text('Надето'))
                : OutlinedButton(
                    onPressed: equip, child: const Text('Надеть')))
            : FilledButton(onPressed: buy, child: Text(_price)),
      ),
    );
  }
}
