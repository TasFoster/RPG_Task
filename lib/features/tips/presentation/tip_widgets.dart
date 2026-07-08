import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/tip.dart';
import '../data/tips_service.dart';
import '../data/tips_settings.dart';

/// Заголовок-обёртка в RPG-стиле по типу контента.
String _flavorHeader(TipType type) => switch (type) {
  TipType.quote => 'Мудрость гильдии',
  TipType.tip => 'Приём искателя',
  TipType.flavor => 'Голос наставника',
};

IconData _flavorIcon(TipType type) => switch (type) {
  TipType.quote => Icons.auto_stories,
  TipType.tip => Icons.explore,
  TipType.flavor => Icons.pets,
};

/// Карточка «Совет дня» для главного экрана.
/// Детерминированно меняется раз в сутки. Скрыта, если советы выключены.
class DailyTipCard extends ConsumerWidget {
  const DailyTipCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(tipsSettingsProvider).value;
    if (settings == null || !settings.dailyEnabled) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final tip = ref.watch(tipsServiceProvider).dailyTip(DateTime.now());

    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.14),
              theme.colorScheme.tertiary.withValues(alpha: 0.06),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _flavorIcon(tip.type),
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _flavorHeader(tip.type),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Совет дня',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(tip.text, style: theme.textTheme.bodyLarge),
            if (tip.author != null) ...[
              const SizedBox(height: 8),
              Text(
                '— ${tip.author}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Компактная контекстная подсказка выбранной категории (для пустых экранов,
/// Помодоро и т.п.). Скрыта, если советы выключены или в категории пусто.
class ContextualTip extends ConsumerWidget {
  final TipCategory category;

  /// Смещение выбора, чтобы разные места/показы давали разные подсказки.
  final int salt;

  const ContextualTip({super.key, required this.category, this.salt = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(tipsSettingsProvider).value;
    if (settings == null || !settings.contextualEnabled) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final tip = ref.watch(tipsServiceProvider).contextual(category, salt: salt);
    if (tip == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _flavorIcon(tip.type),
            size: 18,
            color: theme.colorScheme.secondary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tip.text, style: theme.textTheme.bodyMedium),
                if (tip.author != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '— ${tip.author}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
