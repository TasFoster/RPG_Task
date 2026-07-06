import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_placeholder.dart';

/// Экран задач (реализация — Фаза 1).
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePlaceholder(
      title: 'Задачи',
      icon: Icons.check_circle_outline,
      description:
          'Здесь появятся ваши задачи с наградами за выполнение (опыт, золото, кристаллы).',
    );
  }
}
