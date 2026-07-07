import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/database/database_provider.dart';
import '../features/widgets/home_widgets_service.dart';
import '../l10n/app_localizations.dart';
import 'theme/app_theme.dart';

/// Корневой виджет приложения.
///
/// Помимо навигации отвечает за поддержание актуальности виджетов главного
/// экрана: обновляет их при возврате приложения из фона (по событию) и
/// периодически, пока приложение открыто (по расписанию). На web/iOS
/// [updateHomeWidgets] — no-op, так что накладных расходов нет.
class RpgTaskApp extends ConsumerStatefulWidget {
  final GoRouter router;

  const RpgTaskApp({super.key, required this.router});

  @override
  ConsumerState<RpgTaskApp> createState() => _RpgTaskAppState();
}

class _RpgTaskAppState extends ConsumerState<RpgTaskApp> {
  /// Как часто обновлять виджеты, пока приложение на переднем плане.
  static const _refreshInterval = Duration(minutes: 15);

  AppLifecycleListener? _lifecycle;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Обновление по событию: приложение вернулось на передний план.
    _lifecycle = AppLifecycleListener(onResume: _refreshWidgets);
    // Обновление по расписанию, пока приложение открыто.
    _timer = Timer.periodic(_refreshInterval, (_) => _refreshWidgets());
  }

  void _refreshWidgets() {
    updateHomeWidgets(ref.read(databaseProvider));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _lifecycle?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark, // RPG-атмосфера: тёмная тема по умолчанию
      routerConfig: widget.router,
    );
  }
}
