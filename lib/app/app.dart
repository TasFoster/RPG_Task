import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Корневой виджет приложения.
class RpgTaskApp extends StatelessWidget {
  const RpgTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RPG Task',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark, // RPG-атмосфера: тёмная тема по умолчанию
      routerConfig: appRouter,
    );
  }
}
