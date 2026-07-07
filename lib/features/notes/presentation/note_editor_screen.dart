import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../../../core/database/app_database.dart';
import '../../../shared/widgets/reward_snackbar.dart';
import '../../skills/data/skill_repository.dart';
import '../data/note_repository.dart';

/// Доступные настроения (эмодзи). null — без настроения.
const kMoods = ['😄', '🙂', '😐', '😔', '😤', '😰', '😴', '🤒'];

/// Полноэкранный редактор заметки «Дневника».
///
/// Если [note] задан — режим редактирования; иначе создаётся новая запись.
class NoteEditorScreen extends ConsumerStatefulWidget {
  final Note? note;
  const NoteEditorScreen({super.key, this.note});

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late final TabController _tabController;
  late String? _axisId;
  late String? _mood;
  late bool _pinned;

  bool get _isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();
    final n = widget.note;
    _titleController = TextEditingController(text: n?.title ?? '');
    _bodyController = TextEditingController(text: n?.body ?? '');
    _tabController = TabController(length: 2, vsync: this);
    _axisId = n?.axisId;
    _mood = n?.mood;
    _pinned = n?.pinned ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();
    if (title.isEmpty && body.isEmpty) {
      Navigator.of(context).pop();
      return;
    }
    final repo = ref.read(noteRepositoryProvider);
    if (_isEditing) {
      await repo.updateNote(
        id: widget.note!.id,
        title: title,
        body: body,
        axisId: _axisId,
        mood: _mood,
        pinned: _pinned,
      );
      if (mounted) Navigator.of(context).pop();
    } else {
      final reward = await repo.addNote(
        title: title,
        body: body,
        axisId: _axisId,
        mood: _mood,
        pinned: _pinned,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      if (reward != null) showRewardSnackBar(context, reward);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Запись' : 'Новая запись'),
        actions: [
          IconButton(
            icon: Icon(_pinned ? Icons.push_pin : Icons.push_pin_outlined),
            tooltip: _pinned ? 'Открепить' : 'Закрепить',
            onPressed: () => setState(() => _pinned = !_pinned),
          ),
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'Сохранить',
            onPressed: _save,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Правка'),
            Tab(text: 'Просмотр'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEdit(context),
          _buildPreview(context),
        ],
      ),
    );
  }

  Widget _buildEdit(BuildContext context) {
    final axesAsync = ref.watch(axesStreamProvider);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        TextField(
          controller: _titleController,
          textCapitalization: TextCapitalization.sentences,
          style: Theme.of(context).textTheme.titleLarge,
          decoration: const InputDecoration(
            hintText: 'Заголовок',
            border: InputBorder.none,
          ),
        ),
        const Divider(),
        TextField(
          controller: _bodyController,
          maxLines: null,
          minLines: 8,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            hintText: 'Текст записи (поддерживается Markdown)…',
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 20),
        Text('Настроение', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            for (final m in kMoods)
              GestureDetector(
                onTap: () => setState(() => _mood = _mood == m ? null : m),
                child: CircleAvatar(
                  backgroundColor: _mood == m
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Text(m, style: const TextStyle(fontSize: 20)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
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
      ],
    );
  }

  Widget _buildPreview(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();
    if (title.isEmpty && body.isEmpty) {
      return Center(
        child: Text('Нечего показать',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
          ],
          MarkdownBlock(
            data: body,
            config:
                isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig,
          ),
        ],
      ),
    );
  }
}
