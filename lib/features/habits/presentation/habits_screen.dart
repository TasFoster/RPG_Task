import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_placeholder.dart';

/// Экран привычек (реализация — Фаза 1).
class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePlaceholder(
      title: 'Привычки',
      icon: Icons.local_fire_department_outlined,
      description:
          'Ежедневные и еженедельные привычки со стриками и бонусами за регулярность.',
    );
  }
}
