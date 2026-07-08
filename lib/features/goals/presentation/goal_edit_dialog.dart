import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../skills/data/skill_repository.dart';
import '../data/goal_repository.dart';

/// Диалог создания/редактирования цели или босса.
/// Если [goal] задан — режим редактирования.
class GoalEditDialog extends ConsumerStatefulWidget {
  final Goal? goal;
  const GoalEditDialog({super.key, this.goal});

  @override
  ConsumerState<GoalEditDialog> createState() => _GoalEditDialogState();
}

class _GoalEditDialogState extends ConsumerState<GoalEditDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _notesController;
  late String? _axisId;
  late bool _isBoss;

  bool get _isEditing => widget.goal != null;

  @override
  void initState() {
    super.initState();
    final g = widget.goal;
    _titleController = TextEditingController(text: g?.title ?? '');
    _notesController = TextEditingController(text: g?.notes ?? '');
    _axisId = g?.axisId;
    _isBoss = g?.isBoss ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    final notes = _notesController.text.trim();
    final repo = ref.read(goalRepositoryProvider);
    if (_isEditing) {
      await repo.updateGoal(
        id: widget.goal!.id,
        title: title,
        notes: notes.isEmpty ? null : notes,
        axisId: _axisId,
        isBoss: _isBoss,
      );
    } else {
      await repo.createGoal(
        title: title,
        notes: notes.isEmpty ? null : notes,
        axisId: _axisId,
        isBoss: _isBoss,
      );
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final axesAsync = ref.watch(axesStreamProvider);

    return AlertDialog(
      title: Text(_isEditing ? 'Редактировать цель' : 'Новая цель'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              autofocus: !_isEditing,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Название',
                hintText: 'Например: Пробежать марафон',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              maxLines: 3,
              minLines: 1,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Заметки',
              ),
            ),
            const SizedBox(height: 12),
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
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Босс'),
              subtitle: const Text('Полоса HP и бонус за победу'),
              value: _isBoss,
              onChanged: (v) => setState(() => _isBoss = v),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
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
