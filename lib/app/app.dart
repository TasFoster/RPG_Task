import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/database/database_provider.dart';
import '../core/notifications/notification_service.dart';
import '../core/sync/sync_service.dart';
import '../features/auth/data/auth_service.dart';
import '../features/codex/data/codex_repository.dart';
import '../features/tips/data/tips_catalog.dart';
import '../features/tips/presentation/reflection_dialog.dart';
import '../features/widgets/home_widgets_service.dart';
import '../l10n/app_localizations.dart';
import 'router/app_router.dart';
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
  StreamSubscription<String>? _tapSub;

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

    // Тапы по пуш-советам (утро/вечер): показать рефлексию и сохранить в историю.
    final notifications = ref.read(notificationServiceProvider);
    _tapSub = notifications.onNotificationTap.listen(_handleNotificationPayload);
    // Холодный старт по тапу — обработать после первого кадра (навигатор готов).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final launch = notifications.takeLaunchPayload();
      if (launch != null) _handleNotificationPayload(launch);
    });
  }

  /// Обрабатывает payload нажатого уведомления. Формат для советов:
  /// `tip:<slot>:<ключ_совета>` (slot — tip_morning/tip_evening).
  Future<void> _handleNotificationPayload(String payload) async {
    final parts = payload.split(':');
    if (parts.length < 3 || parts.first != 'tip') return;
    final slotKey = parts[1];
    final tipKey = parts.sublist(2).join(':');
    if (tipKey.isEmpty) return;

    final tip = tipsCatalog.firstWhereOrNull((t) => t.key == tipKey);
    if (tip == null) return;

    // Сохраняем совет в историю (Кодекс героя), затем показываем модалку.
    await ref.read(codexRepositoryProvider).recordTip(tip.key);
    if (!mounted) return;
    final ctx = rootNavigatorKey.currentContext;
    if (ctx != null && ctx.mounted) {
      await showReflectionDialog(ctx, slotKey: slotKey, tip: tip);
    }
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
    _tapSub?.cancel();
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
