import 'package:flutter/material.dart';

/// Временная заглушка экрана фичи (будет заменена реализацией в своей фазе).
class FeaturePlaceholder extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const FeaturePlaceholder({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 72, color: theme.colorScheme.primary),
              const SizedBox(height: 20),
              Text(
                title,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Chip(
                avatar: const Icon(Icons.construction, size: 18),
                label: const Text('В разработке'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
