import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart';
import 'app/router/app_router.dart';
import 'core/database/app_database.dart';
import 'core/database/database_provider.dart';
import 'core/database/seed.dart';
import 'core/notifications/notification_service.dart';
import 'features/onboarding/data/onboarding_service.dart';
import 'features/tips/data/tips_push.dart';
import 'features/tips/data/tips_service.dart';
import 'features/tips/data/tips_settings.dart';
import 'features/seasons/data/season_service.dart';
import 'features/stats/data/stats_repository.dart';
import 'features/widgets/home_widgets_service.dart';

/// Инициализация приложения до запуска UI.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Данные локали для форматирования дат/времени (русский).
    await initializeDateFormatting('ru');

    // Локальная БД (Drift) + начальные данные (профиль, стандартные оси).
    final db = AppDatabase();
    await seedDatabase(db);

    // Уведомления (Фаза 3). На web/неподдерживаемых платформах — no-op.
    final notifications = NotificationService();
    await notifications.init();

    // Перепланировать пуш-советы согласно сохранённым настройкам (утро/вечер).
    final tipsSettings = await TipsSettings.load();
    await applyTipPushSchedule(notifications, const TipsService(), tipsSettings);

    // Сезонная система: если начался новый месяц — закрыть предыдущий сезон
    // (сброс уровня, фиксация итогов). Итоги покажем «свитком» после запуска.
    final seasonSummary = await SeasonService(db).checkRollover();

    // Ежедневный снимок показателей для графиков динамики (после сброса сезона).
    await StatsRepository(db).recordDailySnapshot();

    // Обновить виджеты главного экрана (Android; на web — no-op).
    await updateHomeWidgets(db);

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
          pendingSeasonSummaryProvider.overrideWithValue(seasonSummary),
        ],
        child: RpgTaskApp(router: router),
      ),
    );
  } catch (e, st) {
    // Инициализация упала — показываем ошибку вместо вечного сплэша.
    debugPrint('BOOTSTRAP ERROR: $e\n$st');
    runApp(_BootstrapErrorApp(error: e, stack: st));
  }
}

/// Аварийный экран, если [bootstrap] не смог инициализировать приложение.
class _BootstrapErrorApp extends StatelessWidget {
  const _BootstrapErrorApp({required this.error, required this.stack});

  final Object error;
  final StackTrace stack;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF1a1024),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ошибка запуска',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SelectableText(
                    '$error',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(height: 16),
                  SelectableText(
                    '$stack',
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
