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
