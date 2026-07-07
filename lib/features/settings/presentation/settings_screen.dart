import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/notifications/notification_service.dart';
import '../../tips/data/tips_service.dart';

/// Экран настроек. Раздел «Уведомления» — Фаза 3.
/// (Тема, звуки, аккаунт/синхронизация — по мере реализации остальных фаз.)
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final supported = ref.read(notificationServiceProvider).isSupported;

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Советы и мотивация', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.auto_stories),
              title: const Text('Советы и цитаты'),
              subtitle: const Text(
                'Совет дня на главном экране и подсказки по тайм-менеджменту, '
                'дисциплине и мотивации.',
              ),
              value: ref.watch(tipsEnabledProvider).value ?? true,
              onChanged: (v) => ref.read(tipsEnabledProvider.notifier).set(v),
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
                      'о задачах и привычках в назначенное время.',
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
