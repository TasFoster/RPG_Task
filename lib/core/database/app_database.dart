import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../gamification/balance.dart';
import '../models/enums.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Локальная база данных приложения (SQLite через Drift).
/// UI работает только с ней; синхронизация с Supabase — отдельно (Фаза 2).
@DriftDatabase(
  tables: [
    SkillAxes,
    Tasks,
    Habits,
    HabitLogs,
    Profiles,
    CurrencyTransactions,
    Goals,
    GoalSteps,
    GoalSubSteps,
    DailyQuests,
    UserAchievements,
    InventoryItems,
    SleepLogs,
    CodexEntries,
    StatSnapshots,
    Seasons,
    Notes,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Конструктор для тестов (например, in-memory NativeDatabase).
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // v1 → v2 (Фаза 3): поля напоминаний.
          if (from < 2) {
            await m.addColumn(tasks, tasks.reminderAt);
            await m.addColumn(habits, habits.reminderMinutes);
          }
          // v2 → v3 (Фаза 6): цели/боссы, квесты, достижения, инвентарь.
          if (from < 3) {
            await m.createTable(goals);
            await m.createTable(goalSteps);
            await m.createTable(dailyQuests);
            await m.createTable(userAchievements);
            await m.createTable(inventoryItems);
          }
          // v3 → v4 (Этап B/E): сон и Кодекс героя.
          if (from < 4) {
            await m.createTable(sleepLogs);
            await m.createTable(codexEntries);
          }
          // v4 → v5 (Статистика + Сезоны): снимки показателей, архив сезонов,
          // сезонные поля профиля.
          if (from < 5) {
            await m.createTable(statSnapshots);
            await m.createTable(seasons);
            await m.addColumn(profiles, profiles.lifetimeXp);
            await m.addColumn(profiles, profiles.prestige);
            await m.addColumn(profiles, profiles.seasonYear);
            await m.addColumn(profiles, profiles.seasonMonth);
            // Существующим игрокам переносим накопленный опыт в lifetimeXp,
            // чтобы достижения и статистика «всё время» не обнулились.
            await customStatement(
                'UPDATE profiles SET lifetime_xp = total_xp');
          }
          // v5 → v6: заметки «Дневника».
          if (from < 6) {
            await m.createTable(notes);
          }
          // v6 → v7: архив задач и заметок.
          if (from < 7) {
            await m.addColumn(tasks, tasks.archivedAt);
            await m.addColumn(notes, notes.archivedAt);
          }
          // v7 → v8: подшаги шагов целей/боссов.
          if (from < 8) {
            await m.createTable(goalSubSteps);
          }
        },
        beforeOpen: (details) async {
          // Включаем внешние ключи (SQLite по умолчанию их не проверяет).
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'rpg_task_db',
    // Для web нужны файлы sqlite3 и drift-воркера (лежат в web/, копируются
    // в сборку). На нативных платформах параметр игнорируется.
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}
