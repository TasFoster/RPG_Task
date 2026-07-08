import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../shared/utils/icons.dart';
import '../../skills/data/skill_repository.dart';
import '../data/note_repository.dart';
import 'note_editor_screen.dart';

/// Экран «Дневник героя»: список заметок с поиском и фильтром по осям.
class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  String? _filterAxisId; // null — все оси
  bool _showArchive = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openEditor([Note? note]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => NoteEditorScreen(note: note)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notesAsync = ref.watch(
      _showArchive ? archivedNotesStreamProvider : notesStreamProvider,
    );
    final axesAsync = ref.watch(axesStreamProvider);
    final axesById = {
      for (final a in axesAsync.value ?? const <SkillAxe>[]) a.id: a,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(_showArchive ? 'Архив дневника' : 'Дневник'),
        actions: [
          IconButton(
            icon: Icon(
              _showArchive ? Icons.inventory_2 : Icons.inventory_2_outlined,
            ),
            tooltip: _showArchive ? 'К записям' : 'Архив',
            onPressed: () => setState(() => _showArchive = !_showArchive),
          ),
        ],
      ),
      floatingActionButton: _showArchive
          ? null
          : FloatingActionButton.extended(
              onPressed: _openEditor,
              icon: const Icon(Icons.add),
              label: const Text('Запись'),
            ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Поиск по записям',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                border: const OutlineInputBorder(),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      ),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          if (axesById.isNotEmpty)
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: const Text('Все'),
                      selected: _filterAxisId == null,
                      onSelected: (_) => setState(() => _filterAxisId = null),
                    ),
                  ),
                  for (final a in axesById.values)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        avatar: Icon(materialIcon(a.iconCodePoint),
                            size: 16, color: Color(a.colorValue)),
                        label: Text(a.name),
                        selected: _filterAxisId == a.id,
                        onSelected: (_) =>
                            setState(() => _filterAxisId = a.id),
                      ),
                    ),
                ],
              ),
            ),
          Expanded(
            child: notesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Ошибка: $e')),
              data: (notes) {
                final q = _query.trim().toLowerCase();
                final filtered = notes.where((n) {
                  if (_filterAxisId != null && n.axisId != _filterAxisId) {
                    return false;
                  }
                  if (q.isEmpty) return true;
                  return n.title.toLowerCase().contains(q) ||
                      n.body.toLowerCase().contains(q);
                }).toList();

                if (filtered.isEmpty) {
                  return _EmptyState(
                    hasNotes: notes.isNotEmpty,
                    archive: _showArchive,
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 96),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 4),
                  itemBuilder: (context, i) {
                    final note = filtered[i];
                    return _NoteTile(
                      note: note,
                      archived: _showArchive,
                      onTap: () => _openEditor(note),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteTile extends ConsumerWidget {
  final Note note;
  final bool archived;
  final VoidCallback onTap;
  const _NoteTile({
    required this.note,
    required this.onTap,
    this.archived = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final title = note.title.trim().isEmpty ? '(без заголовка)' : note.title;

    void deleteWithUndo() {
      final messenger = ScaffoldMessenger.of(context);
      final repo = ref.read(noteRepositoryProvider);
      repo.softDelete(note.id);
      messenger
        ..clearSnackBars()
        ..showSnackBar(SnackBar(
          content: Text('Запись удалена: $title'),
          action: SnackBarAction(
            label: 'Отменить',
            onPressed: () => repo.restore(note.id),
          ),
        ));
    }

    void archiveWithUndo() {
      final messenger = ScaffoldMessenger.of(context);
      final repo = ref.read(noteRepositoryProvider);
      repo.archive(note.id);
      messenger
        ..clearSnackBars()
        ..showSnackBar(SnackBar(
          content: Text('В архиве: $title'),
          action: SnackBarAction(
            label: 'Отменить',
            onPressed: () => repo.unarchive(note.id),
          ),
        ));
    }

    return Dismissible(
      key: ValueKey(note.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: theme.colorScheme.errorContainer,
        child: Icon(Icons.delete, color: theme.colorScheme.onErrorContainer),
      ),
      onDismissed: (_) => deleteWithUndo(),
      child: Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          onTap: onTap,
          leading: note.mood != null
              ? Text(note.mood!, style: const TextStyle(fontSize: 24))
              : Icon(Icons.notes, color: theme.colorScheme.onSurfaceVariant),
          title: Row(
            children: [
              if (note.pinned) ...[
                Icon(Icons.push_pin, size: 14, color: theme.colorScheme.primary),
                const SizedBox(width: 4),
              ],
              Expanded(
                child: Text(title,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          // На плашке показываем только заголовок (тело — при открытии записи).
          trailing: PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'pin':
                  ref.read(noteRepositoryProvider).togglePin(note);
                case 'edit':
                  onTap();
                case 'archive':
                  archiveWithUndo();
                case 'unarchive':
                  ref.read(noteRepositoryProvider).unarchive(note.id);
                case 'delete':
                  deleteWithUndo();
              }
            },
            itemBuilder: (context) => [
              if (!archived)
                PopupMenuItem(
                  value: 'pin',
                  child: Text(note.pinned ? 'Открепить' : 'Закрепить'),
                ),
              const PopupMenuItem(value: 'edit', child: Text('Редактировать')),
              if (archived)
                const PopupMenuItem(
                  value: 'unarchive',
                  child: Text('Вернуть из архива'),
                )
              else
                const PopupMenuItem(
                  value: 'archive',
                  child: Text('В архив'),
                ),
              const PopupMenuItem(value: 'delete', child: Text('Удалить')),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool hasNotes;
  final bool archive;
  const _EmptyState({required this.hasNotes, this.archive = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final emptyTitle = archive ? 'Архив пуст' : 'Дневник пуст';
    final emptyHint = archive
        ? 'Переносите сюда записи через меню «В архив»'
        : 'Нажмите «Запись», чтобы начать вести дневник';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(archive ? Icons.inventory_2_outlined : Icons.auto_stories,
              size: 64,
              color: theme.colorScheme.primary.withValues(alpha: 0.6)),
          const SizedBox(height: 16),
          Text(hasNotes ? 'Ничего не найдено' : emptyTitle,
              style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            hasNotes ? 'Измените запрос или фильтр' : emptyHint,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
