import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/audio/sound_service.dart';
import '../../../core/database/app_database.dart';
import '../../../core/gamification/balance.dart';
import '../../../core/models/enums.dart';
import '../../../shared/utils/labels.dart';
import '../../../shared/widgets/celebration.dart';
import '../../../shared/widgets/reward_snackbar.dart';
import '../data/goal_repository.dart';
import 'goal_edit_dialog.dart';

/// Детали цели/босса: полоса HP, список шагов, добавление, редактирование
/// и выполнение шагов; редактирование и удаление самой цели.
class GoalDetailScreen extends ConsumerWidget {
  final String goalId;
  const GoalDetailScreen({super.key, required this.goalId});

  Future<void> _deleteGoal(
      BuildContext context, WidgetRef ref, Goal goal) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить цель?'),
        content: Text(
          '«${goal.title}» и её шаги будут удалены. '
          'Начисленные награды останутся.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(goalRepositoryProvider).softDeleteGoal(goal.id);
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final goalAsync = ref.watch(goalStreamProvider(goalId));
    final stepsAsync = ref.watch(goalStepsStreamProvider(goalId));

    return Scaffold(
      appBar: AppBar(
        title: Text(goalAsync.value?.title ?? 'Цель'),
        actions: [
          if (goalAsync.value != null)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                final goal = goalAsync.value!;
                switch (value) {
                  case 'edit':
                    showDialog(
                      context: context,
                      builder: (_) => GoalEditDialog(goal: goal),
                    );
                  case 'delete':
                    _deleteGoal(context, ref, goal);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Редактировать'),
                ),
                const PopupMenuItem(value: 'delete', child: Text('Удалить')),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showStepDialog(context, ref, goalId: goalId),
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
                      if (goal.notes != null &&
                          goal.notes!.trim().isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          goal.notes!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      if (goal.isBoss) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 1, end: hpFrac),
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, _) =>
                                LinearProgressIndicator(
                              value: value,
                              minHeight: 14,
                              color: theme.colorScheme.error,
                              backgroundColor: theme.colorScheme.error
                                  .withValues(alpha: 0.15),
                            ),
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
      final result =
          await ref.read(goalRepositoryProvider).completeStep(step);
      final sounds = ref.read(soundServiceProvider);
      if (!context.mounted) return;
      if (result.goalCompleted && result.isBoss) {
        // Босс повержен: аплодисменты + полноэкранный фейерверк.
        sounds.play(AppSound.bossKilled);
        showCelebration(context, style: CelebrationStyle.fireworks);
      } else if (result.goalCompleted) {
        sounds.play(AppSound.goalDone);
        showCelebration(context);
      } else {
        // Обычный шаг — удар мечом.
        sounds.play(AppSound.stepDone);
      }
      showRewardSnackBar(context, result.reward);
    }

    Future<void> uncomplete() async {
      await ref.read(goalRepositoryProvider).uncompleteStep(step);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            const SnackBar(
              content: Text('Выполнение шага снято, награда возвращена'),
            ),
          );
      }
    }

    void deleteStep() {
      final messenger = ScaffoldMessenger.of(context);
      ref.read(goalRepositoryProvider).softDeleteStep(step);
      messenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Шаг удалён: ${step.title}')),
        );
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: Icon(
              done ? Icons.check_circle : Icons.radio_button_unchecked,
              key: ValueKey(done),
            ),
          ),
          color: done ? theme.colorScheme.primary : null,
          tooltip: done ? 'Снять выполнение' : 'Выполнить',
          onPressed: done ? uncomplete : complete,
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
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _showStepDialog(context, ref,
                    goalId: step.goalId, step: step);
              case 'uncomplete':
                uncomplete();
              case 'delete':
                deleteStep();
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
    );
  }
}

/// Диалог добавления/редактирования шага. Если [step] задан — редактирование.
Future<void> _showStepDialog(
  BuildContext context,
  WidgetRef ref, {
  required String goalId,
  GoalStep? step,
}) async {
  final controller = TextEditingController(text: step?.title ?? '');
  var difficulty = step?.difficulty ?? Difficulty.auto;
  var minutes = step?.estimatedMinutes ?? 25;
  final isEditing = step != null;

  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(isEditing ? 'Редактировать шаг' : 'Новый шаг'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                autofocus: !isEditing,
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
            child: Text(isEditing ? 'Сохранить' : 'Добавить'),
          ),
        ],
      ),
    ),
  );

  if (saved == true && controller.text.trim().isNotEmpty) {
    final repo = ref.read(goalRepositoryProvider);
    if (isEditing) {
      await repo.updateStep(
        step: step,
        title: controller.text.trim(),
        difficulty: difficulty,
        estimatedMinutes: minutes,
      );
    } else {
      await repo.addStep(
        goalId: goalId,
        title: controller.text.trim(),
        difficulty: difficulty,
        estimatedMinutes: minutes,
      );
    }
  }
  controller.dispose();
}
