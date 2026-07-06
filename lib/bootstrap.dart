import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart';
import 'app/router/app_router.dart';
import 'core/database/app_database.dart';
import 'core/database/database_provider.dart';
import 'core/database/seed.dart';
import 'core/notifications/notification_service.dart';
import 'features/onboarding/data/onboarding_service.dart';

/// Инициализация приложения до запуска UI.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Данные локали для форматирования дат/времени (русский).
  await initializeDateFormatting('ru');

  // Локальная БД (Drift) + начальные данные (профиль, стандартные оси).
  final db = AppDatabase();
  await seedDatabase(db);

  // Уведомления (Фаза 3). На web/неподдерживаемых платформах — no-op.
  final notifications = NotificationService();
  await notifications.init();

  // TODO(Фаза 2): инициализация Supabase.

  // Первый запуск → онбординг.
  final seenOnboarding = await OnboardingService.hasSeen();
  final router = buildAppRouter(
    initialLocation: seenOnboarding ? '/tasks' : '/onboarding',
  );

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        notificationServiceProvider.overrideWithValue(notifications),
      ],
      child: RpgTaskApp(router: router),
    ),
  );
}
