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
  // Фаза 3: разовое напоминание (точное время). null — без напоминания.
  DateTimeColumn get reminderAt => dateTime().nullable()();
  IntColumn get status =>
      intEnum<TaskStatus>().withDefault(Constant(TaskStatus.pending.index))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get xpAwarded => integer().withDefault(const Constant(0))();
  IntColumn get goldAwarded => integer().withDefault(const Constant(0))();
  // Архив: null — активная задача, иначе — момент архивирования.
  // Nullable-колонка безопасна для синхронизации со старыми клиентами.
  DateTimeColumn get archivedAt => dateTime().nullable()();
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
  // Фаза 3: ежедневное напоминание — минута суток [0..1439]. null — без напоминания.
  IntColumn get reminderMinutes => integer().nullable()();
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

/// Профиль игрока (одна строка).
///
/// Сезонная система: [totalXp] — опыт ТЕКУЩЕГО сезона (месяца), уровень героя
/// считается из него и обнуляется при смене сезона. [lifetimeXp] — совокупный
/// опыт за всё время (не сбрасывается; используется для достижений и статистики
/// «всё время»). [prestige] — число завершённых сезонов. [seasonYear]/
/// [seasonMonth] — сезон, которому принадлежит текущий [totalXp] (0 — ещё не
/// инициализировано; выставляется при первом запуске).
class Profiles extends Table with _SyncColumns {
  TextColumn get displayName =>
      text().withDefault(const Constant('Искатель приключений'))();
  IntColumn get totalXp => integer().withDefault(const Constant(0))();
  IntColumn get lifetimeXp => integer().withDefault(const Constant(0))();
  IntColumn get prestige => integer().withDefault(const Constant(0))();
  IntColumn get seasonYear => integer().withDefault(const Constant(0))();
  IntColumn get seasonMonth => integer().withDefault(const Constant(0))();
  IntColumn get gold => integer().withDefault(const Constant(0))();
  IntColumn get gems => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Ежедневный снимок показателей игрока (для графиков динамики).
/// Пишется раз в сутки; при повторе за тот же день перезаписывается.
class StatSnapshots extends Table with _SyncColumns {
  TextColumn get dateKey => text()(); // 'YYYY-MM-DD' (локальная дата)
  IntColumn get totalXp => integer().withDefault(const Constant(0))();
  IntColumn get lifetimeXp => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get gold => integer().withDefault(const Constant(0))();
  IntColumn get gems => integer().withDefault(const Constant(0))();
  IntColumn get tasksDone => integer().withDefault(const Constant(0))(); // накопительно
  IntColumn get habitsLogged =>
      integer().withDefault(const Constant(0))(); // накопительно
  IntColumn get focusSessions =>
      integer().withDefault(const Constant(0))(); // накопительно
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Заметки «Дневника героя». Тело — Markdown. Можно привязать к оси навыка,
/// отметить настроение (эмодзи) и закрепить.
class Notes extends Table with _SyncColumns {
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get body => text().withDefault(const Constant(''))();
  TextColumn get axisId => text().nullable().references(SkillAxes, #id)();
  TextColumn get mood => text().nullable()(); // эмодзи настроения
  BoolColumn get pinned => boolean().withDefault(const Constant(false))();
  // Архив: null — активная заметка, иначе — момент архивирования.
  DateTimeColumn get archivedAt => dateTime().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Архив завершённых сезонов («Зал славы»). Одна запись на закрытый месяц.
class Seasons extends Table with _SyncColumns {
  IntColumn get year => integer()();
  IntColumn get month => integer()();
  IntColumn get xpEarned => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();
  TextColumn get rank => text().withDefault(const Constant(''))();
  IntColumn get tasksCompleted => integer().withDefault(const Constant(0))();
  IntColumn get habitsCompleted => integer().withDefault(const Constant(0))();
  IntColumn get bestStreak => integer().withDefault(const Constant(0))();
  TextColumn get topAxisName => text().nullable()();
  IntColumn get gemsAwarded => integer().withDefault(const Constant(0))();
  DateTimeColumn get closedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Цели и боссы. Босс — цель с полосой HP; урон наносят выполненные шаги.
class Goals extends Table with _SyncColumns {
  TextColumn get title => text()();
  TextColumn get notes => text().nullable()();
  TextColumn get axisId => text().nullable().references(SkillAxes, #id)();
  BoolColumn get isBoss => boolean().withDefault(const Constant(false))();
  IntColumn get hpTotal => integer().withDefault(const Constant(0))();
  IntColumn get hpRemaining => integer().withDefault(const Constant(0))();
  IntColumn get status =>
      intEnum<GoalStatus>().withDefault(Constant(GoalStatus.active.index))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Подзадачи (шаги) цели. Выполнение шага наносит урон боссу и даёт XP.
class GoalSteps extends Table with _SyncColumns {
  TextColumn get goalId => text().references(Goals, #id)();
  TextColumn get title => text()();
  IntColumn get difficulty => intEnum<Difficulty>()
      .withDefault(Constant(Difficulty.auto.index))();
  IntColumn get estimatedMinutes => integer().withDefault(const Constant(25))();
  IntColumn get expectedXp => integer().withDefault(const Constant(0))();
  IntColumn get status =>
      intEnum<TaskStatus>().withDefault(Constant(TaskStatus.pending.index))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Подшаги (чек-лист) шага цели. Награды не дают — служат разбивкой
/// крупного шага на мелкие действия; прогресс виден на плитке шага.
class GoalSubSteps extends Table with _SyncColumns {
  TextColumn get stepId => text().references(GoalSteps, #id)();
  TextColumn get title => text()();
  BoolColumn get done => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Ежедневные квесты. Прогресс считается динамически из данных за день;
/// в строке хранится только цель, награда и факт получения награды.
class DailyQuests extends Table with _SyncColumns {
  TextColumn get dateKey => text()(); // 'YYYY-MM-DD' (локальная дата)
  IntColumn get type => intEnum<QuestType>()();
  IntColumn get target => integer()();
  IntColumn get rewardXp => integer()();
  IntColumn get rewardGold => integer()();
  BoolColumn get claimed => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Разблокированные достижения (определения — в коде; id = ключ достижения).
class UserAchievements extends Table with _SyncColumns {
  DateTimeColumn get unlockedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Инвентарь купленной кастомизации (каталог — в коде; id = ключ предмета).
class InventoryItems extends Table with _SyncColumns {
  DateTimeColumn get acquiredAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get equipped => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Записи сна: одна запись за ночь. dateKey — дата подъёма (YYYY-MM-DD).
class SleepLogs extends Table with _SyncColumns {
  TextColumn get dateKey => text()(); // дата подъёма 'YYYY-MM-DD'
  DateTimeColumn get bedTime => dateTime()();
  DateTimeColumn get wakeTime => dateTime()();
  TextColumn get note => text().nullable()();
  IntColumn get xpAwarded => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Кодекс героя: прогресс по цитатам/советам. id = стабильный ключ из каталога.
class CodexEntries extends Table with _SyncColumns {
  DateTimeColumn get discoveredAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

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
