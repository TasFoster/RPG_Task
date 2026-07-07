import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/gamification/reward_service.dart';
import '../../../core/models/enums.dart';
import '../../../shared/utils/icons.dart';
import '../../../shared/utils/labels.dart';
import '../../../shared/widgets/reward_snackbar.dart';
import '../../skills/data/skill_repository.dart';
import '../../tips/data/tip.dart';
import '../../tips/presentation/tip_widgets.dart';
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
            icon: const Icon(Icons.timer_outlined),
            tooltip: 'Помодоро',
            onPressed: () => context.push('/pomodoro'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const AddTaskDialog(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Задача'),
      ),
      body: tasksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (tasks) {
          return Column(
            children: [
              const DailyTipCard(),
              Expanded(
                child: tasks.isEmpty
                    ? const _EmptyState()
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
                        itemCount: tasks.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 4),
                        itemBuilder: (context, i) {
                          final task = tasks[i];
                          return _TaskTile(
                              task: task, axis: axesById[task.axisId]);
                        },
                      ),
              ),
            ],
          );
        },
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
      if (context.mounted) showRewardSnackBar(context, reward);
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
      onDismissed: (_) => ref.read(taskRepositoryProvider).softDelete(task.id),
      child: Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: IconButton(
            icon: Icon(done
                ? Icons.check_circle
                : Icons.radio_button_unchecked),
            color: done ? theme.colorScheme.primary : null,
            onPressed: done ? null : complete,
          ),
          title: Text(
            task.title,
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
                Icon(materialIcon(axis!.iconCodePoint),
                    size: 14, color: Color(axis!.colorValue)),
                const SizedBox(width: 4),
                Text(axis!.name, style: theme.textTheme.bodySmall),
                const SizedBox(width: 10),
              ],
              Icon(Icons.bolt, size: 14, color: theme.colorScheme.secondary),
              Text(difficultyLabel(task.difficulty),
                  style: theme.textTheme.bodySmall),
              if (done) ...[
                const SizedBox(width: 10),
                Text('+${task.xpAwarded} XP',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.primary)),
              ],
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
          Icon(Icons.task_alt,
              size: 64, color: theme.colorScheme.primary.withValues(alpha: 0.6)),
          const SizedBox(height: 16),
          Text('Пока нет задач', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text('Нажмите «Задача», чтобы добавить первую',
              style: theme.textTheme.bodySmall),
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
