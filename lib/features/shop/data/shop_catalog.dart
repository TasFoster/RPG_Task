import 'package:flutter/material.dart';

/// Категория товара кастомизации.
enum ShopCategory { avatar, pet, frame }

/// Товар магазина (статический каталог; id = [key]).
class ShopItem {
  final String key;
  final String name;
  final String description;
  final IconData icon;
  final ShopCategory category;
  final int costGold;
  final int costGems;

  const ShopItem({
    required this.key,
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    this.costGold = 0,
    this.costGems = 0,
  });
}

/// Каталог магазина кастомизации.
const List<ShopItem> kShopItems = [
  // Аватары героя.
  ShopItem(
    key: 'avatar_mage',
    name: 'Маг',
    description: 'Аватар героя-мага',
    icon: Icons.auto_fix_high,
    category: ShopCategory.avatar,
    costGold: 100,
  ),
  ShopItem(
    key: 'avatar_ranger',
    name: 'Следопыт',
    description: 'Аватар героя-следопыта',
    icon: Icons.forest,
    category: ShopCategory.avatar,
    costGold: 150,
  ),
  ShopItem(
    key: 'avatar_dragon',
    name: 'Драконорождённый',
    description: 'Редкий аватар',
    icon: Icons.local_fire_department,
    category: ShopCategory.avatar,
    costGems: 10,
  ),
  // Питомцы.
  ShopItem(
    key: 'pet_cat',
    name: 'Кот',
    description: 'Верный пушистый спутник',
    icon: Icons.pets,
    category: ShopCategory.pet,
    costGold: 80,
  ),
  ShopItem(
    key: 'pet_owl',
    name: 'Сова',
    description: 'Мудрый ночной компаньон',
    icon: Icons.nightlight,
    category: ShopCategory.pet,
    costGold: 120,
  ),
  ShopItem(
    key: 'pet_dragon',
    name: 'Дракончик',
    description: 'Редкий питомец',
    icon: Icons.egg,
    category: ShopCategory.pet,
    costGems: 8,
  ),
  // Рамки аватара.
  ShopItem(
    key: 'frame_gold',
    name: 'Золотая рамка',
    description: 'Обрамление для аватара',
    icon: Icons.workspace_premium,
    category: ShopCategory.frame,
    costGold: 200,
  ),
  ShopItem(
    key: 'frame_crystal',
    name: 'Кристальная рамка',
    description: 'Редкое обрамление',
    icon: Icons.diamond,
    category: ShopCategory.frame,
    costGems: 15,
  ),
];

ShopItem? shopItemByKey(String key) {
  for (final i in kShopItems) {
    if (i.key == key) return i;
  }
  return null;
}
