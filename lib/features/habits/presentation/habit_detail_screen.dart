import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/audio/sound_service.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/gamification/reward_service.dart';
import '../../../shared/widgets/reward_snackbar.dart';
import '../../codex/data/codex_repository.dart';
import '../../widgets/home_widgets_service.dart';
import '../data/habit_repository.dart';
import 'add_habit_dialog.dart';
import 'habit_heatmap_card.dart';

/// Экран детали привычки: хитмап выполнений и статистика серий.
class HabitDetailScreen extends ConsumerWidget {
  final String habitId;
  const HabitDetailScreen({super.key, required this.habitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final habitAsync = ref.watch(habitByIdProvider(habitId));

    return Scaffold(
      appBar: AppBar(
        title: Text(habitAsync.value?.title ?? 'Привычка'),
        actions: [
          if (habitAsync.value != null)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Редактировать',
              onPressed: () => showDialog(
                context: context,
                builder: (_) => AddHabitDialog(habit: habitAsync.value),
              ),
            ),
        ],
      ),
      body: habitAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (habit) {
          if (habit == null) {
            return const Center(child: Text('Привычка не найдена'));
          }
          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.local_fire_department,
                        color: const Color(0xFFEA580C),
                        label: 'Текущая серия',
                        value: '${habit.streakCurrent}',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.emoji_events,
                        color: theme.colorScheme.tertiary,
                        label: 'Рекорд серии',
                        value: '${habit.streakBest}',
                      ),
                    ),
                  ],
                ),
              ),
              _BackfillYesterdayCard(habitId: habitId),
              HabitHeatmapCard(
                habitId: habitId,
                title: 'Выполнения',
                icon: Icons.calendar_view_month,
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Кнопка «Отметить вчера»: видна, только если вчера ещё не отмечено.
class _BackfillYesterdayCard extends ConsumerWidget {
  final String habitId;
  const _BackfillYesterdayCard({required this.habitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final heatmap = ref.watch(habitHeatmapProvider(habitId)).value;
    if (heatmap == null) return const SizedBox.shrink();

    final yesterday = HabitRepository.dayOnly(
      DateTime.now().subtract(const Duration(days: 1)),
    );
    if ((heatmap[yesterday] ?? 0) > 0) return const SizedBox.shrink();

    Future<void> completeYesterday() async {
      final habit =
          await ref.read(habitRepositoryProvider).habitById(habitId);
      if (habit == null) return;
      final reward = await ref
          .read(rewardServiceProvider)
          .completeHabitOn(habit, yesterday);
      if (reward != null) {
        ref.read(soundServiceProvider).play(AppSound.habitDone);
        await ref.read(codexRepositoryProvider).grantLoot();
        await updateHomeWidgets(ref.read(databaseProvider));
      }
      if (context.mounted && reward != null) {
        showRewardSnackBar(context, reward);
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.history, color: theme.colorScheme.primary),
          title: const Text('Забыли отметить вчера?'),
          subtitle: const Text('Отметка задним числом сохранит серию'),
          trailing: FilledButton.tonal(
            onPressed: completeYesterday,
            child: const Text('Отметить'),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(value, style: theme.textTheme.titleLarge),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
