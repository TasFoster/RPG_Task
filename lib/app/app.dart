import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/database/database_provider.dart';
import '../core/sync/sync_service.dart';
import '../features/auth/data/auth_service.dart';
import '../features/widgets/home_widgets_service.dart';
import '../l10n/app_localizations.dart';
import 'theme/app_theme.dart';

/// Корневой виджет приложения.
///
/// Помимо навигации отвечает за:
///  • актуальность виджетов главного экрана (обновление по возврату из фона и
///    периодически);
///  • облачную синхронизацию (при входе, возврате из фона и периодически).
/// На web/iOS обновление виджетов — no-op; синхронизация — no-op без конфига.
class RpgTaskApp extends ConsumerStatefulWidget {
  final GoRouter router;

  const RpgTaskApp({super.key, required this.router});

  @override
  ConsumerState<RpgTaskApp> createState() => _RpgTaskAppState();
}

class _RpgTaskAppState extends ConsumerState<RpgTaskApp> {
  /// Как часто обновлять виджеты, пока приложение на переднем плане.
  static const _widgetRefreshInterval = Duration(minutes: 15);

  /// Как часто синхронизироваться с облаком на переднем плане.
  static const _syncInterval = Duration(minutes: 5);

  AppLifecycleListener? _lifecycle;
  Timer? _widgetTimer;
  Timer? _syncTimer;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onResume: () {
      _refreshWidgets();
      _sync();
    });
    _widgetTimer =
        Timer.periodic(_widgetRefreshInterval, (_) => _refreshWidgets());
    _syncTimer = Timer.periodic(_syncInterval, (_) => _sync());
  }

  void _refreshWidgets() {
    updateHomeWidgets(ref.read(databaseProvider));
  }

  void _sync() {
    if (ref.read(authServiceProvider).isSignedIn) {
      ref.read(syncControllerProvider.notifier).syncNow();
    }
  }

  @override
  void dispose() {
    _widgetTimer?.cancel();
    _syncTimer?.cancel();
    _lifecycle?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Синхронизация при входе в аккаунт (в т.ч. первичная при запуске, если
    // пользователь уже вошёл — startWith отдаёт текущего пользователя).
    ref.listen<AsyncValue>(authUserProvider, (prev, next) {
      if (next.value != null) {
        ref.read(syncControllerProvider.notifier).syncNow();
      }
    });

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
