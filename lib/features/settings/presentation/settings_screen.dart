import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_placeholder.dart';

/// Экран настроек (тема, звуки, уведомления, аккаунт — по мере реализации фаз).
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePlaceholder(
      title: 'Настройки',
      icon: Icons.settings_outlined,
      description:
          'Тема оформления, звуки, расписание напоминаний, аккаунт и синхронизация.',
    );
  }
}
