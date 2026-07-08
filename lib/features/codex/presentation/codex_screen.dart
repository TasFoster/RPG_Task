import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../tips/data/tip.dart';
import '../../tips/data/tips_catalog.dart';
import '../data/codex_repository.dart';

/// Кодекс героя — коллекция открытых цитат и советов.
/// Цитаты открываются как лут за активность (выполнение задач/привычек).
class CodexScreen extends ConsumerStatefulWidget {
  const CodexScreen({super.key});

  @override
  ConsumerState<CodexScreen> createState() => _CodexScreenState();
}

class _CodexScreenState extends ConsumerState<CodexScreen> {
  bool _favoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    final entriesAsync = ref.watch(codexEntriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Кодекс героя'),
        actions: [
          IconButton(
            tooltip: 'Только избранное',
            icon: Icon(_favoritesOnly ? Icons.star : Icons.star_border),
            onPressed: () => setState(() => _favoritesOnly = !_favoritesOnly),
          ),
        ],
      ),
      body: entriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (entries) {
          final byKey = {for (final e in entries) e.id: e};
          final total = tipsCatalog.length;
          final opened = tipsCatalog
              .where((t) => byKey.containsKey(t.key))
              .length;

          final sections = [
            for (final category in TipCategory.values)
              ..._categorySection(context, category, byKey),
          ];
          return ListView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
            children: [
              _ProgressHeader(opened: opened, total: total),
              const SizedBox(height: 12),
              if (sections.isEmpty && _favoritesOnly)
                const Padding(
                  padding: EdgeInsets.only(top: 48),
                  child: Center(child: Text('В избранном пока пусто')),
                )
              else
                ...sections,
            ],
          );
        },
      ),
    );
  }

  List<Widget> _categorySection(
    BuildContext context,
    TipCategory category,
    Map<String, CodexEntry> byKey,
  ) {
    final theme = Theme.of(context);
    final all = tipsCatalog.where((t) => t.category == category).toList();
    final visible = _favoritesOnly
        ? all.where((t) => byKey[t.key]?.isFavorite ?? false).toList()
        : all;
    if (visible.isEmpty) return const [];

    final openedInCat = all.where((t) => byKey.containsKey(t.key)).length;

    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(4, 12, 4, 6),
        child: Row(
          children: [
            Flexible(
              child: Text(
                category.label,
                style: theme.textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Text(
              '$openedInCat / ${all.length}',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      for (final tip in visible)
        _CodexTile(
          tip: tip,
          entry: byKey[tip.key],
          onFavorite: byKey.containsKey(tip.key)
              ? () => ref.read(codexRepositoryProvider).toggleFavorite(tip.key)
              : null,
        ),
    ];
  }
}

class _ProgressHeader extends StatelessWidget {
  final int opened;
  final int total;
  const _ProgressHeader({required this.opened, required this.total});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ratio = total == 0 ? 0.0 : opened / total;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.menu_book, color: theme.colorScheme.primary),
                const SizedBox(width: 10),
                Text(
                  'Открыто $opened из $total',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 10,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Открывайте новые записи, выполняя задачи и привычки.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CodexTile extends StatelessWidget {
  final Tip tip;
  final CodexEntry? entry;
  final VoidCallback? onFavorite;
  const _CodexTile({required this.tip, this.entry, this.onFavorite});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final discovered = entry != null;

    if (!discovered) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          leading: Icon(
            Icons.lock_outline,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          title: Text(
            'Тайная мудрость',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          subtitle: const Text('Ещё не открыто'),
        ),
      );
    }

    final fav = entry?.isFavorite ?? false;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tip.text, style: theme.textTheme.bodyLarge),
                  if (tip.author != null) ...[
                    const SizedBox(height: 6),
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
            IconButton(
              icon: Icon(
                fav ? Icons.star : Icons.star_border,
                color: fav ? theme.colorScheme.secondary : null,
              ),
              onPressed: onFavorite,
            ),
          ],
        ),
      ),
    );
  }
}
