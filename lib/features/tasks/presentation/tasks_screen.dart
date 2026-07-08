import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/gamification/reward_service.dart';
import '../../../core/models/enums.dart';
import '../../../shared/utils/icons.dart';
import '../../../shared/utils/labels.dart';
import '../../../shared/widgets/reward_snackbar.dart';
import '../../../core/database/database_provider.dart';
import '../../codex/data/codex_repository.dart';
import '../../skills/data/skill_repository.dart';
import '../../tips/data/tip.dart';
import '../../tips/presentation/tip_widgets.dart';
import '../../widgets/home_widgets_service.dart';
import '../data/task_repository.dart';
import 'add_task_dialog.dart';

/// Фильтр списка задач.
enum _TaskFilter { all, pending, done, archive }

/// Экран задач: список с наградами за выполнение, поиском,
/// фильтрами и архивом.
class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  _TaskFilter _filter = _TaskFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inArchive = _filter == _TaskFilter.archive;
    final tasksAsync = ref.watch(
      inArchive ? archivedTasksStreamProvider : tasksStreamProvider,
    );
    final axesAsync = ref.watch(axesStreamProvider);
    final axesById = {
      for (final a in axesAsync.value ?? const <SkillAxe>[]) a.id: a,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Задачи'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book_outlined),
            tooltip: 'Кодекс героя',
            onPressed: () => context.push('/codex'),
          ),
          IconButton(
            icon: const Icon(Icons.timer_outlined),
            tooltip: 'Помодоро',
            onPressed: () => context.push('/pomodoro'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            showDialog(context: context, builder: (_) => const AddTaskDialog()),
        icon: const Icon(Icons.add),
        label: const Text('Задача'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Поиск по задачам',
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
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                for (final (f, label) in const [
                  (_TaskFilter.all, 'Все'),
                  (_TaskFilter.pending, 'Активные'),
                  (_TaskFilter.done, 'Выполненные'),
                  (_TaskFilter.archive, 'Архив'),
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(label),
                      selected: _filter == f,
                      onSelected: (_) => setState(() => _filter = f),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: tasksAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Ошибка: $e')),
              data: (tasks) {
                final q = _query.trim().toLowerCase();
                final filtered = tasks.where((t) {
                  if (q.isEmpty) return true;
                  return t.title.toLowerCase().contains(q) ||
                      (t.notes?.toLowerCase().contains(q) ?? false);
                }).toList();

                if (inArchive) {
                  return _buildArchive(filtered, axesById);
                }

                final pending = filtered
                    .where((t) => t.status == TaskStatus.pending)
                    .toList();
                final done = filtered
                    .where((t) => t.status == TaskStatus.done)
                    .toList();

                return Column(
                  children: [
                    if (_filter == _TaskFilter.all && q.isEmpty)
                      const DailyTipCard(),
                    Expanded(
                      child: (pending.isEmpty && done.isEmpty)
                          ? (q.isEmpty
                              ? const _EmptyState()
                              : const _NothingFound())
                          : ListView(
                              padding:
                                  const EdgeInsets.fromLTRB(12, 8, 12, 96),
                              children: [
                                if (_filter != _TaskFilter.done) ...[
                                  for (final task in pending) ...[
                                    _TaskTile(
                                      task: task,
                                      axis: axesById[task.axisId],
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                  if (pending.isEmpty &&
                                      _filter == _TaskFilter.all)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 24),
                                      child: Text(
                                        'Все задачи выполнены — герой отдыхает!',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                            ),
                                      ),
                                    ),
                                ],
                                if (_filter == _TaskFilter.all &&
                                    done.isNotEmpty)
                                  _AchievementsSection(
                                    done: done,
                                    axesById: axesById,
                                  ),
                                if (_filter == _TaskFilter.done)
                                  for (final task in done) ...[
                                    _TaskTile(
                                      task: task,
                                      axis: axesById[task.axisId],
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                              ],
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArchive(List<Task> tasks, Map<String, SkillAxe> axesById) {
    if (tasks.isEmpty) {
      return _query.isEmpty
          ? const _EmptyArchive()
          : const _NothingFound();
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
      children: [
        for (final task in tasks) ...[
          _TaskTile(
            task: task,
            axis: axesById[task.axisId],
            archived: true,
          ),
          const SizedBox(height: 4),
        ],
      ],
    );
  }
}

/// Сворачиваемая секция «Свершения» — выполненные задачи.
class _AchievementsSection extends StatelessWidget {
  final List<Task> done;
  final Map<String, SkillAxe> axesById;
  const _AchievementsSection({required this.done, required this.axesById});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      // Убираем разделители ExpansionTile для аккуратного вида в списке.
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        childrenPadding: EdgeInsets.zero,
        leading: Icon(
          Icons.emoji_events_outlined,
          color: theme.colorScheme.primary,
        ),
        title: Text(
          'Свершения (${done.length})',
          style: theme.textTheme.titleSmall,
        ),
        children: [
          for (final task in done) ...[
            _TaskTile(task: task, axis: axesById[task.axisId]),
            const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }
}

class _TaskTile extends ConsumerWidget {
  final Task task;
  final SkillAxe? axis;
  final bool archived;
  const _TaskTile({required this.task, this.axis, this.archived = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final done = task.status == TaskStatus.done;

    Future<void> complete() async {
      final reward = await ref.read(rewardServiceProvider).completeTask(task);
      // Задача выполнена — разовое напоминание больше не нужно.
      await ref.read(taskRepositoryProvider).cancelReminder(task.id);
      // Активность открывает новую запись в Кодексе героя.
      await ref.read(codexRepositoryProvider).grantLoot();
      await updateHomeWidgets(ref.read(databaseProvider));
      if (context.mounted) showRewardSnackBar(context, reward);
    }

    Future<void> uncomplete() async {
      await ref.read(rewardServiceProvider).uncompleteTask(task);
      await updateHomeWidgets(ref.read(databaseProvider));
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            const SnackBar(
              content: Text('Выполнение снято, награда возвращена'),
            ),
          );
      }
    }

    Future<void> edit() async {
      await showDialog(
        context: context,
        builder: (_) => AddTaskDialog(task: task),
      );
    }

    void archive() {
      final messenger = ScaffoldMessenger.of(context);
      final repo = ref.read(taskRepositoryProvider);
      repo.archive(task.id);
      messenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text('В архиве: ${task.title}'),
            action: SnackBarAction(
              label: 'Отменить',
              onPressed: () => repo.unarchive(task.id),
            ),
          ),
        );
    }

    void unarchive() {
      ref.read(taskRepositoryProvider).unarchive(task.id);
    }

    void deleteWithUndo() {
      final messenger = ScaffoldMessenger.of(context);
      final repo = ref.read(taskRepositoryProvider);
      final db = ref.read(databaseProvider);
      repo.softDelete(task.id);
      updateHomeWidgets(db);
      messenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text('Задача удалена: ${task.title}'),
            action: SnackBarAction(
              label: 'Отменить',
              onPressed: () async {
                await repo.restore(task.id);
                await updateHomeWidgets(db);
              },
            ),
          ),
        );
    }

    return Dismissible(
      key: ValueKey(task.id),
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
          onTap: edit,
          leading: archived
              ? Icon(
                  done ? Icons.check_circle : Icons.inventory_2_outlined,
                  color: done
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                )
              : IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Icon(
                      done
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      key: ValueKey(done),
                    ),
                  ),
                  color: done ? theme.colorScheme.primary : null,
                  tooltip: done ? 'Снять выполнение' : 'Выполнить',
                  onPressed: done ? uncomplete : complete,
                ),
          title: Text(
            task.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: done
                ? theme.textTheme.bodyLarge?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: theme.colorScheme.onSurfaceVariant,
                  )
                : theme.textTheme.bodyLarge,
          ),
          subtitle: Row(
            children: [
              if (axis != null) ...[
                Icon(
                  materialIcon(axis!.iconCodePoint),
                  size: 14,
                  color: Color(axis!.colorValue),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    axis!.name,
                    style: theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Icon(Icons.bolt, size: 14, color: theme.colorScheme.secondary),
              Text(
                difficultyLabel(task.difficulty),
                style: theme.textTheme.bodySmall,
              ),
              if (done) ...[
                const SizedBox(width: 10),
                Text(
                  '+${task.xpAwarded} XP',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ],
          ),
          trailing: PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  edit();
                case 'uncomplete':
                  uncomplete();
                case 'archive':
                  archive();
                case 'unarchive':
                  unarchive();
                case 'delete':
                  deleteWithUndo();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Редактировать')),
              if (done && !archived)
                const PopupMenuItem(
                  value: 'uncomplete',
                  child: Text('Снять выполнение'),
                ),
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
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 64,
            color: theme.colorScheme.primary.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 16),
          Text('Пока нет задач', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Нажмите «Задача», чтобы добавить первую',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          ContextualTip(
            category: TipCategory.motivation,
            salt: DateTime.now().day,
          ),
        ],
      ),
    );
  }
}

class _EmptyArchive extends StatelessWidget {
  const _EmptyArchive();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: theme.colorScheme.primary.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 16),
          Text('Архив пуст', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Переносите сюда задачи через меню «В архив»',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _NothingFound extends StatelessWidget {
  const _NothingFound();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        'Ничего не найдено',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
