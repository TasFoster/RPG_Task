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
  final _bodyFocus = FocusNode();
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
    // Существующую запись открываем сразу в режиме «Просмотр» (Markdown),
    // новую — в «Правке», чтобы можно было начать писать.
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: n != null ? 1 : 0,
    );
    // Панель форматирования показывается только на вкладке «Правка».
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
    _axisId = n?.axisId;
    _mood = n?.mood;
    _pinned = n?.pinned ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _tabController.dispose();
    _bodyFocus.dispose();
    super.dispose();
  }

  // ---- Быстрые инструменты форматирования Markdown ----

  /// Оборачивает выделение в [prefix]…[suffix] (курсор — внутрь, если пусто).
  void _wrapSelection(String prefix, [String? suffix]) {
    suffix ??= prefix;
    final text = _bodyController.text;
    var sel = _bodyController.selection;
    if (!sel.isValid) sel = TextSelection.collapsed(offset: text.length);
    final selected = sel.textInside(text);
    _bodyController.value = TextEditingValue(
      text: sel.textBefore(text) + prefix + selected + suffix + sel.textAfter(text),
      selection: selected.isEmpty
          ? TextSelection.collapsed(offset: sel.start + prefix.length)
          : TextSelection(
              baseOffset: sel.start + prefix.length,
              extentOffset: sel.end + prefix.length,
            ),
    );
    _bodyFocus.requestFocus();
  }

  /// Ставит [prefix] в начало каждой строки, попавшей в выделение.
  void _prefixLines(String prefix) {
    final text = _bodyController.text;
    var sel = _bodyController.selection;
    if (!sel.isValid) sel = TextSelection.collapsed(offset: text.length);
    final lineStart =
        sel.start <= 0 ? 0 : text.lastIndexOf('\n', sel.start - 1) + 1;
    final segment = text.substring(lineStart, sel.end);
    final lines = segment.split('\n');
    final newSegment = [
      for (final line in lines)
        // Пустые строки внутри многострочного выделения не префиксуем.
        (line.isEmpty && lines.length > 1) ? line : '$prefix$line',
    ].join('\n');
    final delta = newSegment.length - segment.length;
    _bodyController.value = TextEditingValue(
      text: text.substring(0, lineStart) + newSegment + text.substring(sel.end),
      selection: TextSelection.collapsed(offset: sel.end + delta),
    );
    _bodyFocus.requestFocus();
  }

  /// Вставляет блок [snippet] в позицию курсора.
  void _insertBlock(String snippet) {
    final text = _bodyController.text;
    var sel = _bodyController.selection;
    if (!sel.isValid) sel = TextSelection.collapsed(offset: text.length);
    _bodyController.value = TextEditingValue(
      text: sel.textBefore(text) + snippet + sel.textAfter(text),
      selection: TextSelection.collapsed(offset: sel.start + snippet.length),
    );
    _bodyFocus.requestFocus();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();
    if (title.isEmpty && body.isEmpty) {
      // Если существующую запись очистили полностью — удаляем её (мягко),
      // чтобы действие пользователя не терялось молча.
      if (_isEditing) {
        await ref.read(noteRepositoryProvider).softDelete(widget.note!.id);
      }
      if (mounted) Navigator.of(context).pop();
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
        children: [_buildEdit(context), _buildPreview(context)],
      ),
      // Панель быстрого форматирования — только на вкладке «Правка».
      bottomNavigationBar:
          _tabController.index == 0 ? _buildFormatToolbar(context) : null,
    );
  }

  Widget _buildFormatToolbar(BuildContext context) {
    final theme = Theme.of(context);

    Widget btn({
      required IconData icon,
      required String tooltip,
      required VoidCallback onTap,
    }) {
      return IconButton(
        icon: Icon(icon, size: 20),
        tooltip: tooltip,
        visualDensity: VisualDensity.compact,
        onPressed: onTap,
      );
    }

    return Material(
      color: theme.colorScheme.surfaceContainerHigh,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 44,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                btn(
                  icon: Icons.format_bold,
                  tooltip: 'Жирный',
                  onTap: () => _wrapSelection('**'),
                ),
                btn(
                  icon: Icons.format_italic,
                  tooltip: 'Курсив',
                  onTap: () => _wrapSelection('*'),
                ),
                btn(
                  icon: Icons.strikethrough_s,
                  tooltip: 'Зачёркнутый',
                  onTap: () => _wrapSelection('~~'),
                ),
                const VerticalDivider(width: 8, indent: 10, endIndent: 10),
                btn(
                  icon: Icons.title,
                  tooltip: 'Заголовок',
                  onTap: () => _prefixLines('## '),
                ),
                btn(
                  icon: Icons.format_list_bulleted,
                  tooltip: 'Список',
                  onTap: () => _prefixLines('- '),
                ),
                btn(
                  icon: Icons.format_list_numbered,
                  tooltip: 'Нумерованный список',
                  onTap: () => _prefixLines('1. '),
                ),
                btn(
                  icon: Icons.check_box_outlined,
                  tooltip: 'Чек-лист',
                  onTap: () => _prefixLines('- [ ] '),
                ),
                btn(
                  icon: Icons.format_quote,
                  tooltip: 'Цитата',
                  onTap: () => _prefixLines('> '),
                ),
                const VerticalDivider(width: 8, indent: 10, endIndent: 10),
                btn(
                  icon: Icons.code,
                  tooltip: 'Код',
                  onTap: () => _wrapSelection('`'),
                ),
                btn(
                  icon: Icons.link,
                  tooltip: 'Ссылка',
                  onTap: () => _wrapSelection('[', '](https://)'),
                ),
                btn(
                  icon: Icons.horizontal_rule,
                  tooltip: 'Разделитель',
                  onTap: () => _insertBlock('\n\n---\n\n'),
                ),
              ],
            ),
          ),
        ),
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
          focusNode: _bodyFocus,
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
      ],
    );
  }

  Widget _buildPreview(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();
    if (title.isEmpty && body.isEmpty) {
      return Center(
        child: Text(
          'Нечего показать',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
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
            config: isDark
                ? MarkdownConfig.darkConfig
                : MarkdownConfig.defaultConfig,
          ),
        ],
      ),
    );
  }
}
