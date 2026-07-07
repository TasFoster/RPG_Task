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
    DailyQuests,
    UserAchievements,
    InventoryItems,
    SleepLogs,
    CodexEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Конструктор для тестов (например, in-memory NativeDatabase).
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 4;

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
