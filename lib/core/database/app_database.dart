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
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Конструктор для тестов (например, in-memory NativeDatabase).
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        beforeOpen: (details) async {
          // Включаем внешние ключи (SQLite по умолчанию их не проверяет).
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'rpg_task_db');
}
