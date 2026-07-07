import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/seed.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../../core/gamification/ranks.dart';
import '../../../core/models/enums.dart';

const _uuid = Uuid();

/// Итоги закрытого сезона (для показа «свитка» и записи в архив).
class SeasonSummary {
  final int year;
  final int month;
  final int xpEarned;
  final int level;
  final String rank;
  final int gemsAwarded;
  final int tasksCompleted;
  final int habitsCompleted;
  final int bestStreak;
  final String? topAxisName;
  final int newPrestige;

  const SeasonSummary({
    required this.year,
    required this.month,
    required this.xpEarned,
    required this.level,
    required this.rank,
    required this.gemsAwarded,
    required this.tasksCompleted,
    required this.habitsCompleted,
    required this.bestStreak,
    required this.topAxisName,
    required this.newPrestige,
  });
}

/// Сезонная система: месячный пересчёт уровня.
///
/// В конце каждого месяца сезонный опыт (уровень героя) и опыт осей навыков
/// сбрасываются, копится «престиж», а итоги фиксируются в архиве («Зал славы»).
/// Золото, кристаллы, достижения, покупки и стрики сохраняются.
class SeasonService {
  final AppDatabase db;
  final GamificationEngine engine;
  SeasonService(this.db, [this.engine = const GamificationEngine()]);

  /// Проверяет смену месяца при запуске. Если наступил новый сезон —
  /// закрывает предыдущий и возвращает его итоги (для показа «свитка»).
  /// В первый запуск просто инициализирует текущий сезон и возвращает null.
  Future<SeasonSummary?> checkRollover() async {
    return db.transaction(() async {
      final now = DateTime.now();
      final profile = await (db.select(db.profiles)
            ..where((p) => p.id.equals(kProfileId)))
          .getSingleOrNull();
      if (profile == null) return null;

      // Первая инициализация сезона (после установки/миграции).
      if (profile.seasonYear == 0 || profile.seasonMonth == 0) {
        await _setCurrentSeason(now);
        return null;
      }

      // Тот же месяц — ничего не делаем.
      if (profile.seasonYear == now.year && profile.seasonMonth == now.month) {
        return null;
      }

      // Наступил новый сезон — закрываем предыдущий.
      final summary = await _closeSeason(
        profile,
        year: profile.seasonYear,
        month: profile.seasonMonth,
      );
      await _setCurrentSeason(now);
      return summary;
    });
  }

  Future<void> _setCurrentSeason(DateTime now) async {
    await (db.update(db.profiles)..where((p) => p.id.equals(kProfileId))).write(
      ProfilesCompanion(
        seasonYear: Value(now.year),
        seasonMonth: Value(now.month),
        dirty: const Value(true),
        updatedAt: Value(now),
      ),
    );
  }

  Future<SeasonSummary> _closeSeason(
    Profile profile, {
    required int year,
    required int month,
  }) async {
    final now = DateTime.now();
    final xpEarned = profile.totalXp;
    final level = engine.levelForXp(xpEarned);
    final tier = rankForXp(xpEarned);

    // Активность за закрываемый месяц.
    final monthStart = DateTime(year, month, 1);
    final monthEnd = DateTime(year, month + 1, 1);

    final tasksCompleted = (await (db.select(db.tasks)
              ..where((t) =>
                  t.status.equalsValue(TaskStatus.done) &
                  t.completedAt.isBiggerOrEqualValue(monthStart) &
                  t.completedAt.isSmallerThanValue(monthEnd)))
            .get())
        .length;

    final habitsCompleted = (await (db.select(db.habitLogs)
              ..where((l) =>
                  l.completedAt.isBiggerOrEqualValue(monthStart) &
                  l.completedAt.isSmallerThanValue(monthEnd)))
            .get())
        .length;

    final habits = await (db.select(db.habits)
          ..where((h) => h.isDeleted.equals(false)))
        .get();
    final bestStreak =
        habits.fold<int>(0, (m, h) => h.streakBest > m ? h.streakBest : m);

    // Топ-ось сезона — с наибольшим накопленным (сезонным) опытом.
    final axes = await (db.select(db.skillAxes)
          ..where((a) => a.isDeleted.equals(false)))
        .get();
    String? topAxisName;
    var topXp = -1;
    for (final a in axes) {
      if (a.xp > topXp) {
        topXp = a.xp;
        topAxisName = a.name;
      }
    }

    final newPrestige = profile.prestige + 1;

    // Запись в архив сезонов.
    await db.into(db.seasons).insert(
          SeasonsCompanion.insert(
            id: _uuid.v4(),
            year: year,
            month: month,
            xpEarned: Value(xpEarned),
            level: Value(level),
            rank: Value(tier.name),
            tasksCompleted: Value(tasksCompleted),
            habitsCompleted: Value(habitsCompleted),
            bestStreak: Value(bestStreak),
            topAxisName: Value(topAxisName),
            gemsAwarded: Value(tier.seasonGems),
          ),
        );

    // Сброс сезонного опыта и опыта осей; начисление бонуса и престижа.
    await (db.update(db.profiles)..where((p) => p.id.equals(kProfileId))).write(
      ProfilesCompanion(
        totalXp: const Value(0),
        gems: Value(profile.gems + tier.seasonGems),
        prestige: Value(newPrestige),
        dirty: const Value(true),
        updatedAt: Value(now),
      ),
    );
    await (db.update(db.skillAxes)).write(
      SkillAxesCompanion(
        xp: const Value(0),
        dirty: const Value(true),
        updatedAt: Value(now),
      ),
    );

    // Бонусные кристаллы — в журнал транзакций.
    if (tier.seasonGems > 0) {
      await db.into(db.currencyTransactions).insert(
            CurrencyTransactionsCompanion.insert(
              id: _uuid.v4(),
              kind: CurrencyKind.gems,
              amount: tier.seasonGems,
              reason: RewardReason.manual,
              refEntity: Value('season_$year-$month'),
            ),
          );
    }

    return SeasonSummary(
      year: year,
      month: month,
      xpEarned: xpEarned,
      level: level,
      rank: tier.name,
      gemsAwarded: tier.seasonGems,
      tasksCompleted: tasksCompleted,
      habitsCompleted: habitsCompleted,
      bestStreak: bestStreak,
      topAxisName: topAxisName,
      newPrestige: newPrestige,
    );
  }

  Stream<List<Season>> watchSeasons() {
    return (db.select(db.seasons)
          ..orderBy([
            (s) => OrderingTerm(expression: s.year, mode: OrderingMode.desc),
            (s) => OrderingTerm(expression: s.month, mode: OrderingMode.desc),
          ]))
        .watch();
  }
}

final seasonServiceProvider = Provider<SeasonService>((ref) {
  return SeasonService(ref.watch(databaseProvider));
});

final seasonsStreamProvider = StreamProvider<List<Season>>((ref) {
  return ref.watch(seasonServiceProvider).watchSeasons();
});

/// Итоги только что закрытого сезона (для показа «свитка» после запуска).
/// Переопределяется в bootstrap, если при старте случился месячный пересчёт.
final pendingSeasonSummaryProvider = Provider<SeasonSummary?>((ref) => null);
