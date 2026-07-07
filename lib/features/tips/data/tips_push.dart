import '../../../core/notifications/notification_service.dart';
import 'tip.dart';
import 'tips_service.dart';
import 'tips_settings.dart';

/// Планирует/снимает ежедневные пуш-советы согласно настройкам.
/// Утро — мотивация/дисциплина, вечер — саморазвитие/стойкость.
/// На web/неподдерживаемых платформах методы сервиса — тихий no-op.
Future<void> applyTipPushSchedule(
  NotificationService notifications,
  TipsService tips,
  TipsSettings settings, {
  DateTime? now,
}) async {
  final day = (now ?? DateTime.now()).day;

  if (settings.pushMorning) {
    final t = tips.contextual(TipCategory.motivation, salt: day) ??
        tips.contextual(TipCategory.discipline, salt: day);
    await notifications.scheduleDailyTip(
      slotKey: 'tip_morning',
      minuteOfDay: settings.morningMinute,
      title: 'Утренний девиз',
      body: t == null ? '' : _body(t),
      tipKey: t?.key,
    );
  } else {
    await notifications.cancelDailyTip('tip_morning');
  }

  if (settings.pushEvening) {
    final t = tips.contextual(TipCategory.selfGrowth, salt: day + 1) ??
        tips.contextual(TipCategory.resilience, salt: day + 1);
    await notifications.scheduleDailyTip(
      slotKey: 'tip_evening',
      minuteOfDay: settings.eveningMinute,
      title: 'Вечерняя рефлексия',
      body: t == null ? '' : _body(t),
      tipKey: t?.key,
    );
  } else {
    await notifications.cancelDailyTip('tip_evening');
  }
}

String _body(Tip t) => t.author == null ? t.text : '${t.text} — ${t.author}';
