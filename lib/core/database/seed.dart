import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'app_database.dart';

const _uuid = Uuid();

/// Фиксированный id единственного профиля игрока.
const String kProfileId = 'me';

class _AxisSeed {
  final String name;
  final IconData icon;
  final Color color;
  const _AxisSeed(this.name, this.icon, this.color);
}

/// Стандартный набор осей «розы навыков» (создаётся при первом запуске).
const List<_AxisSeed> _defaultAxes = [
  _AxisSeed('Здоровье', Icons.favorite, Color(0xFF16A34A)),
  _AxisSeed('Спорт', Icons.fitness_center, Color(0xFFEA580C)),
  _AxisSeed('Учёба', Icons.school, Color(0xFF38BDF8)),
  _AxisSeed('Работа', Icons.work, Color(0xFF6D28D9)),
  _AxisSeed('Творчество', Icons.brush, Color(0xFFD4AF37)),
  _AxisSeed('Отношения', Icons.people, Color(0xFFEC4899)),
];

/// Заполняет БД начальными данными: профиль игрока и стандартные оси.
Future<void> seedDatabase(AppDatabase db) async {
  final profile = await (db.select(db.profiles)
        ..where((p) => p.id.equals(kProfileId)))
      .getSingleOrNull();
  if (profile == null) {
    await db
        .into(db.profiles)
        .insert(ProfilesCompanion.insert(id: kProfileId));
  }

  final axes = await db.select(db.skillAxes).get();
  if (axes.isEmpty) {
    var order = 0;
    for (final a in _defaultAxes) {
      await db.into(db.skillAxes).insert(
            SkillAxesCompanion.insert(
              id: _uuid.v4(),
              name: a.name,
              iconCodePoint: a.icon.codePoint,
              colorValue: a.color.toARGB32(),
              isDefault: const Value(true),
              sortOrder: Value(order++),
            ),
          );
    }
  }
}
