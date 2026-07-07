import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

import '../../core/database/app_database.dart';
import '../../core/models/enums.dart';

/// Виджеты главного экрана поддерживаются только на Android.
bool get _supported =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

/// Собирает «снимок» данных (задачи, привычки, боссы) и обновляет виджеты
/// главного экрана. На web/iOS — тихий no-op.
///
/// Данные сохраняются в SharedPreferences плагином home_widget, откуда их
/// читают Android-провайдеры (см. WidgetRender.kt). Обновление вызывается:
/// при старте (bootstrap), при возврате приложения из фона и по таймеру
/// (см. app.dart), а также после изменений (выполнение задач/привычек).
Future<void> updateHomeWidgets(AppDatabase db) async {
  if (!_supported) return;
  try {
    // Сохраняем данные (это и есть источник для провайдеров).
    await HomeWidget.saveWidgetData<String>('w_tasks', await _tasksText(db));
    await HomeWidget.saveWidgetData<String>('w_habits', await _habitsText(db));
    await HomeWidget.saveWidgetData<String>('w_boss', await _bossText(db));

    // Просим систему перерисовать каждый виджет. Если провайдер не найден
    // (виджет не добавлен на экран) — это не критично, данные уже сохранены.
    for (final name in const [
      'TasksWidgetProvider',
      'HabitsWidgetProvider',
      'BossWidgetProvider',
    ]) {
      try {
        await HomeWidget.updateWidget(
          name: name,
          androidName: name,
          qualifiedAndroidName: 'com.tasfoster.rpg_task.$name',
        );
      } catch (e) {
        if (kDebugMode) debugPrint('updateWidget($name) failed: $e');
      }
    }
  } catch (e, st) {
    // Ошибку не проглатываем молча — в debug видно, что пошло не так.
    if (kDebugMode) debugPrint('updateHomeWidgets failed: $e\n$st');
  }
}

Future<String> _tasksText(AppDatabase db) async {
  final rows = await (db.select(db.tasks)
        ..where((t) =>
            t.status.equalsValue(TaskStatus.pending) & t.isDeleted.equals(false))
        ..orderBy([
          (t) => OrderingTerm(expression: t.dueAt),
          (t) => OrderingTerm(expression: t.createdAt),
        ])
        ..limit(5))
      .get();
  if (rows.isEmpty) return 'Нет задач — время для подвига!';
  return rows.map((t) => '• ${t.title}').join('\n');
}

Future<String> _habitsText(AppDatabase db) async {
  final habits = await (db.select(db.habits)
        ..where((h) => h.isDeleted.equals(false)))
      .get();
  final now = DateTime.now();
  bool sameDay(DateTime? d) =>
      d != null && d.year == now.year && d.month == now.month && d.day == now.day;
  final doneToday = habits.where((h) => sameDay(h.lastCompletedAt)).length;

  // Мини-хитмап за 14 дней: ▪ — был выполнен хоть один лог, ▫ — нет.
  final since = DateTime(now.year, now.month, now.day)
      .subtract(const Duration(days: 13));
  final logs = await (db.select(db.habitLogs)
        ..where((l) => l.completedAt.isBiggerOrEqualValue(since)))
      .get();
  final daysWithLogs = <String>{
    for (final l in logs)
      '${l.completedAt.year}-${l.completedAt.month}-${l.completedAt.day}',
  };
  final grid = StringBuffer();
  for (var i = 13; i >= 0; i--) {
    final d = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: i));
    grid.write(daysWithLogs.contains('${d.year}-${d.month}-${d.day}')
        ? '▪'
        : '▫');
  }
  if (habits.isEmpty) return 'Добавьте первую привычку';
  return 'Сегодня: $doneToday из ${habits.length}\n$grid';
}

Future<String> _bossText(AppDatabase db) async {
  final bosses = await (db.select(db.goals)
        ..where((g) =>
            g.isBoss.equals(true) &
            g.status.equalsValue(GoalStatus.active) &
            g.isDeleted.equals(false))
        ..orderBy([(g) => OrderingTerm(expression: g.createdAt)])
        ..limit(3))
      .get();
  if (bosses.isEmpty) return 'Нет активных боссов';
  return bosses.map((g) {
    final total = g.hpTotal <= 0 ? 1 : g.hpTotal;
    final done = (total - g.hpRemaining).clamp(0, total);
    final pct = (done / total * 100).round();
    final filled = (done / total * 5).round().clamp(0, 5);
    final bar = '▰' * filled + '▱' * (5 - filled);
    return '${g.title}  $bar $pct%';
  }).join('\n');
}
