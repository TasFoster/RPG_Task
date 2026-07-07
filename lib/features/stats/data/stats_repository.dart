import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/seed.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../../core/models/enums.dart';

/// Диапазон статистики.
enum StatsRange { week, month, all }

extension StatsRangeLabel on StatsRange {
  String get label => switch (this) {
        StatsRange.week => 'Неделя',
        StatsRange.month => 'Месяц',
        StatsRange.all => 'Всё время',
      };
}

/// Текущее состояние по оси навыка для статистики.
class AxisStat {
  final String name;
  final int colorValue;
  final int iconCodePoint;
  final int xp;
  final int level;
  const AxisStat({
    required this.name,
    required this.colorValue,
    required this.iconCodePoint,
    required this.xp,
    required this.level,
  });
}

/// Агрегированные данные статистики за выбранный диапазон.
class StatsData {
  final StatsRange range;
  final DateTime start;
  final DateTime end;

  /// Ряды «за день» (ключ — дата без времени).
  final Map<DateTime, int> xpByDay;
  final Map<DateTime, int> tasksByDay;
  final Map<DateTime, int> habitsByDay;
  final Map<DateTime, int> focusByDay;

  final int xpTotal;
  final int goldTotal;
  final int gemsTotal;
  final int tasksTotal;
  final int habitsTotal;
  final int focusTotal;

  final List<AxisStat> axes;
  final int bestStreak;
  final int seasonLevel;
  final int prestige;
  final int lifetimeXp;

  const StatsData({
    required this.range,
    required this.start,
    required this.end,
    required this.xpByDay,
    required this.tasksByDay,
    required this.habitsByDay,
    required this.focusByDay,
    required this.xpTotal,
    required this.goldTotal,
    required this.gemsTotal,
    required this.tasksTotal,
    required this.habitsTotal,
    required this.focusTotal,
    required this.axes,
    required this.bestStreak,
    required this.seasonLevel,
    required this.prestige,
    required this.lifetimeXp,
  });

  /// Все даты диапазона по возрастанию (для непрерывной оси графика).
  List<DateTime> get days {
    final res = <DateTime>[];
    for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
      res.add(d);
    }
    return res;
  }
}

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Доступ к агрегированной статистике и запись ежедневных снимков.
class StatsRepository {
  final AppDatabase db;
  final GamificationEngine engine;
  StatsRepository(this.db, [this.engine = const GamificationEngine()]);

  Future<StatsData> load(StatsRange range) async {
    final now = DateTime.now();
    final today = _dateOnly(now);
    DateTime start;
    switch (range) {
      case StatsRange.week:
        start = today.subtract(const Duration(days: 6));
      case StatsRange.month:
        start = today.subtract(const Duration(days: 29));
      case StatsRange.all:
        start = await _earliestDate() ?? today.subtract(const Duration(days: 29));
    }

    // Транзакции валют за диапазон.
    final txs = await (db.select(db.currencyTransactions)
          ..where((c) => c.createdAt.isBiggerOrEqualValue(start)))
        .get();

    final xpByDay = <DateTime, int>{};
    var xpTotal = 0, goldTotal = 0, gemsTotal = 0;
    final focusByDay = <DateTime, int>{};
    var focusTotal = 0;
    for (final t in txs) {
      final day = _dateOnly(t.createdAt);
      switch (t.kind) {
        case CurrencyKind.xp:
          xpByDay[day] = (xpByDay[day] ?? 0) + t.amount;
          xpTotal += t.amount;
          if (t.reason == RewardReason.focusSession) {
            focusByDay[day] = (focusByDay[day] ?? 0) + 1;
            focusTotal += 1;
          }
        case CurrencyKind.gold:
          if (t.amount > 0) goldTotal += t.amount;
        case CurrencyKind.gems:
          if (t.amount > 0) gemsTotal += t.amount;
      }
    }

    // Выполненные задачи за диапазон.
    final tasks = await (db.select(db.tasks)
          ..where((t) =>
              t.status.equalsValue(TaskStatus.done) &
              t.completedAt.isBiggerOrEqualValue(start)))
        .get();
    final tasksByDay = <DateTime, int>{};
    for (final t in tasks) {
      if (t.completedAt == null) continue;
      final day = _dateOnly(t.completedAt!);
      tasksByDay[day] = (tasksByDay[day] ?? 0) + 1;
    }

    // Выполнения привычек за диапазон.
    final logs = await (db.select(db.habitLogs)
          ..where((l) => l.completedAt.isBiggerOrEqualValue(start)))
        .get();
    final habitsByDay = <DateTime, int>{};
    for (final l in logs) {
      final day = _dateOnly(l.completedAt);
      habitsByDay[day] = (habitsByDay[day] ?? 0) + 1;
    }

    // Текущее состояние осей и профиля.
    final axes = await (db.select(db.skillAxes)
          ..where((a) => a.isDeleted.equals(false))
          ..orderBy([(a) => OrderingTerm(expression: a.sortOrder)]))
        .get();
    final axisStats = [
      for (final a in axes)
        AxisStat(
          name: a.name,
          colorValue: a.colorValue,
          iconCodePoint: a.iconCodePoint,
          xp: a.xp,
          level: engine.levelForXp(a.xp),
        ),
    ];

    final habits = await (db.select(db.habits)
          ..where((h) => h.isDeleted.equals(false)))
        .get();
    final bestStreak =
        habits.fold<int>(0, (m, h) => h.streakBest > m ? h.streakBest : m);

    final profile = await (db.select(db.profiles)
          ..where((p) => p.id.equals(kProfileId)))
        .getSingleOrNull();
    final seasonLevel = engine.levelForXp(profile?.totalXp ?? 0);

    return StatsData(
      range: range,
      start: start,
      end: today,
      xpByDay: xpByDay,
      tasksByDay: tasksByDay,
      habitsByDay: habitsByDay,
      focusByDay: focusByDay,
      xpTotal: xpTotal,
      goldTotal: goldTotal,
      gemsTotal: gemsTotal,
      tasksTotal: tasks.length,
      habitsTotal: logs.length,
      focusTotal: focusTotal,
      axes: axisStats,
      bestStreak: bestStreak,
      seasonLevel: seasonLevel,
      prestige: profile?.prestige ?? 0,
      lifetimeXp: profile?.lifetimeXp ?? 0,
    );
  }

  Future<DateTime?> _earliestDate() async {
    final rows = await (db.select(db.currencyTransactions)
          ..orderBy([(c) => OrderingTerm(expression: c.createdAt)])
          ..limit(1))
        .get();
    if (rows.isEmpty) return null;
    return _dateOnly(rows.first.createdAt);
  }

  /// Записывает (или обновляет) снимок показателей за сегодня.
  Future<void> recordDailySnapshot() async {
    final now = DateTime.now();
    final dateKey =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final profile = await (db.select(db.profiles)
          ..where((p) => p.id.equals(kProfileId)))
        .getSingleOrNull();
    if (profile == null) return;

    final tasksDone = (await (db.select(db.tasks)
              ..where((t) =>
                  t.status.equalsValue(TaskStatus.done) &
                  t.isDeleted.equals(false)))
            .get())
        .length;
    final habitsLogged = (await db.select(db.habitLogs).get()).length;
    final focusSessions = (await (db.select(db.currencyTransactions)
              ..where((c) =>
                  c.reason.equalsValue(RewardReason.focusSession) &
                  c.kind.equalsValue(CurrencyKind.xp)))
            .get())
        .length;

    // id стабилен и выводится из даты (а не случайный uuid): на разных
    // устройствах снимок за один день получает одинаковый id, поэтому при
    // синхронизации строки СЛИВАЮТСЯ, а не плодят дубликаты. Раньше из-за
    // случайного id за один день могло накопиться несколько строк, и запрос
    // getSingleOrNull ниже падал с «Bad state: Too many elements» ещё на
    // старте приложения (bootstrap → recordDailySnapshot).
    final stableId = 'snap_$dateKey';
    final companion = StatSnapshotsCompanion.insert(
      id: stableId,
      dateKey: dateKey,
      totalXp: Value(profile.totalXp),
      lifetimeXp: Value(profile.lifetimeXp),
      level: Value(engine.levelForXp(profile.totalXp)),
      gold: Value(profile.gold),
      gems: Value(profile.gems),
      tasksDone: Value(tasksDone),
      habitsLogged: Value(habitsLogged),
      focusSessions: Value(focusSessions),
      updatedAt: Value(now),
      dirty: const Value(true),
    );

    // Самоизлечение: схлопываем старые дубликаты за сегодня со случайными id
    // (натёкшие с других устройств при синхронизации). Помечаем их удалёнными
    // с dirty, чтобы «надгробие» разъехалось по устройствам.
    final dupes = await (db.select(db.statSnapshots)
          ..where((s) =>
              s.dateKey.equals(dateKey) &
              s.isDeleted.equals(false) &
              s.id.equals(stableId).not()))
        .get();
    for (final dup in dupes) {
      await (db.update(db.statSnapshots)..where((s) => s.id.equals(dup.id)))
          .write(StatSnapshotsCompanion(
        isDeleted: const Value(true),
        dirty: const Value(true),
        updatedAt: Value(now),
      ));
    }

    // Канонический снимок за сегодня: создаём или обновляем по стабильному id.
    await db.into(db.statSnapshots).insertOnConflictUpdate(companion);
  }
}

final statsRepositoryProvider = Provider<StatsRepository>((ref) {
  return StatsRepository(ref.watch(databaseProvider));
});

final statsProvider =
    FutureProvider.family<StatsData, StatsRange>((ref, range) async {
  return ref.watch(statsRepositoryProvider).load(range);
});
