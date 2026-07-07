import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rpg_task/core/database/app_database.dart';
import 'package:rpg_task/core/database/seed.dart';
import 'package:rpg_task/features/stats/data/stats_repository.dart';

/// Регресс на баг «Ошибка запуска: Bad state: Too many elements».
///
/// Из-за случайного id снимка при синхронизации между устройствами за один
/// день могло появиться несколько строк StatSnapshots с одинаковым dateKey.
/// recordDailySnapshot() запрашивал строку за сегодня через getSingleOrNull и
/// падал на старте приложения. Теперь id стабилен (snap_<дата>), а дубликаты
/// схлопываются.
void main() {
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await seedDatabase(db);
  });

  tearDown(() async {
    await db.close();
  });

  String todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }

  test('recordDailySnapshot не падает при дубликатах снимка за один день',
      () async {
    final key = todayKey();
    // Имитируем два снимка за сегодня со случайными id (как после слияния
    // при синхронизации двух устройств).
    for (final id in ['dup_a', 'dup_b']) {
      await db.into(db.statSnapshots).insert(
            StatSnapshotsCompanion.insert(id: id, dateKey: key),
          );
    }

    // Раньше здесь летело «Bad state: Too many elements».
    await StatsRepository(db).recordDailySnapshot();

    // За сегодня должен остаться ровно один живой снимок — канонический.
    final live = await (db.select(db.statSnapshots)
          ..where((s) => s.dateKey.equals(key) & s.isDeleted.equals(false)))
        .get();
    expect(live, hasLength(1));
    expect(live.single.id, 'snap_$key');

    // Старые дубликаты помечены удалёнными и «грязными» (уедут в облако).
    final tombstones = await (db.select(db.statSnapshots)
          ..where((s) => s.isDeleted.equals(true)))
        .get();
    expect(tombstones.map((s) => s.id), containsAll(['dup_a', 'dup_b']));
    expect(tombstones.every((s) => s.dirty), isTrue);
  });

  test('повторный вызов recordDailySnapshot идемпотентен', () async {
    final repo = StatsRepository(db);
    await repo.recordDailySnapshot();
    await repo.recordDailySnapshot();

    final key = todayKey();
    final live = await (db.select(db.statSnapshots)
          ..where((s) => s.dateKey.equals(key) & s.isDeleted.equals(false)))
        .get();
    expect(live, hasLength(1));
    expect(live.single.id, 'snap_$key');
  });
}
