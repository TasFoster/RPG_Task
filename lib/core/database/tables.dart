import 'package:drift/drift.dart';

import '../gamification/balance.dart';
import '../models/enums.dart';

// Общие столбцы синхронизации (для Фазы 2). Присутствуют во всех
// синхронизируемых таблицах: клиентский UUID, время изменения, тумбстоун, флаг «не синхронизировано».
mixin _SyncColumns on Table {
  TextColumn get id => text()();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get dirty => boolean().withDefault(const Constant(true))();
}

/// Оси «розы навыков».
class SkillAxes extends Table with _SyncColumns {
  TextColumn get name => text()();
  IntColumn get iconCodePoint => integer()();
  IntColumn get colorValue => integer()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  IntColumn get xp => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Задачи.
class Tasks extends Table with _SyncColumns {
  TextColumn get title => text()();
  TextColumn get notes => text().nullable()();
  TextColumn get axisId =>
      text().nullable().references(SkillAxes, #id)();
  IntColumn get difficulty => intEnum<Difficulty>()
      .withDefault(Constant(Difficulty.auto.index))();
  IntColumn get estimatedMinutes =>
      integer().withDefault(const Constant(25))();
  DateTimeColumn get dueAt => dateTime().nullable()();
  IntColumn get status =>
      intEnum<TaskStatus>().withDefault(Constant(TaskStatus.pending.index))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get xpAwarded => integer().withDefault(const Constant(0))();
  IntColumn get goldAwarded => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Привычки.
class Habits extends Table with _SyncColumns {
  TextColumn get title => text()();
  TextColumn get axisId =>
      text().nullable().references(SkillAxes, #id)();
  IntColumn get type =>
      intEnum<HabitType>().withDefault(Constant(HabitType.positive.index))();
  IntColumn get frequency => intEnum<Frequency>()
      .withDefault(Constant(Frequency.daily.index))();
  IntColumn get difficulty => intEnum<Difficulty>()
      .withDefault(Constant(Difficulty.auto.index))();
  IntColumn get streakCurrent => integer().withDefault(const Constant(0))();
  IntColumn get streakBest => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastCompletedAt => dateTime().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Журнал выполнения привычек (append-only событийный лог).
class HabitLogs extends Table with _SyncColumns {
  TextColumn get habitId => text().references(Habits, #id)();
  DateTimeColumn get completedAt =>
      dateTime().withDefault(currentDateAndTime)();
  IntColumn get value => integer().withDefault(const Constant(1))(); // +1 / -1
  IntColumn get xp => integer().withDefault(const Constant(0))();
  IntColumn get gold => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Профиль игрока (одна строка). Уровень вычисляется из totalXp.
class Profiles extends Table with _SyncColumns {
  TextColumn get displayName =>
      text().withDefault(const Constant('Искатель приключений'))();
  IntColumn get totalXp => integer().withDefault(const Constant(0))();
  IntColumn get gold => integer().withDefault(const Constant(0))();
  IntColumn get gems => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Журнал транзакций валют/опыта (append-only событийный лог).
class CurrencyTransactions extends Table with _SyncColumns {
  IntColumn get kind => intEnum<CurrencyKind>()();
  IntColumn get amount => integer()(); // может быть отрицательным
  IntColumn get reason => intEnum<RewardReason>()();
  TextColumn get refEntity => text().nullable()(); // id связанной сущности
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
