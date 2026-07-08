import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/enums.dart';
import '../../../shared/widgets/reward_snackbar.dart';
import '../data/quest_repository.dart';

/// Экран ежедневных квестов с прогрессом и получением награды.
class QuestsScreen extends ConsumerWidget {
  const QuestsScreen({super.key});

  static String _title(QuestType t) => switch (t) {
    QuestType.completeTasks => 'Выполнить задачи',
    QuestType.completeHabits => 'Отметить привычки',
    QuestType.focusSessions => 'Завершить фокус-сессии',
  };

  static IconData _icon(QuestType t) => switch (t) {
    QuestType.completeTasks => Icons.check_circle_outline,
    QuestType.completeHabits => Icons.local_fire_department_outlined,
    QuestType.focusSessions => Icons.timer_outlined,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questsAsync = ref.watch(todayQuestsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ежедневные квесты')),
      body: questsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (quests) => quests.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'Квесты на сегодня появятся позже',
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : ListView(
                padding: const EdgeInsets.all(12),
                children: [for (final v in quests) _QuestCard(view: v)],
              ),
      ),
    );
  }
}

class _QuestCard extends ConsumerWidget {
  final QuestView view;
  const _QuestCard({required this.view});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final q = view.quest;
    final frac = q.target <= 0
        ? 0.0
        : (view.progress / q.target).clamp(0.0, 1.0);

    Future<void> claim() async {
      final reward = await ref.read(questRepositoryProvider).claim(q);
      ref.invalidate(todayQuestsProvider);
      if (context.mounted && reward != null) {
        showRewardSnackBar(context, reward);
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  QuestsScreen._icon(q.type),
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    QuestsScreen._title(q.type),
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Text(
                  '+${q.rewardXp} XP · +${q.rewardGold}💰',
                  style: theme.textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: frac, minHeight: 8),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${view.progress} / ${q.target}',
                  style: theme.textTheme.bodySmall,
                ),
                if (q.claimed)
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      const Text('Получено'),
                    ],
                  )
                else
                  FilledButton(
                    onPressed: view.isComplete ? claim : null,
                    child: const Text('Забрать'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
