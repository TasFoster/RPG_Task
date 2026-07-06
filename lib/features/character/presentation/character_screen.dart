import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../profile/data/profile_repository.dart';

/// Экран персонажа: аватар героя, уровень, опыт, валюты (реальные данные).
class CharacterScreen extends ConsumerWidget {
  const CharacterScreen({super.key});

  static const _engine = GamificationEngine();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final profileAsync = ref.watch(profileStreamProvider);

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
                        CircleAvatar(
                          radius: 44,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          child: Icon(Icons.shield_moon,
                              size: 48, color: theme.colorScheme.primary),
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
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.pets),
                    title: Text('Питомец'),
                    subtitle: Text('Появится в Фазе 6'),
                    trailing: Icon(Icons.lock_outline),
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
