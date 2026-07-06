import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/gamification/gamification_engine.dart';

/// Экран персонажа: аватар героя, уровень, опыт, валюты.
/// Пока демо-данные; в Фазе 1 значения придут из локального профиля.
class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key});

  // Демо-состояние героя.
  static const int _totalXp = 640;
  static const int _gold = 1250;
  static const int _gems = 12;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const engine = GamificationEngine();

    final level = engine.levelForXp(_totalXp);
    final xpAtLevelStart = engine.totalXpForLevel(level);
    final xpForThisLevel = engine.xpToNext(level);
    final xpInLevel = _totalXp - xpAtLevelStart;
    final progress = (xpInLevel / xpForThisLevel).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: const Text('Герой')),
      body: SingleChildScrollView(
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
                    Text('Искатель приключений',
                        style: theme.textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text('Уровень $level',
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.primary)),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('$xpInLevel / $xpForThisLevel XP до уровня ${level + 1}',
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
                    value: _gold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _CurrencyCard(
                    icon: Icons.diamond,
                    color: AppTheme.crystalBlue,
                    label: 'Кристаллы',
                    value: _gems,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.pets),
                title: const Text('Питомец'),
                subtitle: const Text('Появится в Фазе 6'),
                trailing: const Icon(Icons.lock_outline),
              ),
            ),
          ],
        ),
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
