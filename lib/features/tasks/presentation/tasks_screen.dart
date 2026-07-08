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

/// Экран задач: список с наградами за выполнение.
class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksStreamProvider);
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
      body: tasksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (tasks) {
          final pending = tasks
              .where((t) => t.status == TaskStatus.pending)
              .toList();
          final done = tasks.where((t) => t.status == TaskStatus.done).toList();

          return Column(
            children: [
              const DailyTipCard(),
              Expanded(
                child: (pending.isEmpty && done.isEmpty)
                    ? const _EmptyState()
                    : ListView(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
                        children: [
                          for (final task in pending) ...[
                            _TaskTile(task: task, axis: axesById[task.axisId]),
                            const SizedBox(height: 4),
                          ],
                          if (pending.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Text(
                                'Все задачи выполнены — герой отдыхает!',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ),
                          if (done.isNotEmpty)
                            _AchievementsSection(
                              done: done,
                              axesById: axesById,
                            ),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
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
  const _TaskTile({required this.task, this.axis});

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
          leading: IconButton(
            icon: Icon(
              done ? Icons.check_circle : Icons.radio_button_unchecked,
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
                case 'delete':
                  deleteWithUndo();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Редактировать')),
              if (done)
                const PopupMenuItem(
                  value: 'uncomplete',
                  child: Text('Снять выполнение'),
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
