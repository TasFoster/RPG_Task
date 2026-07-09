import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/audio/sound_service.dart';
import '../../../core/database/app_database.dart';
import '../../../core/gamification/reward_service.dart';
import '../../../shared/utils/icons.dart';
import '../../../shared/utils/labels.dart';
import '../../../shared/widgets/reward_snackbar.dart';
import '../../../core/database/database_provider.dart';
import '../../codex/data/codex_repository.dart';
import '../../skills/data/skill_repository.dart';
import '../../widgets/home_widgets_service.dart';
import '../data/habit_repository.dart';
import 'add_habit_dialog.dart';
import 'habit_heatmap_card.dart';

/// Экран привычек: список со стриками и отметкой выполнения.
class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsStreamProvider);
    final axesById = {
      for (final a in ref.watch(axesStreamProvider).value ?? const <SkillAxe>[])
        a.id: a,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Привычки')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const AddHabitDialog(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Привычка'),
      ),
      body: habitsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (habits) {
          return Column(
            children: [
              if (habits.isNotEmpty)
                const HabitHeatmapCard(
                  title: 'Жизнь героя',
                  icon: Icons.auto_graph,
                ),
              Expanded(
                child: habits.isEmpty
                    ? const _EmptyState()
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
                        itemCount: habits.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 4),
                        itemBuilder: (context, i) {
                          final habit = habits[i];
                          return _HabitTile(
                            habit: habit,
                            axis: axesById[habit.axisId],
                          );
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

class _HabitTile extends ConsumerWidget {
  final Habit habit;
  final SkillAxe? axis;
  const _HabitTile({required this.habit, this.axis});

  bool get _doneToday {
    final last = habit.lastCompletedAt;
    if (last == null) return false;
    final now = DateTime.now();
    return last.year == now.year &&
        last.month == now.month &&
        last.day == now.day;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final doneToday = _doneToday;

    Future<void> complete() async {
      final reward = await ref.read(rewardServiceProvider).completeHabit(habit);
      if (reward != null) {
        // Рыцарский звук: удар по доспеху.
        ref.read(soundServiceProvider).play(AppSound.habitDone);
        // Активность открывает новую запись в Кодексе героя.
        await ref.read(codexRepositoryProvider).grantLoot();
        await updateHomeWidgets(ref.read(databaseProvider));
      }
      if (context.mounted && reward != null) {
        showRewardSnackBar(context, reward);
      }
    }

    // Отметка задним числом: забыл или не успел отметить вчера.
    Future<void> completeYesterday() async {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final reward = await ref
          .read(rewardServiceProvider)
          .completeHabitOn(habit, yesterday);
      if (reward != null) {
        ref.read(soundServiceProvider).play(AppSound.habitDone);
        await ref.read(codexRepositoryProvider).grantLoot();
        await updateHomeWidgets(ref.read(databaseProvider));
      }
      if (!context.mounted) return;
      if (reward == null) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            const SnackBar(content: Text('За вчера уже отмечено')),
          );
      } else {
        showRewardSnackBar(context, reward);
      }
    }

    return Dismissible(
      key: ValueKey(habit.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: theme.colorScheme.errorContainer,
        child: Icon(Icons.delete, color: theme.colorScheme.onErrorContainer),
      ),
      onDismissed: (_) =>
          ref.read(habitRepositoryProvider).softDelete(habit.id),
      child: Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                doneToday ? Icons.check_circle : Icons.radio_button_unchecked,
                key: ValueKey(doneToday),
              ),
            ),
            color: doneToday ? theme.colorScheme.primary : null,
            onPressed: doneToday ? null : complete,
          ),
          onTap: () => context.push('/habit/${habit.id}'),
          title: Text(
            habit.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
              Icon(
                Icons.calendar_today,
                size: 12,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                frequencyLabel(habit.frequency),
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StreakBadge(streak: habit.streakCurrent),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  switch (value) {
                    case 'yesterday':
                      completeYesterday();
                    case 'delete':
                      ref.read(habitRepositoryProvider).softDelete(habit.id);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'yesterday',
                    child: Text('Отметить вчера'),
                  ),
                  const PopupMenuItem(value: 'delete', child: Text('Удалить')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  final int streak;
  const _StreakBadge({required this.streak});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final active = streak > 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.local_fire_department,
          color: active
              ? const Color(0xFFEA580C)
              : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
        ),
        Text(
          '$streak',
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: active ? const Color(0xFFEA580C) : null,
          ),
        ),
      ],
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
            Icons.local_fire_department,
            size: 64,
            color: theme.colorScheme.primary.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 16),
          Text('Пока нет привычек', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Добавьте привычку и стройте серии выполнения',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
