import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../shared/utils/icons.dart';
import '../data/skill_repository.dart';

/// Минимальное число осей, необходимое для радарной диаграммы «Розы навыков».
const int kMinAxes = 3;

/// Курируемый набор иконок для осей (const IconData — безопасно к tree-shaking).
const List<IconData> kAxisIcons = [
  Icons.favorite,
  Icons.fitness_center,
  Icons.school,
  Icons.work,
  Icons.brush,
  Icons.people,
  Icons.self_improvement,
  Icons.menu_book,
  Icons.code,
  Icons.music_note,
  Icons.sports_esports,
  Icons.restaurant,
  Icons.savings,
  Icons.spa,
  Icons.pets,
  Icons.flight_takeoff,
  Icons.home,
  Icons.lightbulb,
  Icons.psychology,
  Icons.directions_run,
  Icons.water_drop,
  Icons.bedtime,
  Icons.volunteer_activism,
  Icons.eco,
  Icons.palette,
  Icons.camera_alt,
  Icons.language,
  Icons.attach_money,
];

/// Палитра цветов для осей.
const List<Color> kAxisColors = [
  Color(0xFF16A34A),
  Color(0xFFEA580C),
  Color(0xFF38BDF8),
  Color(0xFF6D28D9),
  Color(0xFFD4AF37),
  Color(0xFFEC4899),
  Color(0xFFEF4444),
  Color(0xFF14B8A6),
  Color(0xFF8B5CF6),
  Color(0xFF22C55E),
  Color(0xFFF59E0B),
  Color(0xFF3B82F6),
];

/// Экран управления осями «розы навыков»: добавление, редактирование,
/// изменение порядка (перетаскиванием) и удаление.
class AxesManagerScreen extends ConsumerWidget {
  const AxesManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final axesAsync = ref.watch(axesStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Оси навыков')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditor(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Ось'),
      ),
      body: axesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (axes) {
          if (axes.isEmpty) {
            return const Center(child: Text('Добавьте первую ось навыка'));
          }
          return ReorderableListView.builder(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 96),
            itemCount: axes.length,
            onReorderItem: (oldIndex, newIndex) {
              // newIndex уже скорректирован под удалённый элемент.
              final ids = [for (final a in axes) a.id];
              final moved = ids.removeAt(oldIndex);
              ids.insert(newIndex, moved);
              ref.read(skillRepositoryProvider).reorder(ids);
            },
            itemBuilder: (context, i) {
              final axis = axes[i];
              return Card(
                key: ValueKey(axis.id),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Color(axis.colorValue).withValues(alpha: 0.2),
                    child: Icon(materialIcon(axis.iconCodePoint),
                        color: Color(axis.colorValue)),
                  ),
                  title: Text(axis.name),
                  subtitle: Text('Опыт оси: ${axis.xp} XP'),
                  onTap: () => _openEditor(context, ref, axis: axis),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        tooltip: 'Редактировать',
                        onPressed: () => _openEditor(context, ref, axis: axis),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        tooltip: 'Удалить',
                        onPressed: () =>
                            _deleteAxis(context, ref, axis, axes),
                      ),
                      ReorderableDragStartListener(
                        index: i,
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.drag_handle),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openEditor(BuildContext context, WidgetRef ref,
      {SkillAxe? axis}) {
    return showDialog(
      context: context,
      builder: (_) => _AxisEditorDialog(axis: axis),
    );
  }

  Future<void> _deleteAxis(BuildContext context, WidgetRef ref, SkillAxe axis,
      List<SkillAxe> allAxes) async {
    // Радар требует минимум kMinAxes осей — не даём опуститься ниже.
    if (allAxes.length <= kMinAxes) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Нужно минимум $kMinAxes оси для «Розы навыков». Удаление недоступно.'),
      ));
      return;
    }

    final repo = ref.read(skillRepositoryProvider);
    final linked = await repo.countLinked(axis.id);
    if (!context.mounted) return;

    if (linked == 0) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Удалить ось «${axis.name}»?'),
          content: const Text('Ось не привязана к задачам или привычкам.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Отмена')),
            FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Удалить')),
          ],
        ),
      );
      if (ok == true) await repo.deleteAxis(axis.id);
      return;
    }

    // Есть привязки — спрашиваем: отвязать или переназначить.
    if (!context.mounted) return;
    final others = allAxes.where((a) => a.id != axis.id).toList();
    final choice = await showDialog<_DeleteChoice>(
      context: context,
      builder: (_) => _DeleteAxisDialog(
        axis: axis,
        linkedCount: linked,
        others: others,
      ),
    );
    if (choice == null) return;
    await repo.deleteAxis(axis.id, reassignTo: choice.reassignTo);
  }
}

/// Результат диалога удаления оси с привязками.
class _DeleteChoice {
  /// Куда переназначить привязки; null — отвязать (оставить без оси).
  final String? reassignTo;
  const _DeleteChoice(this.reassignTo);
}

class _DeleteAxisDialog extends StatefulWidget {
  final SkillAxe axis;
  final int linkedCount;
  final List<SkillAxe> others;
  const _DeleteAxisDialog({
    required this.axis,
    required this.linkedCount,
    required this.others,
  });

  @override
  State<_DeleteAxisDialog> createState() => _DeleteAxisDialogState();
}

class _DeleteAxisDialogState extends State<_DeleteAxisDialog> {
  // null — «отвязать»; иначе id целевой оси.
  String? _reassignTo;
  bool _unlink = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Удалить ось «${widget.axis.name}»?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('К оси привязано элементов: ${widget.linkedCount}. '
              'Что с ними сделать?'),
          const SizedBox(height: 8),
          _OptionTile(
            selected: _unlink,
            title: 'Отвязать (оставить без оси)',
            onTap: () => setState(() => _unlink = true),
          ),
          _OptionTile(
            selected: !_unlink,
            title: 'Переназначить на другую ось',
            onTap: () => setState(() {
              _unlink = false;
              _reassignTo ??=
                  widget.others.isNotEmpty ? widget.others.first.id : null;
            }),
          ),
          if (!_unlink && widget.others.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: DropdownButton<String>(
                value: _reassignTo,
                isExpanded: true,
                items: [
                  for (final a in widget.others)
                    DropdownMenuItem(value: a.id, child: Text(a.name)),
                ],
                onChanged: (v) => setState(() => _reassignTo = v),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена')),
        FilledButton(
          onPressed: () {
            Navigator.pop(
              context,
              _DeleteChoice(_unlink ? null : _reassignTo),
            );
          },
          child: const Text('Удалить'),
        ),
      ],
    );
  }
}

/// Строка-переключатель (замена RadioListTile) с иконкой-радиокнопкой.
class _OptionTile extends StatelessWidget {
  final bool selected;
  final String title;
  final VoidCallback onTap;
  const _OptionTile(
      {required this.selected, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: selected ? theme.colorScheme.primary : null,
      ),
      title: Text(title),
    );
  }
}

/// Диалог создания/редактирования оси: имя, иконка, цвет.
class _AxisEditorDialog extends ConsumerStatefulWidget {
  final SkillAxe? axis;
  const _AxisEditorDialog({this.axis});

  @override
  ConsumerState<_AxisEditorDialog> createState() => _AxisEditorDialogState();
}

class _AxisEditorDialogState extends ConsumerState<_AxisEditorDialog> {
  late final TextEditingController _nameController;
  late int _iconCodePoint;
  late int _colorValue;

  bool get _isEditing => widget.axis != null;

  @override
  void initState() {
    super.initState();
    final a = widget.axis;
    _nameController = TextEditingController(text: a?.name ?? '');
    _iconCodePoint = a?.iconCodePoint ?? kAxisIcons.first.codePoint;
    _colorValue = a?.colorValue ?? kAxisColors.first.toARGB32();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    final repo = ref.read(skillRepositoryProvider);
    if (_isEditing) {
      await repo.updateAxis(
        id: widget.axis!.id,
        name: name,
        iconCodePoint: _iconCodePoint,
        colorValue: _colorValue,
      );
    } else {
      await repo.addAxis(
        name: name,
        iconCodePoint: _iconCodePoint,
        colorValue: _colorValue,
      );
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(_colorValue);
    return AlertDialog(
      title: Text(_isEditing ? 'Редактировать ось' : 'Новая ось'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Название',
                hintText: 'Например: Финансы',
              ),
              onSubmitted: (_) => _save(),
            ),
            const SizedBox(height: 16),
            const Text('Иконка'),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final icon in kAxisIcons)
                  InkWell(
                    onTap: () =>
                        setState(() => _iconCodePoint = icon.codePoint),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _iconCodePoint == icon.codePoint
                              ? color
                              : Colors.transparent,
                          width: 2,
                        ),
                        color: _iconCodePoint == icon.codePoint
                            ? color.withValues(alpha: 0.15)
                            : null,
                      ),
                      child: Icon(icon, color: color),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Цвет'),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in kAxisColors)
                  GestureDetector(
                    onTap: () => setState(() => _colorValue = c.toARGB32()),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _colorValue == c.toARGB32()
                              ? Colors.white
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: _colorValue == c.toARGB32()
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 18)
                          : null,
                    ),
                  ),
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
        FilledButton(
          onPressed: _save,
          child: Text(_isEditing ? 'Сохранить' : 'Создать'),
        ),
      ],
    );
  }
}
