import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/tip.dart';

/// Небольшое модальное окно с утренней/вечерней рефлексией.
///
/// Открывается по тапу на пуш-совет. Сам совет к этому моменту уже сохранён в
/// историю (Кодекс героя) вызывающей стороной. Кнопка «Открыть Кодекс» ведёт
/// к полной коллекции советов.
Future<void> showReflectionDialog(
  BuildContext context, {
  required String slotKey,
  required Tip tip,
}) {
  final isEvening = slotKey == 'tip_evening';
  final title = isEvening ? 'Вечерняя рефлексия' : 'Утренний девиз';
  final icon = isEvening ? Icons.nightlight_round : Icons.wb_sunny_rounded;

  return showDialog<void>(
    context: context,
    builder: (ctx) {
      final theme = Theme.of(ctx);
      return AlertDialog(
        icon: Icon(icon, color: theme.colorScheme.primary),
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tip.text, style: theme.textTheme.bodyLarge),
            if (tip.author != null) ...[
              const SizedBox(height: 10),
              Text('— ${tip.author}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.onSurfaceVariant,
                  )),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.menu_book,
                    size: 16, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Expanded(
                  child: Text('Сохранено в историю советов (Кодекс героя)',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      )),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.push('/codex');
            },
            child: const Text('Открыть Кодекс'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      );
    },
  );
}
