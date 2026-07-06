import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/models/enums.dart';
import '../data/goal_repository.dart';

/// Список целей и боссов.
class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsAsync = ref.watch(goalsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Цели и боссы')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddGoal(context, ref),
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
            itemBuilder: (context, i) => _GoalTile(goal: goals[i]),
          );
        },
      ),
    );
  }
}

class _GoalTile extends StatelessWidget {
  final Goal goal;
  const _GoalTile({required this.goal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final done = goal.status == GoalStatus.completed;
    final hpFrac = goal.hpTotal == 0
        ? 0.0
        : (goal.hpRemaining / goal.hpTotal).clamp(0.0, 1.0);

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(
          goal.isBoss ? Icons.whatshot : Icons.flag,
          color: goal.isBoss ? theme.colorScheme.error : theme.colorScheme.primary,
        ),
        title: Text(
          goal.title,
          style: done
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: theme.colorScheme.onSurfaceVariant)
              : null,
        ),
        subtitle: goal.isBoss && !done
            ? Padding(
                padding: const EdgeInsets.only(top: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: hpFrac,
                    minHeight: 6,
                    color: theme.colorScheme.error,
                    backgroundColor:
                        theme.colorScheme.error.withValues(alpha: 0.15),
                  ),
                ),
              )
            : Text(done ? 'Завершено' : 'Цель'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/goals/${goal.id}'),
      ),
    );
  }
}

Future<void> _showAddGoal(BuildContext context, WidgetRef ref) async {
  final controller = TextEditingController();
  var isBoss = false;
  final created = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Новая цель'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Название',
                hintText: 'Например: Пробежать марафон',
              ),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Босс'),
              subtitle: const Text('Полоса HP и бонус за победу'),
              value: isBoss,
              onChanged: (v) => setState(() => isBoss = v),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Создать'),
          ),
        ],
      ),
    ),
  );

  if (created == true && controller.text.trim().isNotEmpty) {
    await ref
        .read(goalRepositoryProvider)
        .createGoal(title: controller.text.trim(), isBoss: isBoss);
  }
  controller.dispose();
}
