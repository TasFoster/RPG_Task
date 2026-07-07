import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'notification_scheduler.dart';

/// Идентификаторы каналов уведомлений (Android).
class NotificationChannels {
  static const reminders = 'reminders';
  static const alarms = 'alarms';
}

/// Сервис локальных уведомлений.
///
/// Работает на Android/iOS/macOS. На web и прочих платформах все методы —
/// безопасные no-op (проверяется [_supported]), чтобы приложение оставалось
/// полностью функциональным офлайн-ядром без нативной части (см. Фаза 3 плана).
class NotificationService {
  NotificationService({
    FlutterLocalNotificationsPlugin? plugin,
    bool? forceEnabled,
  })  : _plugin = plugin ?? FlutterLocalNotificationsPlugin(),
        // Публичное имя параметра при приватном поле — initializing formal не подходит.
        // ignore: prefer_initializing_formals
        _forceEnabled = forceEnabled;

  final FlutterLocalNotificationsPlugin _plugin;

  /// Явное включение/выключение (для тестов). null — определять по платформе.
  final bool? _forceEnabled;
  bool _ready = false;

  /// Платформы, где нативные уведомления доступны.
  bool get _supported =>
      _forceEnabled ??
      (!kIsWeb &&
          (defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS));

  bool get isSupported => _supported;

  /// Инициализация: часовые пояса, каналы, обработчик тапа. Идемпотентна.
  Future<void> init() async {
    if (!_supported || _ready) return;

    tzdata.initializeTimeZones();
    try {
      final localName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(localName));
    } catch (_) {
      // Не смогли определить пояс устройства — остаёмся на UTC (по умолчанию).
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: darwinInit, macOS: darwinInit),
    );

    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      await android.createNotificationChannel(
        const AndroidNotificationChannel(
          NotificationChannels.reminders,
          'Напоминания',
          description: 'Напоминания о задачах и привычках',
          importance: Importance.high,
        ),
      );
      await android.createNotificationChannel(
        const AndroidNotificationChannel(
          NotificationChannels.alarms,
          'Будильники',
          description: 'Полноэкранные напоминания в назначенное время',
          importance: Importance.max,
          playSound: true,
        ),
      );
    }

    _ready = true;
  }

  /// Запрос разрешений (Android 13+ POST_NOTIFICATIONS, iOS alert/sound,
  /// а также точные будильники). Возвращает true, если основное разрешение выдано.
  Future<bool> requestPermissions() async {
    if (!_supported) return false;
    await init();

    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      final granted = await android.requestNotificationsPermission() ?? false;
      // Точные будильники (Android 12+) — отдельное разрешение.
      await android.requestExactAlarmsPermission();
      return granted;
    }

    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      return await ios.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    }
    return true;
  }

  /// Разовое напоминание о задаче на точный момент [when].
  /// Прошедшее время игнорируется. Повторный вызов с тем же [entityId]
  /// перезаписывает уведомление (id детерминирован).
  Future<void> scheduleTaskReminder({
    required String entityId,
    required String title,
    required DateTime when,
  }) async {
    if (!_supported) return;
    await init();
    if (!when.isAfter(DateTime.now())) return;

    await _plugin.zonedSchedule(
      notificationIdFor(entityId),
      'Задача: $title',
      'Пора выполнить задачу',
      tz.TZDateTime.from(when, tz.local),
      _details(NotificationChannels.reminders),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'task:$entityId',
    );
  }

  /// Ежедневное напоминание о привычке на минуту суток [minuteOfDay] (0..1439).
  Future<void> scheduleDailyHabitReminder({
    required String entityId,
    required String title,
    required int minuteOfDay,
  }) async {
    if (!_supported) return;
    await init();

    final first = nextDailyOccurrence(minuteOfDay: minuteOfDay, now: DateTime.now());
    await _plugin.zonedSchedule(
      notificationIdFor(entityId),
      'Привычка: $title',
      'Время отметить привычку',
      tz.TZDateTime.from(first, tz.local),
      _details(NotificationChannels.reminders),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // Повтор каждый день в то же время.
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'habit:$entityId',
    );
  }

  /// Ежедневный совет/цитата на минуту суток [minuteOfDay] (утро/вечер).
  /// [slotKey] — стабильный ключ слота ('tip_morning'/'tip_evening'), чтобы
  /// перепланирование перезаписывало прежнее уведомление, а не плодило дубли.
  Future<void> scheduleDailyTip({
    required String slotKey,
    required int minuteOfDay,
    required String title,
    required String body,
  }) async {
    if (!_supported) return;
    await init();
    final first = nextDailyOccurrence(minuteOfDay: minuteOfDay, now: DateTime.now());
    await _plugin.zonedSchedule(
      notificationIdFor(slotKey),
      title,
      body,
      tz.TZDateTime.from(first, tz.local),
      _details(NotificationChannels.reminders),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'tip:$slotKey',
    );
  }

  /// Отмена слота ежедневного совета ('tip_morning'/'tip_evening').
  Future<void> cancelDailyTip(String slotKey) async {
    if (!_supported) return;
    await init();
    await _plugin.cancel(notificationIdFor(slotKey));
  }

  /// Отмена запланированного уведомления сущности.
  Future<void> cancel(String entityId) async {
    if (!_supported) return;
    await init();
    await _plugin.cancel(notificationIdFor(entityId));
  }

  NotificationDetails _details(String channelId) {
    final fullScreen = channelId == NotificationChannels.alarms;
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelId == NotificationChannels.alarms ? 'Будильники' : 'Напоминания',
        importance: fullScreen ? Importance.max : Importance.high,
        priority: fullScreen ? Priority.max : Priority.high,
        fullScreenIntent: fullScreen,
        category: fullScreen ? AndroidNotificationCategory.alarm : null,
      ),
      iOS: const DarwinNotificationDetails(),
      macOS: const DarwinNotificationDetails(),
    );
  }
}

/// Единственный экземпляр сервиса уведомлений на всё приложение.
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});
