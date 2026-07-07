import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

const _uuid = Uuid();

/// Доступ к осям «розы навыков».
class SkillRepository {
  final AppDatabase db;
  SkillRepository(this.db);

  Stream<List<SkillAxe>> watchAxes() {
    return (db.select(db.skillAxes)
          ..where((a) => a.isDeleted.equals(false))
          ..orderBy([(a) => OrderingTerm(expression: a.sortOrder)]))
        .watch();
  }

  Future<List<SkillAxe>> getAxes() {
    return (db.select(db.skillAxes)
          ..where((a) => a.isDeleted.equals(false))
          ..orderBy([(a) => OrderingTerm(expression: a.sortOrder)]))
        .get();
  }

  Future<void> addAxis({
    required String name,
    required int iconCodePoint,
    required int colorValue,
  }) async {
    final existing = await db.select(db.skillAxes).get();
    await db.into(db.skillAxes).insert(
          SkillAxesCompanion.insert(
            id: _uuid.v4(),
            name: name,
            iconCodePoint: iconCodePoint,
            colorValue: colorValue,
            sortOrder: Value(existing.length),
          ),
        );
  }

  /// Редактирование оси: имя, иконка, цвет.
  Future<void> updateAxis({
    required String id,
    required String name,
    required int iconCodePoint,
    required int colorValue,
  }) {
    return (db.update(db.skillAxes)..where((a) => a.id.equals(id))).write(
      SkillAxesCompanion(
        name: Value(name),
        iconCodePoint: Value(iconCodePoint),
        colorValue: Value(colorValue),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Переустанавливает порядок осей согласно позиции id в [orderedIds].
  Future<void> reorder(List<String> orderedIds) async {
    await db.transaction(() async {
      final now = DateTime.now();
      for (var i = 0; i < orderedIds.length; i++) {
        await (db.update(db.skillAxes)..where((a) => a.id.equals(orderedIds[i])))
            .write(SkillAxesCompanion(
          sortOrder: Value(i),
          dirty: const Value(true),
          updatedAt: Value(now),
        ));
      }
    });
  }

  /// Сколько активных задач/привычек/целей привязано к оси.
  Future<int> countLinked(String axisId) async {
    final tasks = await (db.select(db.tasks)
          ..where((t) => t.axisId.equals(axisId) & t.isDeleted.equals(false)))
        .get();
    final habits = await (db.select(db.habits)
          ..where((h) => h.axisId.equals(axisId) & h.isDeleted.equals(false)))
        .get();
    final goals = await (db.select(db.goals)
          ..where((g) => g.axisId.equals(axisId) & g.isDeleted.equals(false)))
        .get();
    return tasks.length + habits.length + goals.length;
  }

  /// Удаляет ось. Привязанные задачи/привычки/цели либо переназначаются на
  /// [reassignTo], либо отвязываются (axisId = null), если [reassignTo] == null.
  Future<void> deleteAxis(String id, {String? reassignTo}) async {
    await db.transaction(() async {
      final now = DateTime.now();
      final newAxis = Value<String?>(reassignTo);

      await (db.update(db.tasks)..where((t) => t.axisId.equals(id))).write(
          TasksCompanion(
              axisId: newAxis, dirty: const Value(true), updatedAt: Value(now)));
      await (db.update(db.habits)..where((h) => h.axisId.equals(id))).write(
          HabitsCompanion(
              axisId: newAxis, dirty: const Value(true), updatedAt: Value(now)));
      await (db.update(db.goals)..where((g) => g.axisId.equals(id))).write(
          GoalsCompanion(
              axisId: newAxis, dirty: const Value(true), updatedAt: Value(now)));

      await (db.update(db.skillAxes)..where((a) => a.id.equals(id))).write(
        SkillAxesCompanion(
          isDeleted: const Value(true),
          dirty: const Value(true),
          updatedAt: Value(now),
        ),
      );
    });
  }

  Future<void> softDelete(String id) {
    return (db.update(db.skillAxes)..where((a) => a.id.equals(id))).write(
      SkillAxesCompanion(
        isDeleted: const Value(true),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

final skillRepositoryProvider = Provider<SkillRepository>((ref) {
  return SkillRepository(ref.watch(databaseProvider));
});

final axesStreamProvider = StreamProvider<List<SkillAxe>>((ref) {
  return ref.watch(skillRepositoryProvider).watchAxes();
});
