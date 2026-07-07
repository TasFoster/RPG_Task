import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../profile/data/profile_repository.dart';
import '../../shop/data/shop_catalog.dart';
import '../../shop/data/shop_service.dart';

/// Экран персонажа: аватар героя, уровень, опыт, валюты (реальные данные).
class CharacterScreen extends ConsumerWidget {
  const CharacterScreen({super.key});

  static const _engine = GamificationEngine();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final profileAsync = ref.watch(profileStreamProvider);
    final avatar = ref.watch(equippedItemProvider(ShopCategory.avatar));
    final pet = ref.watch(equippedItemProvider(ShopCategory.pet));
    final frame = ref.watch(equippedItemProvider(ShopCategory.frame));

    return Scaffold(
      appBar: AppBar(title: const Text('Герой')),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (profile) {
          final totalXp = profile?.totalXp ?? 0;
          final gold = profile?.gold ?? 0;
          final gems = profile?.gems ?? 0;
          final name = profile?.displayName ?? 'Искатель приключений';

          final level = _engine.levelForXp(totalXp);
          final xpAtStart = _engine.totalXpForLevel(level);
          final xpForLevel = _engine.xpToNext(level);
          final xpInLevel = totalXp - xpAtStart;
          final progress = (xpInLevel / xpForLevel).clamp(0.0, 1.0);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: frame == null
                              ? null
                              : BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: frame.key == 'frame_crystal'
                                        ? AppTheme.crystalBlue
                                        : AppTheme.guildGold,
                                    width: 3,
                                  ),
                                ),
                          child: CircleAvatar(
                            radius: 44,
                            backgroundColor: theme.colorScheme.primaryContainer,
                            child: Icon(avatar?.icon ?? Icons.shield_moon,
                                size: 48, color: theme.colorScheme.primary),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(name, style: theme.textTheme.titleLarge),
                        const SizedBox(height: 4),
                        Text('Уровень $level',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(color: theme.colorScheme.primary)),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                              value: progress, minHeight: 12),
                        ),
                        const SizedBox(height: 6),
                        Text(
                            '$xpInLevel / $xpForLevel XP до уровня ${level + 1}',
                            style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _CurrencyCard(
                        icon: Icons.monetization_on,
                        color: AppTheme.guildGold,
                        label: 'Золото',
                        value: gold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _CurrencyCard(
                        icon: Icons.diamond,
                        color: AppTheme.crystalBlue,
                        label: 'Кристаллы',
                        value: gems,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.secondaryContainer,
                      child: Icon(pet?.icon ?? Icons.pets,
                          color: theme.colorScheme.onSecondaryContainer),
                    ),
                    title: const Text('Питомец'),
                    subtitle: Text(pet?.name ?? 'Нет питомца — загляните в магазин'),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Приключения', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.whatshot,
                            color: theme.colorScheme.error),
                        title: const Text('Цели и боссы'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/goals'),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.assignment_turned_in,
                            color: theme.colorScheme.primary),
                        title: const Text('Ежедневные квесты'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/quests'),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.emoji_events,
                            color: theme.colorScheme.tertiary),
                        title: const Text('Достижения'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/achievements'),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.insights,
                            color: theme.colorScheme.primary),
                        title: const Text('Летопись героя'),
                        subtitle: const Text('Статистика и динамика показателей'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/stats'),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.menu_book,
                            color: theme.colorScheme.primary),
                        title: const Text('Кодекс героя'),
                        subtitle: const Text('Коллекция цитат и советов'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/codex'),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.bedtime, color: AppTheme.crystalBlue),
                        title: const Text('Трекер сна'),
                        subtitle: const Text('Циклы сна и циркадные ритмы'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/sleep'),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.storefront,
                            color: AppTheme.guildGold),
                        title: const Text('Магазин'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/shop'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CurrencyCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final int value;

  const _CurrencyCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text('$value', style: theme.textTheme.titleLarge),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
