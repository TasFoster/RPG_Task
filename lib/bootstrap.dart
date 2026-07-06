import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/database/app_database.dart';
import 'core/database/database_provider.dart';
import 'core/database/seed.dart';

/// Инициализация приложения до запуска UI.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Локальная БД (Drift) + начальные данные (профиль, стандартные оси).
  final db = AppDatabase();
  await seedDatabase(db);

  // TODO(Фаза 2): инициализация Supabase.
  // TODO(Фаза 3): инициализация уведомлений и timezone.

  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const RpgTaskApp(),
    ),
  );
}
