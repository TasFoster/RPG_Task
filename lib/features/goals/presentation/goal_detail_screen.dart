import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/gamification/balance.dart';
import '../../../core/models/enums.dart';
import '../../../shared/utils/labels.dart';
import '../../../shared/widgets/reward_snackbar.dart';
import '../data/goal_repository.dart';

/// Детали цели/босса: полоса HP, список шагов, добавление и выполнение.
class GoalDetailScreen extends ConsumerWidget {
  final String goalId;
  const GoalDetailScreen({super.key, required this.goalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final goalAsync = ref.watch(goalStreamProvider(goalId));
    final stepsAsync = ref.watch(goalStepsStreamProvider(goalId));

    return Scaffold(
      appBar: AppBar(
        title: Text(goalAsync.value?.title ?? 'Цель'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddStep(context, ref, goalId),
        icon: const Icon(Icons.add),
        label: const Text('Шаг'),
      ),
      body: goalAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (goal) {
          if (goal == null) {
            return const Center(child: Text('Цель не найдена'));
          }
          final steps = stepsAsync.value ?? const <GoalStep>[];
          final doneCount =
              steps.where((s) => s.status == TaskStatus.done).length;
          final hpFrac = goal.hpTotal == 0
              ? 0.0
              : (goal.hpRemaining / goal.hpTotal).clamp(0.0, 1.0);

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            goal.isBoss ? Icons.whatshot : Icons.flag,
                            color: goal.isBoss
                                ? theme.colorScheme.error
                                : theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            goal.isBoss ? 'Босс' : 'Цель',
                            style: theme.textTheme.titleMedium,
                          ),
                          const Spacer(),
                          if (goal.status == GoalStatus.completed)
                            Chip(
                              label: const Text('Повержен'),
                              backgroundColor:
                                  theme.colorScheme.primaryContainer,
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (goal.isBoss) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: hpFrac,
                            minHeight: 14,
                            color: theme.colorScheme.error,
                            backgroundColor:
                                theme.colorScheme.error.withValues(alpha: 0.15),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text('HP: ${goal.hpRemaining} / ${goal.hpTotal}',
                            style: theme.textTheme.bodySmall),
                      ] else
                        Text('Прогресс: $doneCount / ${steps.length} шагов',
                            style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Шаги', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              if (steps.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Добавьте шаги, чтобы продвигаться к цели.'),
                )
              else
                for (final step in steps)
                  _StepTile(step: step),
            ],
          );
        },
      ),
    );
  }
}

class _StepTile extends ConsumerWidget {
  final GoalStep step;
  const _StepTile({required this.step});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final done = step.status == TaskStatus.done;

    Future<void> complete() async {
      final reward = await ref.read(goalRepositoryProvider).completeStep(step);
      if (context.mounted) showRewardSnackBar(context, reward);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: IconButton(
          icon: Icon(
              done ? Icons.check_circle : Icons.radio_button_unchecked),
          color: done ? theme.colorScheme.primary : null,
          onPressed: done ? null : complete,
        ),
        title: Text(
          step.title,
          style: done
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: theme.colorScheme.onSurfaceVariant)
              : null,
        ),
        subtitle: Text(
            '${difficultyLabel(step.difficulty)} · ${step.estimatedMinutes} мин · ~${step.expectedXp} XP'),
      ),
    );
  }
}

Future<void> _showAddStep(
    BuildContext context, WidgetRef ref, String goalId) async {
  final controller = TextEditingController();
  var difficulty = Difficulty.auto;
  var minutes = 25;

  final created = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Новый шаг'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Название шага'),
              ),
              const SizedBox(height: 16),
              const Text('Сложность'),
              Wrap(
                spacing: 8,
                children: [
                  for (final d in Difficulty.values)
                    ChoiceChip(
                      label: Text(difficultyLabel(d)),
                      selected: difficulty == d,
                      onSelected: (_) => setState(() => difficulty = d),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Время, мин: '),
                  Expanded(
                    child: Slider(
                      value: minutes.toDouble(),
                      min: 5,
                      max: 120,
                      divisions: 23,
                      label: '$minutes',
                      onChanged: (v) => setState(() => minutes = v.round()),
                    ),
                  ),
                  Text('$minutes'),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Добавить'),
          ),
        ],
      ),
    ),
  );

  if (created == true && controller.text.trim().isNotEmpty) {
    await ref.read(goalRepositoryProvider).addStep(
          goalId: goalId,
          title: controller.text.trim(),
          difficulty: difficulty,
          estimatedMinutes: minutes,
        );
  }
  controller.dispose();
}
