import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/models/enums.dart';
import '../../../shared/utils/icons.dart';
import '../../skills/data/skill_repository.dart';
import '../data/goal_repository.dart';
import 'goal_edit_dialog.dart';

/// Список целей и боссов.
class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsAsync = ref.watch(goalsStreamProvider);
    final axesById = {
      for (final a in ref.watch(axesStreamProvider).value ?? const <SkillAxe>[])
        a.id: a,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Цели и боссы')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const GoalEditDialog(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Цель'),
      ),
      body: goalsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (goals) {
          if (goals.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'Поставьте большую цель или создайте босса — '
                  'разбейте его на шаги и побеждайте по частям.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
            itemCount: goals.length,
            separatorBuilder: (_, _) => const SizedBox(height: 4),
            itemBuilder: (context, i) => _GoalTile(
              goal: goals[i],
              axis: axesById[goals[i].axisId],
            ),
          );
        },
      ),
    );
  }
}

class _GoalTile extends ConsumerWidget {
  final Goal goal;
  final SkillAxe? axis;
  const _GoalTile({required this.goal, this.axis});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final done = goal.status == GoalStatus.completed;
    final hpFrac = goal.hpTotal == 0
        ? 0.0
        : (goal.hpRemaining / goal.hpTotal).clamp(0.0, 1.0);

    void deleteWithUndo() {
      final messenger = ScaffoldMessenger.of(context);
      final repo = ref.read(goalRepositoryProvider);
      repo.softDeleteGoal(goal.id);
      messenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text('Цель удалена: ${goal.title}'),
            action: SnackBarAction(
              label: 'Отменить',
              onPressed: () => repo.restoreGoal(goal.id),
            ),
          ),
        );
    }

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(
          goal.isBoss ? Icons.whatshot : Icons.flag,
          color: goal.isBoss
              ? theme.colorScheme.error
              : theme.colorScheme.primary,
        ),
        title: Text(
          goal.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: done
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: theme.colorScheme.onSurfaceVariant,
                )
              : null,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (goal.isBoss && !done)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: hpFrac, end: hpFrac),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) => LinearProgressIndicator(
                      value: value,
                      minHeight: 6,
                      color: theme.colorScheme.error,
                      backgroundColor: theme.colorScheme.error.withValues(
                        alpha: 0.15,
                      ),
                    ),
                  ),
                ),
              )
            else
              Text(done ? 'Завершено' : 'Цель'),
            if (axis != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      materialIcon(axis!.iconCodePoint),
                      size: 13,
                      color: Color(axis!.colorValue),
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        axis!.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Color(axis!.colorValue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case 'open':
                context.push('/goals/${goal.id}');
              case 'edit':
                showDialog(
                  context: context,
                  builder: (_) => GoalEditDialog(goal: goal),
                );
              case 'delete':
                deleteWithUndo();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'open', child: Text('Открыть')),
            const PopupMenuItem(value: 'edit', child: Text('Редактировать')),
            const PopupMenuItem(value: 'delete', child: Text('Удалить')),
          ],
        ),
        onTap: () => context.push('/goals/${goal.id}'),
      ),
    );
  }
}
