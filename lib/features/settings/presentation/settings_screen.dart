import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/notifications/notification_service.dart';
import '../../tips/data/tips_push.dart';
import '../../tips/data/tips_service.dart';
import '../../tips/data/tips_settings.dart';

/// Экран настроек: советы/мотивация (Этап A/B) и уведомления (Фаза 3).
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool? _granted;
  bool _busy = false;

  Future<void> _requestPermissions() async {
    setState(() => _busy = true);
    final granted =
        await ref.read(notificationServiceProvider).requestPermissions();
    if (mounted) {
      setState(() {
        _granted = granted;
        _busy = false;
      });
    }
  }

  /// Сохраняет настройки советов и перепланирует пуши.
  Future<void> _saveTips(TipsSettings next) async {
    await ref.read(tipsSettingsProvider.notifier).save(next);
    if (next.anyPush) {
      await ref.read(notificationServiceProvider).requestPermissions();
    }
    await applyTipPushSchedule(
      ref.read(notificationServiceProvider),
      ref.read(tipsServiceProvider),
      next,
    );
  }

  Future<void> _pickTime(int minuteOfDay, ValueChanged<int> onPicked) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: minuteOfDay ~/ 60, minute: minuteOfDay % 60),
    );
    if (picked != null) onPicked(picked.hour * 60 + picked.minute);
  }

  String _fmt(int minuteOfDay) {
    final h = (minuteOfDay ~/ 60).toString().padLeft(2, '0');
    final m = (minuteOfDay % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final supported = ref.read(notificationServiceProvider).isSupported;
    final tips = ref.watch(tipsSettingsProvider).value ?? const TipsSettings();

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Советы и мотивация', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.auto_stories),
                  title: const Text('Совет дня на главной'),
                  subtitle: const Text('Цитата или совет вверху экрана задач'),
                  value: tips.dailyEnabled,
                  onChanged: (v) =>
                      _saveTips(tips.copyWith(dailyEnabled: v)),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.tips_and_updates_outlined),
                  title: const Text('Контекстные подсказки'),
                  subtitle:
                      const Text('В пустых списках, на Помодоро и т.п.'),
                  value: tips.contextualEnabled,
                  onChanged: (v) =>
                      _saveTips(tips.copyWith(contextualEnabled: v)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Пуш-советы', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          if (!supported)
            const Card(
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Пуш-советы доступны на телефоне'),
                subtitle: Text('В веб-версии уведомления отключены.'),
              ),
            )
          else
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.wb_sunny_outlined),
                    title: const Text('Утренний девиз'),
                    subtitle: Text('Каждый день в ${_fmt(tips.morningMinute)}'),
                    value: tips.pushMorning,
                    onChanged: (v) =>
                        _saveTips(tips.copyWith(pushMorning: v)),
                  ),
                  if (tips.pushMorning)
                    ListTile(
                      leading: const SizedBox(width: 24),
                      title: const Text('Время'),
                      trailing: Text(_fmt(tips.morningMinute)),
                      onTap: () => _pickTime(
                        tips.morningMinute,
                        (m) => _saveTips(tips.copyWith(morningMinute: m)),
                      ),
                    ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.nightlight_outlined),
                    title: const Text('Вечерняя рефлексия'),
                    subtitle:
                        Text('Каждый день в ${_fmt(tips.eveningMinute)}'),
                    value: tips.pushEvening,
                    onChanged: (v) =>
                        _saveTips(tips.copyWith(pushEvening: v)),
                  ),
                  if (tips.pushEvening)
                    ListTile(
                      leading: const SizedBox(width: 24),
                      title: const Text('Время'),
                      trailing: Text(_fmt(tips.eveningMinute)),
                      onTap: () => _pickTime(
                        tips.eveningMinute,
                        (m) => _saveTips(tips.copyWith(eveningMinute: m)),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 24),
          Text('Уведомления', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!supported) ...[
                    Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: theme.colorScheme.onSurfaceVariant),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Уведомления доступны на мобильном устройстве '
                            '(Android/iOS). В веб-версии они отключены.',
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    const Text(
                      'Разрешите уведомления, чтобы получать напоминания '
                      'о задачах, привычках и советах в назначенное время.',
                    ),
                    const SizedBox(height: 12),
                    if (_granted != null)
                      Row(
                        children: [
                          Icon(
                            _granted!
                                ? Icons.check_circle
                                : Icons.cancel_outlined,
                            color: _granted!
                                ? theme.colorScheme.primary
                                : theme.colorScheme.error,
                          ),
                          const SizedBox(width: 8),
                          Text(_granted!
                              ? 'Разрешение выдано'
                              : 'Разрешение не выдано'),
                        ],
                      ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: _busy ? null : _requestPermissions,
                      icon: _busy
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.notifications_active_outlined),
                      label: const Text('Запросить разрешение'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
