import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/gamification/balance.dart';
import '../../../shared/utils/labels.dart';
import '../../skills/data/skill_repository.dart';
import '../data/task_repository.dart';

/// Диалог создания или редактирования задачи.
///
/// Если [task] задан — диалог работает в режиме редактирования (поля
/// предзаполнены, сохранение обновляет существующую запись). Иначе создаётся
/// новая задача.
class AddTaskDialog extends ConsumerStatefulWidget {
  final Task? task;

  const AddTaskDialog({super.key, this.task});

  @override
  ConsumerState<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends ConsumerState<AddTaskDialog> {
  late final TextEditingController _titleController;
  late Difficulty _difficulty;
  late String? _axisId;
  late int _minutes;
  late DateTime? _reminderAt;

  bool get _isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    final t = widget.task;
    _titleController = TextEditingController(text: t?.title ?? '');
    _difficulty = t?.difficulty ?? Difficulty.auto;
    _axisId = t?.axisId;
    _minutes = t?.estimatedMinutes ?? 25;
    _reminderAt = t?.reminderAt;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  String _formatReminder(DateTime dt) =>
      DateFormat('d MMM, HH:mm', 'ru').format(dt);

  Future<void> _pickReminder() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _reminderAt ?? now.add(const Duration(hours: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        _reminderAt ?? now.add(const Duration(hours: 1)),
      ),
    );
    if (time == null) return;
    setState(() {
      _reminderAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    final repo = ref.read(taskRepositoryProvider);
    if (_isEditing) {
      await repo.updateTask(
        id: widget.task!.id,
        title: title,
        notes: widget.task!.notes,
        axisId: _axisId,
        difficulty: _difficulty,
        estimatedMinutes: _minutes,
        dueAt: widget.task!.dueAt,
        reminderAt: _reminderAt,
      );
    } else {
      await repo.addTask(
        title: title,
        axisId: _axisId,
        difficulty: _difficulty,
        estimatedMinutes: _minutes,
        reminderAt: _reminderAt,
      );
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final axesAsync = ref.watch(axesStreamProvider);

    return AlertDialog(
      title: Text(_isEditing ? 'Редактировать задачу' : 'Новая задача'),
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
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Напоминание'),
              subtitle: Text(
                _reminderAt == null
                    ? 'Не задано'
                    : _formatReminder(_reminderAt!),
              ),
              trailing: _reminderAt == null
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _reminderAt = null),
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
        FilledButton(
          onPressed: _save,
          child: Text(_isEditing ? 'Сохранить' : 'Создать'),
        ),
      ],
    );
  }
}
