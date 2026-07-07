import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import 'app_database.dart';

/// Фиксированный id единственного профиля игрока.
const String kProfileId = 'me';

/// «Очень старая» метка времени для сид-строк (профиль, стандартные оси).
///
/// Базовые строки создаются как `dirty = false` и с этой датой, поэтому:
///  • они НЕ выгружаются в облако при первом запуске (не затирают данные,
///    накопленные на другом устройстве, по правилу last-write-wins);
///  • при подтягивании облачная версия всегда «новее» и корректно применяется.
/// Как только пользователь что-то заработает локально, строка станет `dirty`
/// с актуальной датой и будет синхронизироваться как обычно.
final DateTime _seedEpoch = DateTime.fromMillisecondsSinceEpoch(0);

class _AxisSeed {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  const _AxisSeed(this.id, this.name, this.icon, this.color);
}

/// Стандартный набор осей «розы навыков» (создаётся при первом запуске).
/// id — стабильные (не случайные), чтобы дефолтные оси на разных устройствах
/// совпадали и сливались при синхронизации, а не дублировались.
const List<_AxisSeed> _defaultAxes = [
  _AxisSeed('axis_health', 'Здоровье', Icons.favorite, Color(0xFF16A34A)),
  _AxisSeed('axis_sport', 'Спорт', Icons.fitness_center, Color(0xFFEA580C)),
  _AxisSeed('axis_study', 'Учёба', Icons.school, Color(0xFF38BDF8)),
  _AxisSeed('axis_work', 'Работа', Icons.work, Color(0xFF6D28D9)),
  _AxisSeed('axis_creativity', 'Творчество', Icons.brush, Color(0xFFD4AF37)),
  _AxisSeed('axis_relations', 'Отношения', Icons.people, Color(0xFFEC4899)),
];

/// Заполняет БД начальными данными: профиль игрока и стандартные оси.
Future<void> seedDatabase(AppDatabase db) async {
  final profile = await (db.select(db.profiles)
        ..where((p) => p.id.equals(kProfileId)))
      .getSingleOrNull();
  if (profile == null) {
    await db.into(db.profiles).insert(
          ProfilesCompanion.insert(
            id: kProfileId,
            updatedAt: Value(_seedEpoch),
            dirty: const Value(false),
          ),
        );
  }

  final axes = await db.select(db.skillAxes).get();
  if (axes.isEmpty) {
    var order = 0;
    for (final a in _defaultAxes) {
      await db.into(db.skillAxes).insert(
            SkillAxesCompanion.insert(
              id: a.id,
              name: a.name,
              iconCodePoint: a.icon.codePoint,
              colorValue: a.color.toARGB32(),
              isDefault: const Value(true),
              sortOrder: Value(order++),
              updatedAt: Value(_seedEpoch),
              dirty: const Value(false),
            ),
          );
    }
  }
}
