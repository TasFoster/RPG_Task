import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/gamification/balance.dart';
import '../../../shared/utils/labels.dart';
import '../../skills/data/skill_repository.dart';
import '../data/habit_repository.dart';

/// Диалог создания новой привычки.
class AddHabitDialog extends ConsumerStatefulWidget {
  const AddHabitDialog({super.key});

  @override
  ConsumerState<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends ConsumerState<AddHabitDialog> {
  final _titleController = TextEditingController();
  Frequency _frequency = Frequency.daily;
  Difficulty _difficulty = Difficulty.auto;
  String? _axisId;
  TimeOfDay? _reminderTime;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickReminder() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _reminderTime ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (time != null) setState(() => _reminderTime = time);
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    await ref
        .read(habitRepositoryProvider)
        .addHabit(
          title: title,
          axisId: _axisId,
          frequency: _frequency,
          difficulty: _difficulty,
          reminderMinutes: _reminderTime == null
              ? null
              : _reminderTime!.hour * 60 + _reminderTime!.minute,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final axesAsync = ref.watch(axesStreamProvider);

    return AlertDialog(
      title: const Text('Новая привычка'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Название',
                hintText: 'Например: Зарядка утром',
              ),
              onSubmitted: (_) => _save(),
            ),
            const SizedBox(height: 16),
            const Text('Периодичность'),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: [
                for (final f in Frequency.values)
                  ChoiceChip(
                    label: Text(frequencyLabel(f)),
                    selected: _frequency == f,
                    onSelected: (_) => setState(() => _frequency = f),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Сложность'),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: [
                for (final d in Difficulty.values)
                  ChoiceChip(
                    label: Text(difficultyLabel(d)),
                    selected: _difficulty == d,
                    onSelected: (_) => setState(() => _difficulty = d),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            axesAsync.maybeWhen(
              data: (axes) => DropdownButtonFormField<String?>(
                isExpanded: true,
                initialValue: _axisId,
                decoration: const InputDecoration(labelText: 'Навык (ось)'),
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('Без навыка'),
                  ),
                  for (final SkillAxe a in axes)
                    DropdownMenuItem<String?>(
                      value: a.id,
                      child: Text(
                        a.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: (v) => setState(() => _axisId = v),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Ежедневное напоминание'),
              subtitle: Text(
                _reminderTime == null
                    ? 'Не задано'
                    : _reminderTime!.format(context),
              ),
              trailing: _reminderTime == null
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _reminderTime = null),
                    ),
              onTap: _pickReminder,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        FilledButton(onPressed: _save, child: const Text('Создать')),
      ],
    );
  }
}
