import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/gamification/balance.dart';
import '../../../shared/utils/labels.dart';
import '../../skills/data/skill_repository.dart';
import '../data/task_repository.dart';

/// Диалог создания новой задачи.
class AddTaskDialog extends ConsumerStatefulWidget {
  const AddTaskDialog({super.key});

  @override
  ConsumerState<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends ConsumerState<AddTaskDialog> {
  final _titleController = TextEditingController();
  Difficulty _difficulty = Difficulty.auto;
  String? _axisId;
  int _minutes = 25;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    await ref.read(taskRepositoryProvider).addTask(
          title: title,
          axisId: _axisId,
          difficulty: _difficulty,
          estimatedMinutes: _minutes,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final axesAsync = ref.watch(axesStreamProvider);

    return AlertDialog(
      title: const Text('Новая задача'),
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
                hintText: 'Например: Прочитать главу',
              ),
              onSubmitted: (_) => _save(),
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
                      child: Text(a.name),
                    ),
                ],
                onChanged: (v) => setState(() => _axisId = v),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Время, мин: '),
                Expanded(
                  child: Slider(
                    value: _minutes.toDouble(),
                    min: 5,
                    max: 120,
                    divisions: 23,
                    label: '$_minutes',
                    onChanged: (v) => setState(() => _minutes = v.round()),
                  ),
                ),
                Text('$_minutes'),
              ],
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
