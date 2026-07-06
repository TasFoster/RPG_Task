import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

/// Инициализация приложения до запуска UI.
/// Сюда позже добавятся: Drift (БД), Supabase, уведомления, timezone.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO(Фаза 1): инициализация локальной БД (Drift).
  // TODO(Фаза 2): инициализация Supabase.
  // TODO(Фаза 3): инициализация уведомлений и timezone.

  runApp(
    const ProviderScope(
      child: RpgTaskApp(),
    ),
  );
}
