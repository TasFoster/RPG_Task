// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SkillAxesTable extends SkillAxes
    with TableInfo<$SkillAxesTable, SkillAxe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkillAxesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconCodePointMeta = const VerificationMeta(
    'iconCodePoint',
  );
  @override
  late final GeneratedColumn<int> iconCodePoint = GeneratedColumn<int>(
    'icon_code_point',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    name,
    iconCodePoint,
    colorValue,
    isDefault,
    sortOrder,
    xp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skill_axes';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkillAxe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_code_point')) {
      context.handle(
        _iconCodePointMeta,
        iconCodePoint.isAcceptableOrUnknown(
          data['icon_code_point']!,
          _iconCodePointMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_iconCodePointMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkillAxe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkillAxe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconCodePoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}icon_code_point'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
    );
  }

  @override
  $SkillAxesTable createAlias(String alias) {
    return $SkillAxesTable(attachedDatabase, alias);
  }
}

class SkillAxe extends DataClass implements Insertable<SkillAxe> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final String name;
  final int iconCodePoint;
  final int colorValue;
  final bool isDefault;
  final int sortOrder;
  final int xp;
  const SkillAxe({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.name,
    required this.iconCodePoint,
    required this.colorValue,
    required this.isDefault,
    required this.sortOrder,
    required this.xp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['name'] = Variable<String>(name);
    map['icon_code_point'] = Variable<int>(iconCodePoint);
    map['color_value'] = Variable<int>(colorValue);
    map['is_default'] = Variable<bool>(isDefault);
    map['sort_order'] = Variable<int>(sortOrder);
    map['xp'] = Variable<int>(xp);
    return map;
  }

  SkillAxesCompanion toCompanion(bool nullToAbsent) {
    return SkillAxesCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      name: Value(name),
      iconCodePoint: Value(iconCodePoint),
      colorValue: Value(colorValue),
      isDefault: Value(isDefault),
      sortOrder: Value(sortOrder),
      xp: Value(xp),
    );
  }

  factory SkillAxe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkillAxe(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      name: serializer.fromJson<String>(json['name']),
      iconCodePoint: serializer.fromJson<int>(json['iconCodePoint']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      xp: serializer.fromJson<int>(json['xp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'name': serializer.toJson<String>(name),
      'iconCodePoint': serializer.toJson<int>(iconCodePoint),
      'colorValue': serializer.toJson<int>(colorValue),
      'isDefault': serializer.toJson<bool>(isDefault),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'xp': serializer.toJson<int>(xp),
    };
  }

  SkillAxe copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    String? name,
    int? iconCodePoint,
    int? colorValue,
    bool? isDefault,
    int? sortOrder,
    int? xp,
  }) => SkillAxe(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    name: name ?? this.name,
    iconCodePoint: iconCodePoint ?? this.iconCodePoint,
    colorValue: colorValue ?? this.colorValue,
    isDefault: isDefault ?? this.isDefault,
    sortOrder: sortOrder ?? this.sortOrder,
    xp: xp ?? this.xp,
  );
  SkillAxe copyWithCompanion(SkillAxesCompanion data) {
    return SkillAxe(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      name: data.name.present ? data.name.value : this.name,
      iconCodePoint: data.iconCodePoint.present
          ? data.iconCodePoint.value
          : this.iconCodePoint,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      xp: data.xp.present ? data.xp.value : this.xp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkillAxe(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('colorValue: $colorValue, ')
          ..write('isDefault: $isDefault, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('xp: $xp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    name,
    iconCodePoint,
    colorValue,
    isDefault,
    sortOrder,
    xp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkillAxe &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.name == this.name &&
          other.iconCodePoint == this.iconCodePoint &&
          other.colorValue == this.colorValue &&
          other.isDefault == this.isDefault &&
          other.sortOrder == this.sortOrder &&
          other.xp == this.xp);
}

class SkillAxesCompanion extends UpdateCompanion<SkillAxe> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<String> name;
  final Value<int> iconCodePoint;
  final Value<int> colorValue;
  final Value<bool> isDefault;
  final Value<int> sortOrder;
  final Value<int> xp;
  final Value<int> rowid;
  const SkillAxesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.name = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.xp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkillAxesCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String name,
    required int iconCodePoint,
    required int colorValue,
    this.isDefault = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.xp = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       iconCodePoint = Value(iconCodePoint),
       colorValue = Value(colorValue);
  static Insertable<SkillAxe> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<String>? name,
    Expression<int>? iconCodePoint,
    Expression<int>? colorValue,
    Expression<bool>? isDefault,
    Expression<int>? sortOrder,
    Expression<int>? xp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (name != null) 'name': name,
      if (iconCodePoint != null) 'icon_code_point': iconCodePoint,
      if (colorValue != null) 'color_value': colorValue,
      if (isDefault != null) 'is_default': isDefault,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (xp != null) 'xp': xp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkillAxesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<String>? name,
    Value<int>? iconCodePoint,
    Value<int>? colorValue,
    Value<bool>? isDefault,
    Value<int>? sortOrder,
    Value<int>? xp,
    Value<int>? rowid,
  }) {
    return SkillAxesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      name: name ?? this.name,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      colorValue: colorValue ?? this.colorValue,
      isDefault: isDefault ?? this.isDefault,
      sortOrder: sortOrder ?? this.sortOrder,
      xp: xp ?? this.xp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconCodePoint.present) {
      map['icon_code_point'] = Variable<int>(iconCodePoint.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkillAxesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('colorValue: $colorValue, ')
          ..write('isDefault: $isDefault, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('xp: $xp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _axisIdMeta = const VerificationMeta('axisId');
  @override
  late final GeneratedColumn<String> axisId = GeneratedColumn<String>(
    'axis_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skill_axes (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Difficulty, int> difficulty =
      GeneratedColumn<int>(
        'difficulty',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(Difficulty.auto.index),
      ).withConverter<Difficulty>($TasksTable.$converterdifficulty);
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(25),
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderAtMeta = const VerificationMeta(
    'reminderAt',
  );
  @override
  late final GeneratedColumn<DateTime> reminderAt = GeneratedColumn<DateTime>(
    'reminder_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TaskStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(TaskStatus.pending.index),
      ).withConverter<TaskStatus>($TasksTable.$converterstatus);
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _xpAwardedMeta = const VerificationMeta(
    'xpAwarded',
  );
  @override
  late final GeneratedColumn<int> xpAwarded = GeneratedColumn<int>(
    'xp_awarded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goldAwardedMeta = const VerificationMeta(
    'goldAwarded',
  );
  @override
  late final GeneratedColumn<int> goldAwarded = GeneratedColumn<int>(
    'gold_awarded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    title,
    notes,
    axisId,
    difficulty,
    estimatedMinutes,
    dueAt,
    reminderAt,
    status,
    completedAt,
    xpAwarded,
    goldAwarded,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('axis_id')) {
      context.handle(
        _axisIdMeta,
        axisId.isAcceptableOrUnknown(data['axis_id']!, _axisIdMeta),
      );
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('reminder_at')) {
      context.handle(
        _reminderAtMeta,
        reminderAt.isAcceptableOrUnknown(data['reminder_at']!, _reminderAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('xp_awarded')) {
      context.handle(
        _xpAwardedMeta,
        xpAwarded.isAcceptableOrUnknown(data['xp_awarded']!, _xpAwardedMeta),
      );
    }
    if (data.containsKey('gold_awarded')) {
      context.handle(
        _goldAwardedMeta,
        goldAwarded.isAcceptableOrUnknown(
          data['gold_awarded']!,
          _goldAwardedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      axisId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}axis_id'],
      ),
      difficulty: $TasksTable.$converterdifficulty.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}difficulty'],
        )!,
      ),
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      ),
      reminderAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reminder_at'],
      ),
      status: $TasksTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      xpAwarded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_awarded'],
      )!,
      goldAwarded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gold_awarded'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Difficulty, int, int> $converterdifficulty =
      const EnumIndexConverter<Difficulty>(Difficulty.values);
  static JsonTypeConverter2<TaskStatus, int, int> $converterstatus =
      const EnumIndexConverter<TaskStatus>(TaskStatus.values);
}

class Task extends DataClass implements Insertable<Task> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final String title;
  final String? notes;
  final String? axisId;
  final Difficulty difficulty;
  final int estimatedMinutes;
  final DateTime? dueAt;
  final DateTime? reminderAt;
  final TaskStatus status;
  final DateTime? completedAt;
  final int xpAwarded;
  final int goldAwarded;
  final DateTime createdAt;
  const Task({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.title,
    this.notes,
    this.axisId,
    required this.difficulty,
    required this.estimatedMinutes,
    this.dueAt,
    this.reminderAt,
    required this.status,
    this.completedAt,
    required this.xpAwarded,
    required this.goldAwarded,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || axisId != null) {
      map['axis_id'] = Variable<String>(axisId);
    }
    {
      map['difficulty'] = Variable<int>(
        $TasksTable.$converterdifficulty.toSql(difficulty),
      );
    }
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<DateTime>(dueAt);
    }
    if (!nullToAbsent || reminderAt != null) {
      map['reminder_at'] = Variable<DateTime>(reminderAt);
    }
    {
      map['status'] = Variable<int>($TasksTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['xp_awarded'] = Variable<int>(xpAwarded);
    map['gold_awarded'] = Variable<int>(goldAwarded);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      title: Value(title),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      axisId: axisId == null && nullToAbsent
          ? const Value.absent()
          : Value(axisId),
      difficulty: Value(difficulty),
      estimatedMinutes: Value(estimatedMinutes),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      reminderAt: reminderAt == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderAt),
      status: Value(status),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      xpAwarded: Value(xpAwarded),
      goldAwarded: Value(goldAwarded),
      createdAt: Value(createdAt),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String?>(json['notes']),
      axisId: serializer.fromJson<String?>(json['axisId']),
      difficulty: $TasksTable.$converterdifficulty.fromJson(
        serializer.fromJson<int>(json['difficulty']),
      ),
      estimatedMinutes: serializer.fromJson<int>(json['estimatedMinutes']),
      dueAt: serializer.fromJson<DateTime?>(json['dueAt']),
      reminderAt: serializer.fromJson<DateTime?>(json['reminderAt']),
      status: $TasksTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      xpAwarded: serializer.fromJson<int>(json['xpAwarded']),
      goldAwarded: serializer.fromJson<int>(json['goldAwarded']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String?>(notes),
      'axisId': serializer.toJson<String?>(axisId),
      'difficulty': serializer.toJson<int>(
        $TasksTable.$converterdifficulty.toJson(difficulty),
      ),
      'estimatedMinutes': serializer.toJson<int>(estimatedMinutes),
      'dueAt': serializer.toJson<DateTime?>(dueAt),
      'reminderAt': serializer.toJson<DateTime?>(reminderAt),
      'status': serializer.toJson<int>(
        $TasksTable.$converterstatus.toJson(status),
      ),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'xpAwarded': serializer.toJson<int>(xpAwarded),
      'goldAwarded': serializer.toJson<int>(goldAwarded),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Task copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    String? title,
    Value<String?> notes = const Value.absent(),
    Value<String?> axisId = const Value.absent(),
    Difficulty? difficulty,
    int? estimatedMinutes,
    Value<DateTime?> dueAt = const Value.absent(),
    Value<DateTime?> reminderAt = const Value.absent(),
    TaskStatus? status,
    Value<DateTime?> completedAt = const Value.absent(),
    int? xpAwarded,
    int? goldAwarded,
    DateTime? createdAt,
  }) => Task(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    title: title ?? this.title,
    notes: notes.present ? notes.value : this.notes,
    axisId: axisId.present ? axisId.value : this.axisId,
    difficulty: difficulty ?? this.difficulty,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    reminderAt: reminderAt.present ? reminderAt.value : this.reminderAt,
    status: status ?? this.status,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    xpAwarded: xpAwarded ?? this.xpAwarded,
    goldAwarded: goldAwarded ?? this.goldAwarded,
    createdAt: createdAt ?? this.createdAt,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      axisId: data.axisId.present ? data.axisId.value : this.axisId,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      estimatedMinutes: data.estimatedMinutes.present
          ? data.estimatedMinutes.value
          : this.estimatedMinutes,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      reminderAt: data.reminderAt.present
          ? data.reminderAt.value
          : this.reminderAt,
      status: data.status.present ? data.status.value : this.status,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      xpAwarded: data.xpAwarded.present ? data.xpAwarded.value : this.xpAwarded,
      goldAwarded: data.goldAwarded.present
          ? data.goldAwarded.value
          : this.goldAwarded,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('axisId: $axisId, ')
          ..write('difficulty: $difficulty, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('dueAt: $dueAt, ')
          ..write('reminderAt: $reminderAt, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt, ')
          ..write('xpAwarded: $xpAwarded, ')
          ..write('goldAwarded: $goldAwarded, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    title,
    notes,
    axisId,
    difficulty,
    estimatedMinutes,
    dueAt,
    reminderAt,
    status,
    completedAt,
    xpAwarded,
    goldAwarded,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.axisId == this.axisId &&
          other.difficulty == this.difficulty &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.dueAt == this.dueAt &&
          other.reminderAt == this.reminderAt &&
          other.status == this.status &&
          other.completedAt == this.completedAt &&
          other.xpAwarded == this.xpAwarded &&
          other.goldAwarded == this.goldAwarded &&
          other.createdAt == this.createdAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<String> title;
  final Value<String?> notes;
  final Value<String?> axisId;
  final Value<Difficulty> difficulty;
  final Value<int> estimatedMinutes;
  final Value<DateTime?> dueAt;
  final Value<DateTime?> reminderAt;
  final Value<TaskStatus> status;
  final Value<DateTime?> completedAt;
  final Value<int> xpAwarded;
  final Value<int> goldAwarded;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.axisId = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.reminderAt = const Value.absent(),
    this.status = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.xpAwarded = const Value.absent(),
    this.goldAwarded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String title,
    this.notes = const Value.absent(),
    this.axisId = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.reminderAt = const Value.absent(),
    this.status = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.xpAwarded = const Value.absent(),
    this.goldAwarded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title);
  static Insertable<Task> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<String>? axisId,
    Expression<int>? difficulty,
    Expression<int>? estimatedMinutes,
    Expression<DateTime>? dueAt,
    Expression<DateTime>? reminderAt,
    Expression<int>? status,
    Expression<DateTime>? completedAt,
    Expression<int>? xpAwarded,
    Expression<int>? goldAwarded,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (axisId != null) 'axis_id': axisId,
      if (difficulty != null) 'difficulty': difficulty,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (dueAt != null) 'due_at': dueAt,
      if (reminderAt != null) 'reminder_at': reminderAt,
      if (status != null) 'status': status,
      if (completedAt != null) 'completed_at': completedAt,
      if (xpAwarded != null) 'xp_awarded': xpAwarded,
      if (goldAwarded != null) 'gold_awarded': goldAwarded,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<String>? title,
    Value<String?>? notes,
    Value<String?>? axisId,
    Value<Difficulty>? difficulty,
    Value<int>? estimatedMinutes,
    Value<DateTime?>? dueAt,
    Value<DateTime?>? reminderAt,
    Value<TaskStatus>? status,
    Value<DateTime?>? completedAt,
    Value<int>? xpAwarded,
    Value<int>? goldAwarded,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      axisId: axisId ?? this.axisId,
      difficulty: difficulty ?? this.difficulty,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      dueAt: dueAt ?? this.dueAt,
      reminderAt: reminderAt ?? this.reminderAt,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
      xpAwarded: xpAwarded ?? this.xpAwarded,
      goldAwarded: goldAwarded ?? this.goldAwarded,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (axisId.present) {
      map['axis_id'] = Variable<String>(axisId.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(
        $TasksTable.$converterdifficulty.toSql(difficulty.value),
      );
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (reminderAt.present) {
      map['reminder_at'] = Variable<DateTime>(reminderAt.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $TasksTable.$converterstatus.toSql(status.value),
      );
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (xpAwarded.present) {
      map['xp_awarded'] = Variable<int>(xpAwarded.value);
    }
    if (goldAwarded.present) {
      map['gold_awarded'] = Variable<int>(goldAwarded.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('axisId: $axisId, ')
          ..write('difficulty: $difficulty, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('dueAt: $dueAt, ')
          ..write('reminderAt: $reminderAt, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt, ')
          ..write('xpAwarded: $xpAwarded, ')
          ..write('goldAwarded: $goldAwarded, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _axisIdMeta = const VerificationMeta('axisId');
  @override
  late final GeneratedColumn<String> axisId = GeneratedColumn<String>(
    'axis_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skill_axes (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<HabitType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(HabitType.positive.index),
      ).withConverter<HabitType>($HabitsTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<Frequency, int> frequency =
      GeneratedColumn<int>(
        'frequency',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(Frequency.daily.index),
      ).withConverter<Frequency>($HabitsTable.$converterfrequency);
  @override
  late final GeneratedColumnWithTypeConverter<Difficulty, int> difficulty =
      GeneratedColumn<int>(
        'difficulty',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(Difficulty.auto.index),
      ).withConverter<Difficulty>($HabitsTable.$converterdifficulty);
  static const VerificationMeta _streakCurrentMeta = const VerificationMeta(
    'streakCurrent',
  );
  @override
  late final GeneratedColumn<int> streakCurrent = GeneratedColumn<int>(
    'streak_current',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _streakBestMeta = const VerificationMeta(
    'streakBest',
  );
  @override
  late final GeneratedColumn<int> streakBest = GeneratedColumn<int>(
    'streak_best',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reminderMinutesMeta = const VerificationMeta(
    'reminderMinutes',
  );
  @override
  late final GeneratedColumn<int> reminderMinutes = GeneratedColumn<int>(
    'reminder_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastCompletedAtMeta = const VerificationMeta(
    'lastCompletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastCompletedAt =
      GeneratedColumn<DateTime>(
        'last_completed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    title,
    axisId,
    type,
    frequency,
    difficulty,
    streakCurrent,
    streakBest,
    reminderMinutes,
    lastCompletedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('axis_id')) {
      context.handle(
        _axisIdMeta,
        axisId.isAcceptableOrUnknown(data['axis_id']!, _axisIdMeta),
      );
    }
    if (data.containsKey('streak_current')) {
      context.handle(
        _streakCurrentMeta,
        streakCurrent.isAcceptableOrUnknown(
          data['streak_current']!,
          _streakCurrentMeta,
        ),
      );
    }
    if (data.containsKey('streak_best')) {
      context.handle(
        _streakBestMeta,
        streakBest.isAcceptableOrUnknown(data['streak_best']!, _streakBestMeta),
      );
    }
    if (data.containsKey('reminder_minutes')) {
      context.handle(
        _reminderMinutesMeta,
        reminderMinutes.isAcceptableOrUnknown(
          data['reminder_minutes']!,
          _reminderMinutesMeta,
        ),
      );
    }
    if (data.containsKey('last_completed_at')) {
      context.handle(
        _lastCompletedAtMeta,
        lastCompletedAt.isAcceptableOrUnknown(
          data['last_completed_at']!,
          _lastCompletedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      axisId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}axis_id'],
      ),
      type: $HabitsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      frequency: $HabitsTable.$converterfrequency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}frequency'],
        )!,
      ),
      difficulty: $HabitsTable.$converterdifficulty.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}difficulty'],
        )!,
      ),
      streakCurrent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak_current'],
      )!,
      streakBest: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak_best'],
      )!,
      reminderMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_minutes'],
      ),
      lastCompletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<HabitType, int, int> $convertertype =
      const EnumIndexConverter<HabitType>(HabitType.values);
  static JsonTypeConverter2<Frequency, int, int> $converterfrequency =
      const EnumIndexConverter<Frequency>(Frequency.values);
  static JsonTypeConverter2<Difficulty, int, int> $converterdifficulty =
      const EnumIndexConverter<Difficulty>(Difficulty.values);
}

class Habit extends DataClass implements Insertable<Habit> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final String title;
  final String? axisId;
  final HabitType type;
  final Frequency frequency;
  final Difficulty difficulty;
  final int streakCurrent;
  final int streakBest;
  final int? reminderMinutes;
  final DateTime? lastCompletedAt;
  final DateTime createdAt;
  const Habit({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.title,
    this.axisId,
    required this.type,
    required this.frequency,
    required this.difficulty,
    required this.streakCurrent,
    required this.streakBest,
    this.reminderMinutes,
    this.lastCompletedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || axisId != null) {
      map['axis_id'] = Variable<String>(axisId);
    }
    {
      map['type'] = Variable<int>($HabitsTable.$convertertype.toSql(type));
    }
    {
      map['frequency'] = Variable<int>(
        $HabitsTable.$converterfrequency.toSql(frequency),
      );
    }
    {
      map['difficulty'] = Variable<int>(
        $HabitsTable.$converterdifficulty.toSql(difficulty),
      );
    }
    map['streak_current'] = Variable<int>(streakCurrent);
    map['streak_best'] = Variable<int>(streakBest);
    if (!nullToAbsent || reminderMinutes != null) {
      map['reminder_minutes'] = Variable<int>(reminderMinutes);
    }
    if (!nullToAbsent || lastCompletedAt != null) {
      map['last_completed_at'] = Variable<DateTime>(lastCompletedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      title: Value(title),
      axisId: axisId == null && nullToAbsent
          ? const Value.absent()
          : Value(axisId),
      type: Value(type),
      frequency: Value(frequency),
      difficulty: Value(difficulty),
      streakCurrent: Value(streakCurrent),
      streakBest: Value(streakBest),
      reminderMinutes: reminderMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderMinutes),
      lastCompletedAt: lastCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCompletedAt),
      createdAt: Value(createdAt),
    );
  }

  factory Habit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      title: serializer.fromJson<String>(json['title']),
      axisId: serializer.fromJson<String?>(json['axisId']),
      type: $HabitsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      frequency: $HabitsTable.$converterfrequency.fromJson(
        serializer.fromJson<int>(json['frequency']),
      ),
      difficulty: $HabitsTable.$converterdifficulty.fromJson(
        serializer.fromJson<int>(json['difficulty']),
      ),
      streakCurrent: serializer.fromJson<int>(json['streakCurrent']),
      streakBest: serializer.fromJson<int>(json['streakBest']),
      reminderMinutes: serializer.fromJson<int?>(json['reminderMinutes']),
      lastCompletedAt: serializer.fromJson<DateTime?>(json['lastCompletedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'title': serializer.toJson<String>(title),
      'axisId': serializer.toJson<String?>(axisId),
      'type': serializer.toJson<int>($HabitsTable.$convertertype.toJson(type)),
      'frequency': serializer.toJson<int>(
        $HabitsTable.$converterfrequency.toJson(frequency),
      ),
      'difficulty': serializer.toJson<int>(
        $HabitsTable.$converterdifficulty.toJson(difficulty),
      ),
      'streakCurrent': serializer.toJson<int>(streakCurrent),
      'streakBest': serializer.toJson<int>(streakBest),
      'reminderMinutes': serializer.toJson<int?>(reminderMinutes),
      'lastCompletedAt': serializer.toJson<DateTime?>(lastCompletedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Habit copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    String? title,
    Value<String?> axisId = const Value.absent(),
    HabitType? type,
    Frequency? frequency,
    Difficulty? difficulty,
    int? streakCurrent,
    int? streakBest,
    Value<int?> reminderMinutes = const Value.absent(),
    Value<DateTime?> lastCompletedAt = const Value.absent(),
    DateTime? createdAt,
  }) => Habit(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    title: title ?? this.title,
    axisId: axisId.present ? axisId.value : this.axisId,
    type: type ?? this.type,
    frequency: frequency ?? this.frequency,
    difficulty: difficulty ?? this.difficulty,
    streakCurrent: streakCurrent ?? this.streakCurrent,
    streakBest: streakBest ?? this.streakBest,
    reminderMinutes: reminderMinutes.present
        ? reminderMinutes.value
        : this.reminderMinutes,
    lastCompletedAt: lastCompletedAt.present
        ? lastCompletedAt.value
        : this.lastCompletedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      title: data.title.present ? data.title.value : this.title,
      axisId: data.axisId.present ? data.axisId.value : this.axisId,
      type: data.type.present ? data.type.value : this.type,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      streakCurrent: data.streakCurrent.present
          ? data.streakCurrent.value
          : this.streakCurrent,
      streakBest: data.streakBest.present
          ? data.streakBest.value
          : this.streakBest,
      reminderMinutes: data.reminderMinutes.present
          ? data.reminderMinutes.value
          : this.reminderMinutes,
      lastCompletedAt: data.lastCompletedAt.present
          ? data.lastCompletedAt.value
          : this.lastCompletedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('title: $title, ')
          ..write('axisId: $axisId, ')
          ..write('type: $type, ')
          ..write('frequency: $frequency, ')
          ..write('difficulty: $difficulty, ')
          ..write('streakCurrent: $streakCurrent, ')
          ..write('streakBest: $streakBest, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('lastCompletedAt: $lastCompletedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    title,
    axisId,
    type,
    frequency,
    difficulty,
    streakCurrent,
    streakBest,
    reminderMinutes,
    lastCompletedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.title == this.title &&
          other.axisId == this.axisId &&
          other.type == this.type &&
          other.frequency == this.frequency &&
          other.difficulty == this.difficulty &&
          other.streakCurrent == this.streakCurrent &&
          other.streakBest == this.streakBest &&
          other.reminderMinutes == this.reminderMinutes &&
          other.lastCompletedAt == this.lastCompletedAt &&
          other.createdAt == this.createdAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<String> title;
  final Value<String?> axisId;
  final Value<HabitType> type;
  final Value<Frequency> frequency;
  final Value<Difficulty> difficulty;
  final Value<int> streakCurrent;
  final Value<int> streakBest;
  final Value<int?> reminderMinutes;
  final Value<DateTime?> lastCompletedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.title = const Value.absent(),
    this.axisId = const Value.absent(),
    this.type = const Value.absent(),
    this.frequency = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.streakCurrent = const Value.absent(),
    this.streakBest = const Value.absent(),
    this.reminderMinutes = const Value.absent(),
    this.lastCompletedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String title,
    this.axisId = const Value.absent(),
    this.type = const Value.absent(),
    this.frequency = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.streakCurrent = const Value.absent(),
    this.streakBest = const Value.absent(),
    this.reminderMinutes = const Value.absent(),
    this.lastCompletedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title);
  static Insertable<Habit> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<String>? title,
    Expression<String>? axisId,
    Expression<int>? type,
    Expression<int>? frequency,
    Expression<int>? difficulty,
    Expression<int>? streakCurrent,
    Expression<int>? streakBest,
    Expression<int>? reminderMinutes,
    Expression<DateTime>? lastCompletedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (title != null) 'title': title,
      if (axisId != null) 'axis_id': axisId,
      if (type != null) 'type': type,
      if (frequency != null) 'frequency': frequency,
      if (difficulty != null) 'difficulty': difficulty,
      if (streakCurrent != null) 'streak_current': streakCurrent,
      if (streakBest != null) 'streak_best': streakBest,
      if (reminderMinutes != null) 'reminder_minutes': reminderMinutes,
      if (lastCompletedAt != null) 'last_completed_at': lastCompletedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<String>? title,
    Value<String?>? axisId,
    Value<HabitType>? type,
    Value<Frequency>? frequency,
    Value<Difficulty>? difficulty,
    Value<int>? streakCurrent,
    Value<int>? streakBest,
    Value<int?>? reminderMinutes,
    Value<DateTime?>? lastCompletedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      title: title ?? this.title,
      axisId: axisId ?? this.axisId,
      type: type ?? this.type,
      frequency: frequency ?? this.frequency,
      difficulty: difficulty ?? this.difficulty,
      streakCurrent: streakCurrent ?? this.streakCurrent,
      streakBest: streakBest ?? this.streakBest,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      lastCompletedAt: lastCompletedAt ?? this.lastCompletedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (axisId.present) {
      map['axis_id'] = Variable<String>(axisId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $HabitsTable.$convertertype.toSql(type.value),
      );
    }
    if (frequency.present) {
      map['frequency'] = Variable<int>(
        $HabitsTable.$converterfrequency.toSql(frequency.value),
      );
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(
        $HabitsTable.$converterdifficulty.toSql(difficulty.value),
      );
    }
    if (streakCurrent.present) {
      map['streak_current'] = Variable<int>(streakCurrent.value);
    }
    if (streakBest.present) {
      map['streak_best'] = Variable<int>(streakBest.value);
    }
    if (reminderMinutes.present) {
      map['reminder_minutes'] = Variable<int>(reminderMinutes.value);
    }
    if (lastCompletedAt.present) {
      map['last_completed_at'] = Variable<DateTime>(lastCompletedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('title: $title, ')
          ..write('axisId: $axisId, ')
          ..write('type: $type, ')
          ..write('frequency: $frequency, ')
          ..write('difficulty: $difficulty, ')
          ..write('streakCurrent: $streakCurrent, ')
          ..write('streakBest: $streakBest, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('lastCompletedAt: $lastCompletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitLogsTable extends HabitLogs
    with TableInfo<$HabitLogsTable, HabitLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id)',
    ),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goldMeta = const VerificationMeta('gold');
  @override
  late final GeneratedColumn<int> gold = GeneratedColumn<int>(
    'gold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    habitId,
    completedAt,
    value,
    xp,
    gold,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('gold')) {
      context.handle(
        _goldMeta,
        gold.isAcceptableOrUnknown(data['gold']!, _goldMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value'],
      )!,
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
      gold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gold'],
      )!,
    );
  }

  @override
  $HabitLogsTable createAlias(String alias) {
    return $HabitLogsTable(attachedDatabase, alias);
  }
}

class HabitLog extends DataClass implements Insertable<HabitLog> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final String habitId;
  final DateTime completedAt;
  final int value;
  final int xp;
  final int gold;
  const HabitLog({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.habitId,
    required this.completedAt,
    required this.value,
    required this.xp,
    required this.gold,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['habit_id'] = Variable<String>(habitId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['value'] = Variable<int>(value);
    map['xp'] = Variable<int>(xp);
    map['gold'] = Variable<int>(gold);
    return map;
  }

  HabitLogsCompanion toCompanion(bool nullToAbsent) {
    return HabitLogsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      habitId: Value(habitId),
      completedAt: Value(completedAt),
      value: Value(value),
      xp: Value(xp),
      gold: Value(gold),
    );
  }

  factory HabitLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitLog(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      habitId: serializer.fromJson<String>(json['habitId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      value: serializer.fromJson<int>(json['value']),
      xp: serializer.fromJson<int>(json['xp']),
      gold: serializer.fromJson<int>(json['gold']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'habitId': serializer.toJson<String>(habitId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'value': serializer.toJson<int>(value),
      'xp': serializer.toJson<int>(xp),
      'gold': serializer.toJson<int>(gold),
    };
  }

  HabitLog copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    String? habitId,
    DateTime? completedAt,
    int? value,
    int? xp,
    int? gold,
  }) => HabitLog(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    habitId: habitId ?? this.habitId,
    completedAt: completedAt ?? this.completedAt,
    value: value ?? this.value,
    xp: xp ?? this.xp,
    gold: gold ?? this.gold,
  );
  HabitLog copyWithCompanion(HabitLogsCompanion data) {
    return HabitLog(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      value: data.value.present ? data.value.value : this.value,
      xp: data.xp.present ? data.xp.value : this.xp,
      gold: data.gold.present ? data.gold.value : this.gold,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitLog(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('habitId: $habitId, ')
          ..write('completedAt: $completedAt, ')
          ..write('value: $value, ')
          ..write('xp: $xp, ')
          ..write('gold: $gold')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    habitId,
    completedAt,
    value,
    xp,
    gold,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitLog &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.habitId == this.habitId &&
          other.completedAt == this.completedAt &&
          other.value == this.value &&
          other.xp == this.xp &&
          other.gold == this.gold);
}

class HabitLogsCompanion extends UpdateCompanion<HabitLog> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<String> habitId;
  final Value<DateTime> completedAt;
  final Value<int> value;
  final Value<int> xp;
  final Value<int> gold;
  final Value<int> rowid;
  const HabitLogsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.habitId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.value = const Value.absent(),
    this.xp = const Value.absent(),
    this.gold = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitLogsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String habitId,
    this.completedAt = const Value.absent(),
    this.value = const Value.absent(),
    this.xp = const Value.absent(),
    this.gold = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       habitId = Value(habitId);
  static Insertable<HabitLog> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<String>? habitId,
    Expression<DateTime>? completedAt,
    Expression<int>? value,
    Expression<int>? xp,
    Expression<int>? gold,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (habitId != null) 'habit_id': habitId,
      if (completedAt != null) 'completed_at': completedAt,
      if (value != null) 'value': value,
      if (xp != null) 'xp': xp,
      if (gold != null) 'gold': gold,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitLogsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<String>? habitId,
    Value<DateTime>? completedAt,
    Value<int>? value,
    Value<int>? xp,
    Value<int>? gold,
    Value<int>? rowid,
  }) {
    return HabitLogsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      habitId: habitId ?? this.habitId,
      completedAt: completedAt ?? this.completedAt,
      value: value ?? this.value,
      xp: xp ?? this.xp,
      gold: gold ?? this.gold,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (gold.present) {
      map['gold'] = Variable<int>(gold.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('habitId: $habitId, ')
          ..write('completedAt: $completedAt, ')
          ..write('value: $value, ')
          ..write('xp: $xp, ')
          ..write('gold: $gold, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Искатель приключений'),
  );
  static const VerificationMeta _totalXpMeta = const VerificationMeta(
    'totalXp',
  );
  @override
  late final GeneratedColumn<int> totalXp = GeneratedColumn<int>(
    'total_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lifetimeXpMeta = const VerificationMeta(
    'lifetimeXp',
  );
  @override
  late final GeneratedColumn<int> lifetimeXp = GeneratedColumn<int>(
    'lifetime_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _prestigeMeta = const VerificationMeta(
    'prestige',
  );
  @override
  late final GeneratedColumn<int> prestige = GeneratedColumn<int>(
    'prestige',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _seasonYearMeta = const VerificationMeta(
    'seasonYear',
  );
  @override
  late final GeneratedColumn<int> seasonYear = GeneratedColumn<int>(
    'season_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _seasonMonthMeta = const VerificationMeta(
    'seasonMonth',
  );
  @override
  late final GeneratedColumn<int> seasonMonth = GeneratedColumn<int>(
    'season_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goldMeta = const VerificationMeta('gold');
  @override
  late final GeneratedColumn<int> gold = GeneratedColumn<int>(
    'gold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _gemsMeta = const VerificationMeta('gems');
  @override
  late final GeneratedColumn<int> gems = GeneratedColumn<int>(
    'gems',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    displayName,
    totalXp,
    lifetimeXp,
    prestige,
    seasonYear,
    seasonMonth,
    gold,
    gems,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Profile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('total_xp')) {
      context.handle(
        _totalXpMeta,
        totalXp.isAcceptableOrUnknown(data['total_xp']!, _totalXpMeta),
      );
    }
    if (data.containsKey('lifetime_xp')) {
      context.handle(
        _lifetimeXpMeta,
        lifetimeXp.isAcceptableOrUnknown(data['lifetime_xp']!, _lifetimeXpMeta),
      );
    }
    if (data.containsKey('prestige')) {
      context.handle(
        _prestigeMeta,
        prestige.isAcceptableOrUnknown(data['prestige']!, _prestigeMeta),
      );
    }
    if (data.containsKey('season_year')) {
      context.handle(
        _seasonYearMeta,
        seasonYear.isAcceptableOrUnknown(data['season_year']!, _seasonYearMeta),
      );
    }
    if (data.containsKey('season_month')) {
      context.handle(
        _seasonMonthMeta,
        seasonMonth.isAcceptableOrUnknown(
          data['season_month']!,
          _seasonMonthMeta,
        ),
      );
    }
    if (data.containsKey('gold')) {
      context.handle(
        _goldMeta,
        gold.isAcceptableOrUnknown(data['gold']!, _goldMeta),
      );
    }
    if (data.containsKey('gems')) {
      context.handle(
        _gemsMeta,
        gems.isAcceptableOrUnknown(data['gems']!, _gemsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      totalXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_xp'],
      )!,
      lifetimeXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lifetime_xp'],
      )!,
      prestige: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prestige'],
      )!,
      seasonYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}season_year'],
      )!,
      seasonMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}season_month'],
      )!,
      gold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gold'],
      )!,
      gems: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gems'],
      )!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final String displayName;
  final int totalXp;
  final int lifetimeXp;
  final int prestige;
  final int seasonYear;
  final int seasonMonth;
  final int gold;
  final int gems;
  const Profile({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.displayName,
    required this.totalXp,
    required this.lifetimeXp,
    required this.prestige,
    required this.seasonYear,
    required this.seasonMonth,
    required this.gold,
    required this.gems,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['display_name'] = Variable<String>(displayName);
    map['total_xp'] = Variable<int>(totalXp);
    map['lifetime_xp'] = Variable<int>(lifetimeXp);
    map['prestige'] = Variable<int>(prestige);
    map['season_year'] = Variable<int>(seasonYear);
    map['season_month'] = Variable<int>(seasonMonth);
    map['gold'] = Variable<int>(gold);
    map['gems'] = Variable<int>(gems);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      displayName: Value(displayName),
      totalXp: Value(totalXp),
      lifetimeXp: Value(lifetimeXp),
      prestige: Value(prestige),
      seasonYear: Value(seasonYear),
      seasonMonth: Value(seasonMonth),
      gold: Value(gold),
      gems: Value(gems),
    );
  }

  factory Profile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      displayName: serializer.fromJson<String>(json['displayName']),
      totalXp: serializer.fromJson<int>(json['totalXp']),
      lifetimeXp: serializer.fromJson<int>(json['lifetimeXp']),
      prestige: serializer.fromJson<int>(json['prestige']),
      seasonYear: serializer.fromJson<int>(json['seasonYear']),
      seasonMonth: serializer.fromJson<int>(json['seasonMonth']),
      gold: serializer.fromJson<int>(json['gold']),
      gems: serializer.fromJson<int>(json['gems']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'displayName': serializer.toJson<String>(displayName),
      'totalXp': serializer.toJson<int>(totalXp),
      'lifetimeXp': serializer.toJson<int>(lifetimeXp),
      'prestige': serializer.toJson<int>(prestige),
      'seasonYear': serializer.toJson<int>(seasonYear),
      'seasonMonth': serializer.toJson<int>(seasonMonth),
      'gold': serializer.toJson<int>(gold),
      'gems': serializer.toJson<int>(gems),
    };
  }

  Profile copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    String? displayName,
    int? totalXp,
    int? lifetimeXp,
    int? prestige,
    int? seasonYear,
    int? seasonMonth,
    int? gold,
    int? gems,
  }) => Profile(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    displayName: displayName ?? this.displayName,
    totalXp: totalXp ?? this.totalXp,
    lifetimeXp: lifetimeXp ?? this.lifetimeXp,
    prestige: prestige ?? this.prestige,
    seasonYear: seasonYear ?? this.seasonYear,
    seasonMonth: seasonMonth ?? this.seasonMonth,
    gold: gold ?? this.gold,
    gems: gems ?? this.gems,
  );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      totalXp: data.totalXp.present ? data.totalXp.value : this.totalXp,
      lifetimeXp: data.lifetimeXp.present
          ? data.lifetimeXp.value
          : this.lifetimeXp,
      prestige: data.prestige.present ? data.prestige.value : this.prestige,
      seasonYear: data.seasonYear.present
          ? data.seasonYear.value
          : this.seasonYear,
      seasonMonth: data.seasonMonth.present
          ? data.seasonMonth.value
          : this.seasonMonth,
      gold: data.gold.present ? data.gold.value : this.gold,
      gems: data.gems.present ? data.gems.value : this.gems,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('displayName: $displayName, ')
          ..write('totalXp: $totalXp, ')
          ..write('lifetimeXp: $lifetimeXp, ')
          ..write('prestige: $prestige, ')
          ..write('seasonYear: $seasonYear, ')
          ..write('seasonMonth: $seasonMonth, ')
          ..write('gold: $gold, ')
          ..write('gems: $gems')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    displayName,
    totalXp,
    lifetimeXp,
    prestige,
    seasonYear,
    seasonMonth,
    gold,
    gems,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.displayName == this.displayName &&
          other.totalXp == this.totalXp &&
          other.lifetimeXp == this.lifetimeXp &&
          other.prestige == this.prestige &&
          other.seasonYear == this.seasonYear &&
          other.seasonMonth == this.seasonMonth &&
          other.gold == this.gold &&
          other.gems == this.gems);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<String> displayName;
  final Value<int> totalXp;
  final Value<int> lifetimeXp;
  final Value<int> prestige;
  final Value<int> seasonYear;
  final Value<int> seasonMonth;
  final Value<int> gold;
  final Value<int> gems;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.displayName = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.lifetimeXp = const Value.absent(),
    this.prestige = const Value.absent(),
    this.seasonYear = const Value.absent(),
    this.seasonMonth = const Value.absent(),
    this.gold = const Value.absent(),
    this.gems = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.displayName = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.lifetimeXp = const Value.absent(),
    this.prestige = const Value.absent(),
    this.seasonYear = const Value.absent(),
    this.seasonMonth = const Value.absent(),
    this.gold = const Value.absent(),
    this.gems = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Profile> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<String>? displayName,
    Expression<int>? totalXp,
    Expression<int>? lifetimeXp,
    Expression<int>? prestige,
    Expression<int>? seasonYear,
    Expression<int>? seasonMonth,
    Expression<int>? gold,
    Expression<int>? gems,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (displayName != null) 'display_name': displayName,
      if (totalXp != null) 'total_xp': totalXp,
      if (lifetimeXp != null) 'lifetime_xp': lifetimeXp,
      if (prestige != null) 'prestige': prestige,
      if (seasonYear != null) 'season_year': seasonYear,
      if (seasonMonth != null) 'season_month': seasonMonth,
      if (gold != null) 'gold': gold,
      if (gems != null) 'gems': gems,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<String>? displayName,
    Value<int>? totalXp,
    Value<int>? lifetimeXp,
    Value<int>? prestige,
    Value<int>? seasonYear,
    Value<int>? seasonMonth,
    Value<int>? gold,
    Value<int>? gems,
    Value<int>? rowid,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      displayName: displayName ?? this.displayName,
      totalXp: totalXp ?? this.totalXp,
      lifetimeXp: lifetimeXp ?? this.lifetimeXp,
      prestige: prestige ?? this.prestige,
      seasonYear: seasonYear ?? this.seasonYear,
      seasonMonth: seasonMonth ?? this.seasonMonth,
      gold: gold ?? this.gold,
      gems: gems ?? this.gems,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (totalXp.present) {
      map['total_xp'] = Variable<int>(totalXp.value);
    }
    if (lifetimeXp.present) {
      map['lifetime_xp'] = Variable<int>(lifetimeXp.value);
    }
    if (prestige.present) {
      map['prestige'] = Variable<int>(prestige.value);
    }
    if (seasonYear.present) {
      map['season_year'] = Variable<int>(seasonYear.value);
    }
    if (seasonMonth.present) {
      map['season_month'] = Variable<int>(seasonMonth.value);
    }
    if (gold.present) {
      map['gold'] = Variable<int>(gold.value);
    }
    if (gems.present) {
      map['gems'] = Variable<int>(gems.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('displayName: $displayName, ')
          ..write('totalXp: $totalXp, ')
          ..write('lifetimeXp: $lifetimeXp, ')
          ..write('prestige: $prestige, ')
          ..write('seasonYear: $seasonYear, ')
          ..write('seasonMonth: $seasonMonth, ')
          ..write('gold: $gold, ')
          ..write('gems: $gems, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CurrencyTransactionsTable extends CurrencyTransactions
    with TableInfo<$CurrencyTransactionsTable, CurrencyTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrencyTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CurrencyKind, int> kind =
      GeneratedColumn<int>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<CurrencyKind>($CurrencyTransactionsTable.$converterkind);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RewardReason, int> reason =
      GeneratedColumn<int>(
        'reason',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<RewardReason>(
        $CurrencyTransactionsTable.$converterreason,
      );
  static const VerificationMeta _refEntityMeta = const VerificationMeta(
    'refEntity',
  );
  @override
  late final GeneratedColumn<String> refEntity = GeneratedColumn<String>(
    'ref_entity',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    kind,
    amount,
    reason,
    refEntity,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'currency_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CurrencyTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('ref_entity')) {
      context.handle(
        _refEntityMeta,
        refEntity.isAcceptableOrUnknown(data['ref_entity']!, _refEntityMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CurrencyTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrencyTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      kind: $CurrencyTransactionsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}kind'],
        )!,
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      reason: $CurrencyTransactionsTable.$converterreason.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}reason'],
        )!,
      ),
      refEntity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ref_entity'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CurrencyTransactionsTable createAlias(String alias) {
    return $CurrencyTransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CurrencyKind, int, int> $converterkind =
      const EnumIndexConverter<CurrencyKind>(CurrencyKind.values);
  static JsonTypeConverter2<RewardReason, int, int> $converterreason =
      const EnumIndexConverter<RewardReason>(RewardReason.values);
}

class CurrencyTransaction extends DataClass
    implements Insertable<CurrencyTransaction> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final CurrencyKind kind;
  final int amount;
  final RewardReason reason;
  final String? refEntity;
  final DateTime createdAt;
  const CurrencyTransaction({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.kind,
    required this.amount,
    required this.reason,
    this.refEntity,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    {
      map['kind'] = Variable<int>(
        $CurrencyTransactionsTable.$converterkind.toSql(kind),
      );
    }
    map['amount'] = Variable<int>(amount);
    {
      map['reason'] = Variable<int>(
        $CurrencyTransactionsTable.$converterreason.toSql(reason),
      );
    }
    if (!nullToAbsent || refEntity != null) {
      map['ref_entity'] = Variable<String>(refEntity);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CurrencyTransactionsCompanion toCompanion(bool nullToAbsent) {
    return CurrencyTransactionsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      kind: Value(kind),
      amount: Value(amount),
      reason: Value(reason),
      refEntity: refEntity == null && nullToAbsent
          ? const Value.absent()
          : Value(refEntity),
      createdAt: Value(createdAt),
    );
  }

  factory CurrencyTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrencyTransaction(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      kind: $CurrencyTransactionsTable.$converterkind.fromJson(
        serializer.fromJson<int>(json['kind']),
      ),
      amount: serializer.fromJson<int>(json['amount']),
      reason: $CurrencyTransactionsTable.$converterreason.fromJson(
        serializer.fromJson<int>(json['reason']),
      ),
      refEntity: serializer.fromJson<String?>(json['refEntity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'kind': serializer.toJson<int>(
        $CurrencyTransactionsTable.$converterkind.toJson(kind),
      ),
      'amount': serializer.toJson<int>(amount),
      'reason': serializer.toJson<int>(
        $CurrencyTransactionsTable.$converterreason.toJson(reason),
      ),
      'refEntity': serializer.toJson<String?>(refEntity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CurrencyTransaction copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    CurrencyKind? kind,
    int? amount,
    RewardReason? reason,
    Value<String?> refEntity = const Value.absent(),
    DateTime? createdAt,
  }) => CurrencyTransaction(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    kind: kind ?? this.kind,
    amount: amount ?? this.amount,
    reason: reason ?? this.reason,
    refEntity: refEntity.present ? refEntity.value : this.refEntity,
    createdAt: createdAt ?? this.createdAt,
  );
  CurrencyTransaction copyWithCompanion(CurrencyTransactionsCompanion data) {
    return CurrencyTransaction(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      kind: data.kind.present ? data.kind.value : this.kind,
      amount: data.amount.present ? data.amount.value : this.amount,
      reason: data.reason.present ? data.reason.value : this.reason,
      refEntity: data.refEntity.present ? data.refEntity.value : this.refEntity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CurrencyTransaction(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('kind: $kind, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('refEntity: $refEntity, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    kind,
    amount,
    reason,
    refEntity,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrencyTransaction &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.kind == this.kind &&
          other.amount == this.amount &&
          other.reason == this.reason &&
          other.refEntity == this.refEntity &&
          other.createdAt == this.createdAt);
}

class CurrencyTransactionsCompanion
    extends UpdateCompanion<CurrencyTransaction> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<CurrencyKind> kind;
  final Value<int> amount;
  final Value<RewardReason> reason;
  final Value<String?> refEntity;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CurrencyTransactionsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.kind = const Value.absent(),
    this.amount = const Value.absent(),
    this.reason = const Value.absent(),
    this.refEntity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurrencyTransactionsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required CurrencyKind kind,
    required int amount,
    required RewardReason reason,
    this.refEntity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       kind = Value(kind),
       amount = Value(amount),
       reason = Value(reason);
  static Insertable<CurrencyTransaction> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<int>? kind,
    Expression<int>? amount,
    Expression<int>? reason,
    Expression<String>? refEntity,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (kind != null) 'kind': kind,
      if (amount != null) 'amount': amount,
      if (reason != null) 'reason': reason,
      if (refEntity != null) 'ref_entity': refEntity,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurrencyTransactionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<CurrencyKind>? kind,
    Value<int>? amount,
    Value<RewardReason>? reason,
    Value<String?>? refEntity,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CurrencyTransactionsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      kind: kind ?? this.kind,
      amount: amount ?? this.amount,
      reason: reason ?? this.reason,
      refEntity: refEntity ?? this.refEntity,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(
        $CurrencyTransactionsTable.$converterkind.toSql(kind.value),
      );
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (reason.present) {
      map['reason'] = Variable<int>(
        $CurrencyTransactionsTable.$converterreason.toSql(reason.value),
      );
    }
    if (refEntity.present) {
      map['ref_entity'] = Variable<String>(refEntity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrencyTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('kind: $kind, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('refEntity: $refEntity, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _axisIdMeta = const VerificationMeta('axisId');
  @override
  late final GeneratedColumn<String> axisId = GeneratedColumn<String>(
    'axis_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skill_axes (id)',
    ),
  );
  static const VerificationMeta _isBossMeta = const VerificationMeta('isBoss');
  @override
  late final GeneratedColumn<bool> isBoss = GeneratedColumn<bool>(
    'is_boss',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_boss" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hpTotalMeta = const VerificationMeta(
    'hpTotal',
  );
  @override
  late final GeneratedColumn<int> hpTotal = GeneratedColumn<int>(
    'hp_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hpRemainingMeta = const VerificationMeta(
    'hpRemaining',
  );
  @override
  late final GeneratedColumn<int> hpRemaining = GeneratedColumn<int>(
    'hp_remaining',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<GoalStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(GoalStatus.active.index),
      ).withConverter<GoalStatus>($GoalsTable.$converterstatus);
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    title,
    notes,
    axisId,
    isBoss,
    hpTotal,
    hpRemaining,
    status,
    completedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Goal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('axis_id')) {
      context.handle(
        _axisIdMeta,
        axisId.isAcceptableOrUnknown(data['axis_id']!, _axisIdMeta),
      );
    }
    if (data.containsKey('is_boss')) {
      context.handle(
        _isBossMeta,
        isBoss.isAcceptableOrUnknown(data['is_boss']!, _isBossMeta),
      );
    }
    if (data.containsKey('hp_total')) {
      context.handle(
        _hpTotalMeta,
        hpTotal.isAcceptableOrUnknown(data['hp_total']!, _hpTotalMeta),
      );
    }
    if (data.containsKey('hp_remaining')) {
      context.handle(
        _hpRemainingMeta,
        hpRemaining.isAcceptableOrUnknown(
          data['hp_remaining']!,
          _hpRemainingMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      axisId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}axis_id'],
      ),
      isBoss: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_boss'],
      )!,
      hpTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hp_total'],
      )!,
      hpRemaining: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hp_remaining'],
      )!,
      status: $GoalsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GoalStatus, int, int> $converterstatus =
      const EnumIndexConverter<GoalStatus>(GoalStatus.values);
}

class Goal extends DataClass implements Insertable<Goal> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final String title;
  final String? notes;
  final String? axisId;
  final bool isBoss;
  final int hpTotal;
  final int hpRemaining;
  final GoalStatus status;
  final DateTime? completedAt;
  final DateTime createdAt;
  const Goal({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.title,
    this.notes,
    this.axisId,
    required this.isBoss,
    required this.hpTotal,
    required this.hpRemaining,
    required this.status,
    this.completedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || axisId != null) {
      map['axis_id'] = Variable<String>(axisId);
    }
    map['is_boss'] = Variable<bool>(isBoss);
    map['hp_total'] = Variable<int>(hpTotal);
    map['hp_remaining'] = Variable<int>(hpRemaining);
    {
      map['status'] = Variable<int>($GoalsTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      title: Value(title),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      axisId: axisId == null && nullToAbsent
          ? const Value.absent()
          : Value(axisId),
      isBoss: Value(isBoss),
      hpTotal: Value(hpTotal),
      hpRemaining: Value(hpRemaining),
      status: Value(status),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
    );
  }

  factory Goal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String?>(json['notes']),
      axisId: serializer.fromJson<String?>(json['axisId']),
      isBoss: serializer.fromJson<bool>(json['isBoss']),
      hpTotal: serializer.fromJson<int>(json['hpTotal']),
      hpRemaining: serializer.fromJson<int>(json['hpRemaining']),
      status: $GoalsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String?>(notes),
      'axisId': serializer.toJson<String?>(axisId),
      'isBoss': serializer.toJson<bool>(isBoss),
      'hpTotal': serializer.toJson<int>(hpTotal),
      'hpRemaining': serializer.toJson<int>(hpRemaining),
      'status': serializer.toJson<int>(
        $GoalsTable.$converterstatus.toJson(status),
      ),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Goal copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    String? title,
    Value<String?> notes = const Value.absent(),
    Value<String?> axisId = const Value.absent(),
    bool? isBoss,
    int? hpTotal,
    int? hpRemaining,
    GoalStatus? status,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
  }) => Goal(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    title: title ?? this.title,
    notes: notes.present ? notes.value : this.notes,
    axisId: axisId.present ? axisId.value : this.axisId,
    isBoss: isBoss ?? this.isBoss,
    hpTotal: hpTotal ?? this.hpTotal,
    hpRemaining: hpRemaining ?? this.hpRemaining,
    status: status ?? this.status,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      axisId: data.axisId.present ? data.axisId.value : this.axisId,
      isBoss: data.isBoss.present ? data.isBoss.value : this.isBoss,
      hpTotal: data.hpTotal.present ? data.hpTotal.value : this.hpTotal,
      hpRemaining: data.hpRemaining.present
          ? data.hpRemaining.value
          : this.hpRemaining,
      status: data.status.present ? data.status.value : this.status,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('axisId: $axisId, ')
          ..write('isBoss: $isBoss, ')
          ..write('hpTotal: $hpTotal, ')
          ..write('hpRemaining: $hpRemaining, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    title,
    notes,
    axisId,
    isBoss,
    hpTotal,
    hpRemaining,
    status,
    completedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.axisId == this.axisId &&
          other.isBoss == this.isBoss &&
          other.hpTotal == this.hpTotal &&
          other.hpRemaining == this.hpRemaining &&
          other.status == this.status &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<String> title;
  final Value<String?> notes;
  final Value<String?> axisId;
  final Value<bool> isBoss;
  final Value<int> hpTotal;
  final Value<int> hpRemaining;
  final Value<GoalStatus> status;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.axisId = const Value.absent(),
    this.isBoss = const Value.absent(),
    this.hpTotal = const Value.absent(),
    this.hpRemaining = const Value.absent(),
    this.status = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String title,
    this.notes = const Value.absent(),
    this.axisId = const Value.absent(),
    this.isBoss = const Value.absent(),
    this.hpTotal = const Value.absent(),
    this.hpRemaining = const Value.absent(),
    this.status = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title);
  static Insertable<Goal> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<String>? axisId,
    Expression<bool>? isBoss,
    Expression<int>? hpTotal,
    Expression<int>? hpRemaining,
    Expression<int>? status,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (axisId != null) 'axis_id': axisId,
      if (isBoss != null) 'is_boss': isBoss,
      if (hpTotal != null) 'hp_total': hpTotal,
      if (hpRemaining != null) 'hp_remaining': hpRemaining,
      if (status != null) 'status': status,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<String>? title,
    Value<String?>? notes,
    Value<String?>? axisId,
    Value<bool>? isBoss,
    Value<int>? hpTotal,
    Value<int>? hpRemaining,
    Value<GoalStatus>? status,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      axisId: axisId ?? this.axisId,
      isBoss: isBoss ?? this.isBoss,
      hpTotal: hpTotal ?? this.hpTotal,
      hpRemaining: hpRemaining ?? this.hpRemaining,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (axisId.present) {
      map['axis_id'] = Variable<String>(axisId.value);
    }
    if (isBoss.present) {
      map['is_boss'] = Variable<bool>(isBoss.value);
    }
    if (hpTotal.present) {
      map['hp_total'] = Variable<int>(hpTotal.value);
    }
    if (hpRemaining.present) {
      map['hp_remaining'] = Variable<int>(hpRemaining.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $GoalsTable.$converterstatus.toSql(status.value),
      );
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('axisId: $axisId, ')
          ..write('isBoss: $isBoss, ')
          ..write('hpTotal: $hpTotal, ')
          ..write('hpRemaining: $hpRemaining, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalStepsTable extends GoalSteps
    with TableInfo<$GoalStepsTable, GoalStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Difficulty, int> difficulty =
      GeneratedColumn<int>(
        'difficulty',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(Difficulty.auto.index),
      ).withConverter<Difficulty>($GoalStepsTable.$converterdifficulty);
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(25),
  );
  static const VerificationMeta _expectedXpMeta = const VerificationMeta(
    'expectedXp',
  );
  @override
  late final GeneratedColumn<int> expectedXp = GeneratedColumn<int>(
    'expected_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TaskStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(TaskStatus.pending.index),
      ).withConverter<TaskStatus>($GoalStepsTable.$converterstatus);
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    goalId,
    title,
    difficulty,
    estimatedMinutes,
    expectedXp,
    status,
    completedAt,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalStep> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('expected_xp')) {
      context.handle(
        _expectedXpMeta,
        expectedXp.isAcceptableOrUnknown(data['expected_xp']!, _expectedXpMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalStep(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      difficulty: $GoalStepsTable.$converterdifficulty.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}difficulty'],
        )!,
      ),
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      )!,
      expectedXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_xp'],
      )!,
      status: $GoalStepsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GoalStepsTable createAlias(String alias) {
    return $GoalStepsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Difficulty, int, int> $converterdifficulty =
      const EnumIndexConverter<Difficulty>(Difficulty.values);
  static JsonTypeConverter2<TaskStatus, int, int> $converterstatus =
      const EnumIndexConverter<TaskStatus>(TaskStatus.values);
}

class GoalStep extends DataClass implements Insertable<GoalStep> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final String goalId;
  final String title;
  final Difficulty difficulty;
  final int estimatedMinutes;
  final int expectedXp;
  final TaskStatus status;
  final DateTime? completedAt;
  final int sortOrder;
  final DateTime createdAt;
  const GoalStep({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.goalId,
    required this.title,
    required this.difficulty,
    required this.estimatedMinutes,
    required this.expectedXp,
    required this.status,
    this.completedAt,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['goal_id'] = Variable<String>(goalId);
    map['title'] = Variable<String>(title);
    {
      map['difficulty'] = Variable<int>(
        $GoalStepsTable.$converterdifficulty.toSql(difficulty),
      );
    }
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    map['expected_xp'] = Variable<int>(expectedXp);
    {
      map['status'] = Variable<int>(
        $GoalStepsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GoalStepsCompanion toCompanion(bool nullToAbsent) {
    return GoalStepsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      goalId: Value(goalId),
      title: Value(title),
      difficulty: Value(difficulty),
      estimatedMinutes: Value(estimatedMinutes),
      expectedXp: Value(expectedXp),
      status: Value(status),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory GoalStep.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalStep(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      goalId: serializer.fromJson<String>(json['goalId']),
      title: serializer.fromJson<String>(json['title']),
      difficulty: $GoalStepsTable.$converterdifficulty.fromJson(
        serializer.fromJson<int>(json['difficulty']),
      ),
      estimatedMinutes: serializer.fromJson<int>(json['estimatedMinutes']),
      expectedXp: serializer.fromJson<int>(json['expectedXp']),
      status: $GoalStepsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'goalId': serializer.toJson<String>(goalId),
      'title': serializer.toJson<String>(title),
      'difficulty': serializer.toJson<int>(
        $GoalStepsTable.$converterdifficulty.toJson(difficulty),
      ),
      'estimatedMinutes': serializer.toJson<int>(estimatedMinutes),
      'expectedXp': serializer.toJson<int>(expectedXp),
      'status': serializer.toJson<int>(
        $GoalStepsTable.$converterstatus.toJson(status),
      ),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GoalStep copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    String? goalId,
    String? title,
    Difficulty? difficulty,
    int? estimatedMinutes,
    int? expectedXp,
    TaskStatus? status,
    Value<DateTime?> completedAt = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
  }) => GoalStep(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    goalId: goalId ?? this.goalId,
    title: title ?? this.title,
    difficulty: difficulty ?? this.difficulty,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    expectedXp: expectedXp ?? this.expectedXp,
    status: status ?? this.status,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  GoalStep copyWithCompanion(GoalStepsCompanion data) {
    return GoalStep(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      title: data.title.present ? data.title.value : this.title,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      estimatedMinutes: data.estimatedMinutes.present
          ? data.estimatedMinutes.value
          : this.estimatedMinutes,
      expectedXp: data.expectedXp.present
          ? data.expectedXp.value
          : this.expectedXp,
      status: data.status.present ? data.status.value : this.status,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalStep(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('goalId: $goalId, ')
          ..write('title: $title, ')
          ..write('difficulty: $difficulty, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('expectedXp: $expectedXp, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    goalId,
    title,
    difficulty,
    estimatedMinutes,
    expectedXp,
    status,
    completedAt,
    sortOrder,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalStep &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.goalId == this.goalId &&
          other.title == this.title &&
          other.difficulty == this.difficulty &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.expectedXp == this.expectedXp &&
          other.status == this.status &&
          other.completedAt == this.completedAt &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class GoalStepsCompanion extends UpdateCompanion<GoalStep> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<String> goalId;
  final Value<String> title;
  final Value<Difficulty> difficulty;
  final Value<int> estimatedMinutes;
  final Value<int> expectedXp;
  final Value<TaskStatus> status;
  final Value<DateTime?> completedAt;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GoalStepsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.goalId = const Value.absent(),
    this.title = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.expectedXp = const Value.absent(),
    this.status = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalStepsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String goalId,
    required String title,
    this.difficulty = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.expectedXp = const Value.absent(),
    this.status = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       goalId = Value(goalId),
       title = Value(title);
  static Insertable<GoalStep> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<String>? goalId,
    Expression<String>? title,
    Expression<int>? difficulty,
    Expression<int>? estimatedMinutes,
    Expression<int>? expectedXp,
    Expression<int>? status,
    Expression<DateTime>? completedAt,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (goalId != null) 'goal_id': goalId,
      if (title != null) 'title': title,
      if (difficulty != null) 'difficulty': difficulty,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (expectedXp != null) 'expected_xp': expectedXp,
      if (status != null) 'status': status,
      if (completedAt != null) 'completed_at': completedAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalStepsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<String>? goalId,
    Value<String>? title,
    Value<Difficulty>? difficulty,
    Value<int>? estimatedMinutes,
    Value<int>? expectedXp,
    Value<TaskStatus>? status,
    Value<DateTime?>? completedAt,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return GoalStepsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      goalId: goalId ?? this.goalId,
      title: title ?? this.title,
      difficulty: difficulty ?? this.difficulty,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      expectedXp: expectedXp ?? this.expectedXp,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(
        $GoalStepsTable.$converterdifficulty.toSql(difficulty.value),
      );
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (expectedXp.present) {
      map['expected_xp'] = Variable<int>(expectedXp.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $GoalStepsTable.$converterstatus.toSql(status.value),
      );
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalStepsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('goalId: $goalId, ')
          ..write('title: $title, ')
          ..write('difficulty: $difficulty, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('expectedXp: $expectedXp, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyQuestsTable extends DailyQuests
    with TableInfo<$DailyQuestsTable, DailyQuest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyQuestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _dateKeyMeta = const VerificationMeta(
    'dateKey',
  );
  @override
  late final GeneratedColumn<String> dateKey = GeneratedColumn<String>(
    'date_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<QuestType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<QuestType>($DailyQuestsTable.$convertertype);
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<int> target = GeneratedColumn<int>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardXpMeta = const VerificationMeta(
    'rewardXp',
  );
  @override
  late final GeneratedColumn<int> rewardXp = GeneratedColumn<int>(
    'reward_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardGoldMeta = const VerificationMeta(
    'rewardGold',
  );
  @override
  late final GeneratedColumn<int> rewardGold = GeneratedColumn<int>(
    'reward_gold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _claimedMeta = const VerificationMeta(
    'claimed',
  );
  @override
  late final GeneratedColumn<bool> claimed = GeneratedColumn<bool>(
    'claimed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("claimed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    dateKey,
    type,
    target,
    rewardXp,
    rewardGold,
    claimed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_quests';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyQuest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('date_key')) {
      context.handle(
        _dateKeyMeta,
        dateKey.isAcceptableOrUnknown(data['date_key']!, _dateKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dateKeyMeta);
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('reward_xp')) {
      context.handle(
        _rewardXpMeta,
        rewardXp.isAcceptableOrUnknown(data['reward_xp']!, _rewardXpMeta),
      );
    } else if (isInserting) {
      context.missing(_rewardXpMeta);
    }
    if (data.containsKey('reward_gold')) {
      context.handle(
        _rewardGoldMeta,
        rewardGold.isAcceptableOrUnknown(data['reward_gold']!, _rewardGoldMeta),
      );
    } else if (isInserting) {
      context.missing(_rewardGoldMeta);
    }
    if (data.containsKey('claimed')) {
      context.handle(
        _claimedMeta,
        claimed.isAcceptableOrUnknown(data['claimed']!, _claimedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyQuest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyQuest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      dateKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_key'],
      )!,
      type: $DailyQuestsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target'],
      )!,
      rewardXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reward_xp'],
      )!,
      rewardGold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reward_gold'],
      )!,
      claimed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}claimed'],
      )!,
    );
  }

  @override
  $DailyQuestsTable createAlias(String alias) {
    return $DailyQuestsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<QuestType, int, int> $convertertype =
      const EnumIndexConverter<QuestType>(QuestType.values);
}

class DailyQuest extends DataClass implements Insertable<DailyQuest> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final String dateKey;
  final QuestType type;
  final int target;
  final int rewardXp;
  final int rewardGold;
  final bool claimed;
  const DailyQuest({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.dateKey,
    required this.type,
    required this.target,
    required this.rewardXp,
    required this.rewardGold,
    required this.claimed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['date_key'] = Variable<String>(dateKey);
    {
      map['type'] = Variable<int>($DailyQuestsTable.$convertertype.toSql(type));
    }
    map['target'] = Variable<int>(target);
    map['reward_xp'] = Variable<int>(rewardXp);
    map['reward_gold'] = Variable<int>(rewardGold);
    map['claimed'] = Variable<bool>(claimed);
    return map;
  }

  DailyQuestsCompanion toCompanion(bool nullToAbsent) {
    return DailyQuestsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      dateKey: Value(dateKey),
      type: Value(type),
      target: Value(target),
      rewardXp: Value(rewardXp),
      rewardGold: Value(rewardGold),
      claimed: Value(claimed),
    );
  }

  factory DailyQuest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyQuest(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      dateKey: serializer.fromJson<String>(json['dateKey']),
      type: $DailyQuestsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      target: serializer.fromJson<int>(json['target']),
      rewardXp: serializer.fromJson<int>(json['rewardXp']),
      rewardGold: serializer.fromJson<int>(json['rewardGold']),
      claimed: serializer.fromJson<bool>(json['claimed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'dateKey': serializer.toJson<String>(dateKey),
      'type': serializer.toJson<int>(
        $DailyQuestsTable.$convertertype.toJson(type),
      ),
      'target': serializer.toJson<int>(target),
      'rewardXp': serializer.toJson<int>(rewardXp),
      'rewardGold': serializer.toJson<int>(rewardGold),
      'claimed': serializer.toJson<bool>(claimed),
    };
  }

  DailyQuest copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    String? dateKey,
    QuestType? type,
    int? target,
    int? rewardXp,
    int? rewardGold,
    bool? claimed,
  }) => DailyQuest(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    dateKey: dateKey ?? this.dateKey,
    type: type ?? this.type,
    target: target ?? this.target,
    rewardXp: rewardXp ?? this.rewardXp,
    rewardGold: rewardGold ?? this.rewardGold,
    claimed: claimed ?? this.claimed,
  );
  DailyQuest copyWithCompanion(DailyQuestsCompanion data) {
    return DailyQuest(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      dateKey: data.dateKey.present ? data.dateKey.value : this.dateKey,
      type: data.type.present ? data.type.value : this.type,
      target: data.target.present ? data.target.value : this.target,
      rewardXp: data.rewardXp.present ? data.rewardXp.value : this.rewardXp,
      rewardGold: data.rewardGold.present
          ? data.rewardGold.value
          : this.rewardGold,
      claimed: data.claimed.present ? data.claimed.value : this.claimed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyQuest(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('dateKey: $dateKey, ')
          ..write('type: $type, ')
          ..write('target: $target, ')
          ..write('rewardXp: $rewardXp, ')
          ..write('rewardGold: $rewardGold, ')
          ..write('claimed: $claimed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    dateKey,
    type,
    target,
    rewardXp,
    rewardGold,
    claimed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyQuest &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.dateKey == this.dateKey &&
          other.type == this.type &&
          other.target == this.target &&
          other.rewardXp == this.rewardXp &&
          other.rewardGold == this.rewardGold &&
          other.claimed == this.claimed);
}

class DailyQuestsCompanion extends UpdateCompanion<DailyQuest> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<String> dateKey;
  final Value<QuestType> type;
  final Value<int> target;
  final Value<int> rewardXp;
  final Value<int> rewardGold;
  final Value<bool> claimed;
  final Value<int> rowid;
  const DailyQuestsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.dateKey = const Value.absent(),
    this.type = const Value.absent(),
    this.target = const Value.absent(),
    this.rewardXp = const Value.absent(),
    this.rewardGold = const Value.absent(),
    this.claimed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyQuestsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String dateKey,
    required QuestType type,
    required int target,
    required int rewardXp,
    required int rewardGold,
    this.claimed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       dateKey = Value(dateKey),
       type = Value(type),
       target = Value(target),
       rewardXp = Value(rewardXp),
       rewardGold = Value(rewardGold);
  static Insertable<DailyQuest> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<String>? dateKey,
    Expression<int>? type,
    Expression<int>? target,
    Expression<int>? rewardXp,
    Expression<int>? rewardGold,
    Expression<bool>? claimed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (dateKey != null) 'date_key': dateKey,
      if (type != null) 'type': type,
      if (target != null) 'target': target,
      if (rewardXp != null) 'reward_xp': rewardXp,
      if (rewardGold != null) 'reward_gold': rewardGold,
      if (claimed != null) 'claimed': claimed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyQuestsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<String>? dateKey,
    Value<QuestType>? type,
    Value<int>? target,
    Value<int>? rewardXp,
    Value<int>? rewardGold,
    Value<bool>? claimed,
    Value<int>? rowid,
  }) {
    return DailyQuestsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      dateKey: dateKey ?? this.dateKey,
      type: type ?? this.type,
      target: target ?? this.target,
      rewardXp: rewardXp ?? this.rewardXp,
      rewardGold: rewardGold ?? this.rewardGold,
      claimed: claimed ?? this.claimed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (dateKey.present) {
      map['date_key'] = Variable<String>(dateKey.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $DailyQuestsTable.$convertertype.toSql(type.value),
      );
    }
    if (target.present) {
      map['target'] = Variable<int>(target.value);
    }
    if (rewardXp.present) {
      map['reward_xp'] = Variable<int>(rewardXp.value);
    }
    if (rewardGold.present) {
      map['reward_gold'] = Variable<int>(rewardGold.value);
    }
    if (claimed.present) {
      map['claimed'] = Variable<bool>(claimed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyQuestsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('dateKey: $dateKey, ')
          ..write('type: $type, ')
          ..write('target: $target, ')
          ..write('rewardXp: $rewardXp, ')
          ..write('rewardGold: $rewardGold, ')
          ..write('claimed: $claimed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserAchievementsTable extends UserAchievements
    with TableInfo<$UserAchievementsTable, UserAchievement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAchievementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    unlockedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserAchievement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserAchievement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAchievement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      )!,
    );
  }

  @override
  $UserAchievementsTable createAlias(String alias) {
    return $UserAchievementsTable(attachedDatabase, alias);
  }
}

class UserAchievement extends DataClass implements Insertable<UserAchievement> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final DateTime unlockedAt;
  const UserAchievement({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.unlockedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    return map;
  }

  UserAchievementsCompanion toCompanion(bool nullToAbsent) {
    return UserAchievementsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      unlockedAt: Value(unlockedAt),
    );
  }

  factory UserAchievement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAchievement(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      unlockedAt: serializer.fromJson<DateTime>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'unlockedAt': serializer.toJson<DateTime>(unlockedAt),
    };
  }

  UserAchievement copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    DateTime? unlockedAt,
  }) => UserAchievement(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    unlockedAt: unlockedAt ?? this.unlockedAt,
  );
  UserAchievement copyWithCompanion(UserAchievementsCompanion data) {
    return UserAchievement(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserAchievement(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, updatedAt, isDeleted, dirty, unlockedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAchievement &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.unlockedAt == this.unlockedAt);
}

class UserAchievementsCompanion extends UpdateCompanion<UserAchievement> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<DateTime> unlockedAt;
  final Value<int> rowid;
  const UserAchievementsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserAchievementsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<UserAchievement> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<DateTime>? unlockedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserAchievementsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<DateTime>? unlockedAt,
    Value<int>? rowid,
  }) {
    return UserAchievementsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAchievementsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryItemsTable extends InventoryItems
    with TableInfo<$InventoryItemsTable, InventoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _acquiredAtMeta = const VerificationMeta(
    'acquiredAt',
  );
  @override
  late final GeneratedColumn<DateTime> acquiredAt = GeneratedColumn<DateTime>(
    'acquired_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _equippedMeta = const VerificationMeta(
    'equipped',
  );
  @override
  late final GeneratedColumn<bool> equipped = GeneratedColumn<bool>(
    'equipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("equipped" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    acquiredAt,
    equipped,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('acquired_at')) {
      context.handle(
        _acquiredAtMeta,
        acquiredAt.isAcceptableOrUnknown(data['acquired_at']!, _acquiredAtMeta),
      );
    }
    if (data.containsKey('equipped')) {
      context.handle(
        _equippedMeta,
        equipped.isAcceptableOrUnknown(data['equipped']!, _equippedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      acquiredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}acquired_at'],
      )!,
      equipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}equipped'],
      )!,
    );
  }

  @override
  $InventoryItemsTable createAlias(String alias) {
    return $InventoryItemsTable(attachedDatabase, alias);
  }
}

class InventoryItem extends DataClass implements Insertable<InventoryItem> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final DateTime acquiredAt;
  final bool equipped;
  const InventoryItem({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.acquiredAt,
    required this.equipped,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['acquired_at'] = Variable<DateTime>(acquiredAt);
    map['equipped'] = Variable<bool>(equipped);
    return map;
  }

  InventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      acquiredAt: Value(acquiredAt),
      equipped: Value(equipped),
    );
  }

  factory InventoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItem(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      acquiredAt: serializer.fromJson<DateTime>(json['acquiredAt']),
      equipped: serializer.fromJson<bool>(json['equipped']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'acquiredAt': serializer.toJson<DateTime>(acquiredAt),
      'equipped': serializer.toJson<bool>(equipped),
    };
  }

  InventoryItem copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    DateTime? acquiredAt,
    bool? equipped,
  }) => InventoryItem(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    acquiredAt: acquiredAt ?? this.acquiredAt,
    equipped: equipped ?? this.equipped,
  );
  InventoryItem copyWithCompanion(InventoryItemsCompanion data) {
    return InventoryItem(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      acquiredAt: data.acquiredAt.present
          ? data.acquiredAt.value
          : this.acquiredAt,
      equipped: data.equipped.present ? data.equipped.value : this.equipped,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItem(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('acquiredAt: $acquiredAt, ')
          ..write('equipped: $equipped')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, updatedAt, isDeleted, dirty, acquiredAt, equipped);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItem &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.acquiredAt == this.acquiredAt &&
          other.equipped == this.equipped);
}

class InventoryItemsCompanion extends UpdateCompanion<InventoryItem> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<DateTime> acquiredAt;
  final Value<bool> equipped;
  final Value<int> rowid;
  const InventoryItemsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.acquiredAt = const Value.absent(),
    this.equipped = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryItemsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.acquiredAt = const Value.absent(),
    this.equipped = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<InventoryItem> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<DateTime>? acquiredAt,
    Expression<bool>? equipped,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (acquiredAt != null) 'acquired_at': acquiredAt,
      if (equipped != null) 'equipped': equipped,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryItemsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<DateTime>? acquiredAt,
    Value<bool>? equipped,
    Value<int>? rowid,
  }) {
    return InventoryItemsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      acquiredAt: acquiredAt ?? this.acquiredAt,
      equipped: equipped ?? this.equipped,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (acquiredAt.present) {
      map['acquired_at'] = Variable<DateTime>(acquiredAt.value);
    }
    if (equipped.present) {
      map['equipped'] = Variable<bool>(equipped.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('acquiredAt: $acquiredAt, ')
          ..write('equipped: $equipped, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SleepLogsTable extends SleepLogs
    with TableInfo<$SleepLogsTable, SleepLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _dateKeyMeta = const VerificationMeta(
    'dateKey',
  );
  @override
  late final GeneratedColumn<String> dateKey = GeneratedColumn<String>(
    'date_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bedTimeMeta = const VerificationMeta(
    'bedTime',
  );
  @override
  late final GeneratedColumn<DateTime> bedTime = GeneratedColumn<DateTime>(
    'bed_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wakeTimeMeta = const VerificationMeta(
    'wakeTime',
  );
  @override
  late final GeneratedColumn<DateTime> wakeTime = GeneratedColumn<DateTime>(
    'wake_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _xpAwardedMeta = const VerificationMeta(
    'xpAwarded',
  );
  @override
  late final GeneratedColumn<int> xpAwarded = GeneratedColumn<int>(
    'xp_awarded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    dateKey,
    bedTime,
    wakeTime,
    note,
    xpAwarded,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('date_key')) {
      context.handle(
        _dateKeyMeta,
        dateKey.isAcceptableOrUnknown(data['date_key']!, _dateKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dateKeyMeta);
    }
    if (data.containsKey('bed_time')) {
      context.handle(
        _bedTimeMeta,
        bedTime.isAcceptableOrUnknown(data['bed_time']!, _bedTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_bedTimeMeta);
    }
    if (data.containsKey('wake_time')) {
      context.handle(
        _wakeTimeMeta,
        wakeTime.isAcceptableOrUnknown(data['wake_time']!, _wakeTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_wakeTimeMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('xp_awarded')) {
      context.handle(
        _xpAwardedMeta,
        xpAwarded.isAcceptableOrUnknown(data['xp_awarded']!, _xpAwardedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      dateKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_key'],
      )!,
      bedTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}bed_time'],
      )!,
      wakeTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}wake_time'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      xpAwarded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_awarded'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SleepLogsTable createAlias(String alias) {
    return $SleepLogsTable(attachedDatabase, alias);
  }
}

class SleepLog extends DataClass implements Insertable<SleepLog> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final String dateKey;
  final DateTime bedTime;
  final DateTime wakeTime;
  final String? note;
  final int xpAwarded;
  final DateTime createdAt;
  const SleepLog({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.dateKey,
    required this.bedTime,
    required this.wakeTime,
    this.note,
    required this.xpAwarded,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['date_key'] = Variable<String>(dateKey);
    map['bed_time'] = Variable<DateTime>(bedTime);
    map['wake_time'] = Variable<DateTime>(wakeTime);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['xp_awarded'] = Variable<int>(xpAwarded);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SleepLogsCompanion toCompanion(bool nullToAbsent) {
    return SleepLogsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      dateKey: Value(dateKey),
      bedTime: Value(bedTime),
      wakeTime: Value(wakeTime),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      xpAwarded: Value(xpAwarded),
      createdAt: Value(createdAt),
    );
  }

  factory SleepLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepLog(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      dateKey: serializer.fromJson<String>(json['dateKey']),
      bedTime: serializer.fromJson<DateTime>(json['bedTime']),
      wakeTime: serializer.fromJson<DateTime>(json['wakeTime']),
      note: serializer.fromJson<String?>(json['note']),
      xpAwarded: serializer.fromJson<int>(json['xpAwarded']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'dateKey': serializer.toJson<String>(dateKey),
      'bedTime': serializer.toJson<DateTime>(bedTime),
      'wakeTime': serializer.toJson<DateTime>(wakeTime),
      'note': serializer.toJson<String?>(note),
      'xpAwarded': serializer.toJson<int>(xpAwarded),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SleepLog copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    String? dateKey,
    DateTime? bedTime,
    DateTime? wakeTime,
    Value<String?> note = const Value.absent(),
    int? xpAwarded,
    DateTime? createdAt,
  }) => SleepLog(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    dateKey: dateKey ?? this.dateKey,
    bedTime: bedTime ?? this.bedTime,
    wakeTime: wakeTime ?? this.wakeTime,
    note: note.present ? note.value : this.note,
    xpAwarded: xpAwarded ?? this.xpAwarded,
    createdAt: createdAt ?? this.createdAt,
  );
  SleepLog copyWithCompanion(SleepLogsCompanion data) {
    return SleepLog(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      dateKey: data.dateKey.present ? data.dateKey.value : this.dateKey,
      bedTime: data.bedTime.present ? data.bedTime.value : this.bedTime,
      wakeTime: data.wakeTime.present ? data.wakeTime.value : this.wakeTime,
      note: data.note.present ? data.note.value : this.note,
      xpAwarded: data.xpAwarded.present ? data.xpAwarded.value : this.xpAwarded,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepLog(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('dateKey: $dateKey, ')
          ..write('bedTime: $bedTime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('note: $note, ')
          ..write('xpAwarded: $xpAwarded, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    dateKey,
    bedTime,
    wakeTime,
    note,
    xpAwarded,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepLog &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.dateKey == this.dateKey &&
          other.bedTime == this.bedTime &&
          other.wakeTime == this.wakeTime &&
          other.note == this.note &&
          other.xpAwarded == this.xpAwarded &&
          other.createdAt == this.createdAt);
}

class SleepLogsCompanion extends UpdateCompanion<SleepLog> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<String> dateKey;
  final Value<DateTime> bedTime;
  final Value<DateTime> wakeTime;
  final Value<String?> note;
  final Value<int> xpAwarded;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SleepLogsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.dateKey = const Value.absent(),
    this.bedTime = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.note = const Value.absent(),
    this.xpAwarded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepLogsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String dateKey,
    required DateTime bedTime,
    required DateTime wakeTime,
    this.note = const Value.absent(),
    this.xpAwarded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       dateKey = Value(dateKey),
       bedTime = Value(bedTime),
       wakeTime = Value(wakeTime);
  static Insertable<SleepLog> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<String>? dateKey,
    Expression<DateTime>? bedTime,
    Expression<DateTime>? wakeTime,
    Expression<String>? note,
    Expression<int>? xpAwarded,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (dateKey != null) 'date_key': dateKey,
      if (bedTime != null) 'bed_time': bedTime,
      if (wakeTime != null) 'wake_time': wakeTime,
      if (note != null) 'note': note,
      if (xpAwarded != null) 'xp_awarded': xpAwarded,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepLogsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<String>? dateKey,
    Value<DateTime>? bedTime,
    Value<DateTime>? wakeTime,
    Value<String?>? note,
    Value<int>? xpAwarded,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SleepLogsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      dateKey: dateKey ?? this.dateKey,
      bedTime: bedTime ?? this.bedTime,
      wakeTime: wakeTime ?? this.wakeTime,
      note: note ?? this.note,
      xpAwarded: xpAwarded ?? this.xpAwarded,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (dateKey.present) {
      map['date_key'] = Variable<String>(dateKey.value);
    }
    if (bedTime.present) {
      map['bed_time'] = Variable<DateTime>(bedTime.value);
    }
    if (wakeTime.present) {
      map['wake_time'] = Variable<DateTime>(wakeTime.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (xpAwarded.present) {
      map['xp_awarded'] = Variable<int>(xpAwarded.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepLogsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('dateKey: $dateKey, ')
          ..write('bedTime: $bedTime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('note: $note, ')
          ..write('xpAwarded: $xpAwarded, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CodexEntriesTable extends CodexEntries
    with TableInfo<$CodexEntriesTable, CodexEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CodexEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _discoveredAtMeta = const VerificationMeta(
    'discoveredAt',
  );
  @override
  late final GeneratedColumn<DateTime> discoveredAt = GeneratedColumn<DateTime>(
    'discovered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    discoveredAt,
    isFavorite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'codex_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CodexEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('discovered_at')) {
      context.handle(
        _discoveredAtMeta,
        discoveredAt.isAcceptableOrUnknown(
          data['discovered_at']!,
          _discoveredAtMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CodexEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CodexEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      discoveredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}discovered_at'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
    );
  }

  @override
  $CodexEntriesTable createAlias(String alias) {
    return $CodexEntriesTable(attachedDatabase, alias);
  }
}

class CodexEntry extends DataClass implements Insertable<CodexEntry> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final DateTime discoveredAt;
  final bool isFavorite;
  const CodexEntry({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.discoveredAt,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['discovered_at'] = Variable<DateTime>(discoveredAt);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  CodexEntriesCompanion toCompanion(bool nullToAbsent) {
    return CodexEntriesCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      discoveredAt: Value(discoveredAt),
      isFavorite: Value(isFavorite),
    );
  }

  factory CodexEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CodexEntry(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      discoveredAt: serializer.fromJson<DateTime>(json['discoveredAt']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'discoveredAt': serializer.toJson<DateTime>(discoveredAt),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  CodexEntry copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    DateTime? discoveredAt,
    bool? isFavorite,
  }) => CodexEntry(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    discoveredAt: discoveredAt ?? this.discoveredAt,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  CodexEntry copyWithCompanion(CodexEntriesCompanion data) {
    return CodexEntry(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      discoveredAt: data.discoveredAt.present
          ? data.discoveredAt.value
          : this.discoveredAt,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CodexEntry(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('discoveredAt: $discoveredAt, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, updatedAt, isDeleted, dirty, discoveredAt, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CodexEntry &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.discoveredAt == this.discoveredAt &&
          other.isFavorite == this.isFavorite);
}

class CodexEntriesCompanion extends UpdateCompanion<CodexEntry> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<DateTime> discoveredAt;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const CodexEntriesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.discoveredAt = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CodexEntriesCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.discoveredAt = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<CodexEntry> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<DateTime>? discoveredAt,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (discoveredAt != null) 'discovered_at': discoveredAt,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CodexEntriesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<DateTime>? discoveredAt,
    Value<bool>? isFavorite,
    Value<int>? rowid,
  }) {
    return CodexEntriesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      discoveredAt: discoveredAt ?? this.discoveredAt,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (discoveredAt.present) {
      map['discovered_at'] = Variable<DateTime>(discoveredAt.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CodexEntriesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('discoveredAt: $discoveredAt, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StatSnapshotsTable extends StatSnapshots
    with TableInfo<$StatSnapshotsTable, StatSnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _dateKeyMeta = const VerificationMeta(
    'dateKey',
  );
  @override
  late final GeneratedColumn<String> dateKey = GeneratedColumn<String>(
    'date_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalXpMeta = const VerificationMeta(
    'totalXp',
  );
  @override
  late final GeneratedColumn<int> totalXp = GeneratedColumn<int>(
    'total_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lifetimeXpMeta = const VerificationMeta(
    'lifetimeXp',
  );
  @override
  late final GeneratedColumn<int> lifetimeXp = GeneratedColumn<int>(
    'lifetime_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _goldMeta = const VerificationMeta('gold');
  @override
  late final GeneratedColumn<int> gold = GeneratedColumn<int>(
    'gold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _gemsMeta = const VerificationMeta('gems');
  @override
  late final GeneratedColumn<int> gems = GeneratedColumn<int>(
    'gems',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tasksDoneMeta = const VerificationMeta(
    'tasksDone',
  );
  @override
  late final GeneratedColumn<int> tasksDone = GeneratedColumn<int>(
    'tasks_done',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _habitsLoggedMeta = const VerificationMeta(
    'habitsLogged',
  );
  @override
  late final GeneratedColumn<int> habitsLogged = GeneratedColumn<int>(
    'habits_logged',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _focusSessionsMeta = const VerificationMeta(
    'focusSessions',
  );
  @override
  late final GeneratedColumn<int> focusSessions = GeneratedColumn<int>(
    'focus_sessions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    dateKey,
    totalXp,
    lifetimeXp,
    level,
    gold,
    gems,
    tasksDone,
    habitsLogged,
    focusSessions,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stat_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<StatSnapshot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('date_key')) {
      context.handle(
        _dateKeyMeta,
        dateKey.isAcceptableOrUnknown(data['date_key']!, _dateKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dateKeyMeta);
    }
    if (data.containsKey('total_xp')) {
      context.handle(
        _totalXpMeta,
        totalXp.isAcceptableOrUnknown(data['total_xp']!, _totalXpMeta),
      );
    }
    if (data.containsKey('lifetime_xp')) {
      context.handle(
        _lifetimeXpMeta,
        lifetimeXp.isAcceptableOrUnknown(data['lifetime_xp']!, _lifetimeXpMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('gold')) {
      context.handle(
        _goldMeta,
        gold.isAcceptableOrUnknown(data['gold']!, _goldMeta),
      );
    }
    if (data.containsKey('gems')) {
      context.handle(
        _gemsMeta,
        gems.isAcceptableOrUnknown(data['gems']!, _gemsMeta),
      );
    }
    if (data.containsKey('tasks_done')) {
      context.handle(
        _tasksDoneMeta,
        tasksDone.isAcceptableOrUnknown(data['tasks_done']!, _tasksDoneMeta),
      );
    }
    if (data.containsKey('habits_logged')) {
      context.handle(
        _habitsLoggedMeta,
        habitsLogged.isAcceptableOrUnknown(
          data['habits_logged']!,
          _habitsLoggedMeta,
        ),
      );
    }
    if (data.containsKey('focus_sessions')) {
      context.handle(
        _focusSessionsMeta,
        focusSessions.isAcceptableOrUnknown(
          data['focus_sessions']!,
          _focusSessionsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StatSnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StatSnapshot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      dateKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_key'],
      )!,
      totalXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_xp'],
      )!,
      lifetimeXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lifetime_xp'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      gold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gold'],
      )!,
      gems: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gems'],
      )!,
      tasksDone: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tasks_done'],
      )!,
      habitsLogged: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habits_logged'],
      )!,
      focusSessions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}focus_sessions'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StatSnapshotsTable createAlias(String alias) {
    return $StatSnapshotsTable(attachedDatabase, alias);
  }
}

class StatSnapshot extends DataClass implements Insertable<StatSnapshot> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final String dateKey;
  final int totalXp;
  final int lifetimeXp;
  final int level;
  final int gold;
  final int gems;
  final int tasksDone;
  final int habitsLogged;
  final int focusSessions;
  final DateTime createdAt;
  const StatSnapshot({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.dateKey,
    required this.totalXp,
    required this.lifetimeXp,
    required this.level,
    required this.gold,
    required this.gems,
    required this.tasksDone,
    required this.habitsLogged,
    required this.focusSessions,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['date_key'] = Variable<String>(dateKey);
    map['total_xp'] = Variable<int>(totalXp);
    map['lifetime_xp'] = Variable<int>(lifetimeXp);
    map['level'] = Variable<int>(level);
    map['gold'] = Variable<int>(gold);
    map['gems'] = Variable<int>(gems);
    map['tasks_done'] = Variable<int>(tasksDone);
    map['habits_logged'] = Variable<int>(habitsLogged);
    map['focus_sessions'] = Variable<int>(focusSessions);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StatSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return StatSnapshotsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      dateKey: Value(dateKey),
      totalXp: Value(totalXp),
      lifetimeXp: Value(lifetimeXp),
      level: Value(level),
      gold: Value(gold),
      gems: Value(gems),
      tasksDone: Value(tasksDone),
      habitsLogged: Value(habitsLogged),
      focusSessions: Value(focusSessions),
      createdAt: Value(createdAt),
    );
  }

  factory StatSnapshot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StatSnapshot(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      dateKey: serializer.fromJson<String>(json['dateKey']),
      totalXp: serializer.fromJson<int>(json['totalXp']),
      lifetimeXp: serializer.fromJson<int>(json['lifetimeXp']),
      level: serializer.fromJson<int>(json['level']),
      gold: serializer.fromJson<int>(json['gold']),
      gems: serializer.fromJson<int>(json['gems']),
      tasksDone: serializer.fromJson<int>(json['tasksDone']),
      habitsLogged: serializer.fromJson<int>(json['habitsLogged']),
      focusSessions: serializer.fromJson<int>(json['focusSessions']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'dateKey': serializer.toJson<String>(dateKey),
      'totalXp': serializer.toJson<int>(totalXp),
      'lifetimeXp': serializer.toJson<int>(lifetimeXp),
      'level': serializer.toJson<int>(level),
      'gold': serializer.toJson<int>(gold),
      'gems': serializer.toJson<int>(gems),
      'tasksDone': serializer.toJson<int>(tasksDone),
      'habitsLogged': serializer.toJson<int>(habitsLogged),
      'focusSessions': serializer.toJson<int>(focusSessions),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StatSnapshot copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    String? dateKey,
    int? totalXp,
    int? lifetimeXp,
    int? level,
    int? gold,
    int? gems,
    int? tasksDone,
    int? habitsLogged,
    int? focusSessions,
    DateTime? createdAt,
  }) => StatSnapshot(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    dateKey: dateKey ?? this.dateKey,
    totalXp: totalXp ?? this.totalXp,
    lifetimeXp: lifetimeXp ?? this.lifetimeXp,
    level: level ?? this.level,
    gold: gold ?? this.gold,
    gems: gems ?? this.gems,
    tasksDone: tasksDone ?? this.tasksDone,
    habitsLogged: habitsLogged ?? this.habitsLogged,
    focusSessions: focusSessions ?? this.focusSessions,
    createdAt: createdAt ?? this.createdAt,
  );
  StatSnapshot copyWithCompanion(StatSnapshotsCompanion data) {
    return StatSnapshot(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      dateKey: data.dateKey.present ? data.dateKey.value : this.dateKey,
      totalXp: data.totalXp.present ? data.totalXp.value : this.totalXp,
      lifetimeXp: data.lifetimeXp.present
          ? data.lifetimeXp.value
          : this.lifetimeXp,
      level: data.level.present ? data.level.value : this.level,
      gold: data.gold.present ? data.gold.value : this.gold,
      gems: data.gems.present ? data.gems.value : this.gems,
      tasksDone: data.tasksDone.present ? data.tasksDone.value : this.tasksDone,
      habitsLogged: data.habitsLogged.present
          ? data.habitsLogged.value
          : this.habitsLogged,
      focusSessions: data.focusSessions.present
          ? data.focusSessions.value
          : this.focusSessions,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StatSnapshot(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('dateKey: $dateKey, ')
          ..write('totalXp: $totalXp, ')
          ..write('lifetimeXp: $lifetimeXp, ')
          ..write('level: $level, ')
          ..write('gold: $gold, ')
          ..write('gems: $gems, ')
          ..write('tasksDone: $tasksDone, ')
          ..write('habitsLogged: $habitsLogged, ')
          ..write('focusSessions: $focusSessions, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    dateKey,
    totalXp,
    lifetimeXp,
    level,
    gold,
    gems,
    tasksDone,
    habitsLogged,
    focusSessions,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StatSnapshot &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.dateKey == this.dateKey &&
          other.totalXp == this.totalXp &&
          other.lifetimeXp == this.lifetimeXp &&
          other.level == this.level &&
          other.gold == this.gold &&
          other.gems == this.gems &&
          other.tasksDone == this.tasksDone &&
          other.habitsLogged == this.habitsLogged &&
          other.focusSessions == this.focusSessions &&
          other.createdAt == this.createdAt);
}

class StatSnapshotsCompanion extends UpdateCompanion<StatSnapshot> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<String> dateKey;
  final Value<int> totalXp;
  final Value<int> lifetimeXp;
  final Value<int> level;
  final Value<int> gold;
  final Value<int> gems;
  final Value<int> tasksDone;
  final Value<int> habitsLogged;
  final Value<int> focusSessions;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const StatSnapshotsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.dateKey = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.lifetimeXp = const Value.absent(),
    this.level = const Value.absent(),
    this.gold = const Value.absent(),
    this.gems = const Value.absent(),
    this.tasksDone = const Value.absent(),
    this.habitsLogged = const Value.absent(),
    this.focusSessions = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StatSnapshotsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String dateKey,
    this.totalXp = const Value.absent(),
    this.lifetimeXp = const Value.absent(),
    this.level = const Value.absent(),
    this.gold = const Value.absent(),
    this.gems = const Value.absent(),
    this.tasksDone = const Value.absent(),
    this.habitsLogged = const Value.absent(),
    this.focusSessions = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       dateKey = Value(dateKey);
  static Insertable<StatSnapshot> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<String>? dateKey,
    Expression<int>? totalXp,
    Expression<int>? lifetimeXp,
    Expression<int>? level,
    Expression<int>? gold,
    Expression<int>? gems,
    Expression<int>? tasksDone,
    Expression<int>? habitsLogged,
    Expression<int>? focusSessions,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (dateKey != null) 'date_key': dateKey,
      if (totalXp != null) 'total_xp': totalXp,
      if (lifetimeXp != null) 'lifetime_xp': lifetimeXp,
      if (level != null) 'level': level,
      if (gold != null) 'gold': gold,
      if (gems != null) 'gems': gems,
      if (tasksDone != null) 'tasks_done': tasksDone,
      if (habitsLogged != null) 'habits_logged': habitsLogged,
      if (focusSessions != null) 'focus_sessions': focusSessions,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StatSnapshotsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<String>? dateKey,
    Value<int>? totalXp,
    Value<int>? lifetimeXp,
    Value<int>? level,
    Value<int>? gold,
    Value<int>? gems,
    Value<int>? tasksDone,
    Value<int>? habitsLogged,
    Value<int>? focusSessions,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return StatSnapshotsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      dateKey: dateKey ?? this.dateKey,
      totalXp: totalXp ?? this.totalXp,
      lifetimeXp: lifetimeXp ?? this.lifetimeXp,
      level: level ?? this.level,
      gold: gold ?? this.gold,
      gems: gems ?? this.gems,
      tasksDone: tasksDone ?? this.tasksDone,
      habitsLogged: habitsLogged ?? this.habitsLogged,
      focusSessions: focusSessions ?? this.focusSessions,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (dateKey.present) {
      map['date_key'] = Variable<String>(dateKey.value);
    }
    if (totalXp.present) {
      map['total_xp'] = Variable<int>(totalXp.value);
    }
    if (lifetimeXp.present) {
      map['lifetime_xp'] = Variable<int>(lifetimeXp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (gold.present) {
      map['gold'] = Variable<int>(gold.value);
    }
    if (gems.present) {
      map['gems'] = Variable<int>(gems.value);
    }
    if (tasksDone.present) {
      map['tasks_done'] = Variable<int>(tasksDone.value);
    }
    if (habitsLogged.present) {
      map['habits_logged'] = Variable<int>(habitsLogged.value);
    }
    if (focusSessions.present) {
      map['focus_sessions'] = Variable<int>(focusSessions.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('dateKey: $dateKey, ')
          ..write('totalXp: $totalXp, ')
          ..write('lifetimeXp: $lifetimeXp, ')
          ..write('level: $level, ')
          ..write('gold: $gold, ')
          ..write('gems: $gems, ')
          ..write('tasksDone: $tasksDone, ')
          ..write('habitsLogged: $habitsLogged, ')
          ..write('focusSessions: $focusSessions, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SeasonsTable extends Seasons with TableInfo<$SeasonsTable, Season> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeasonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpEarnedMeta = const VerificationMeta(
    'xpEarned',
  );
  @override
  late final GeneratedColumn<int> xpEarned = GeneratedColumn<int>(
    'xp_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<String> rank = GeneratedColumn<String>(
    'rank',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _tasksCompletedMeta = const VerificationMeta(
    'tasksCompleted',
  );
  @override
  late final GeneratedColumn<int> tasksCompleted = GeneratedColumn<int>(
    'tasks_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _habitsCompletedMeta = const VerificationMeta(
    'habitsCompleted',
  );
  @override
  late final GeneratedColumn<int> habitsCompleted = GeneratedColumn<int>(
    'habits_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _bestStreakMeta = const VerificationMeta(
    'bestStreak',
  );
  @override
  late final GeneratedColumn<int> bestStreak = GeneratedColumn<int>(
    'best_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _topAxisNameMeta = const VerificationMeta(
    'topAxisName',
  );
  @override
  late final GeneratedColumn<String> topAxisName = GeneratedColumn<String>(
    'top_axis_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gemsAwardedMeta = const VerificationMeta(
    'gemsAwarded',
  );
  @override
  late final GeneratedColumn<int> gemsAwarded = GeneratedColumn<int>(
    'gems_awarded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _closedAtMeta = const VerificationMeta(
    'closedAt',
  );
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
    'closed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    year,
    month,
    xpEarned,
    level,
    rank,
    tasksCompleted,
    habitsCompleted,
    bestStreak,
    topAxisName,
    gemsAwarded,
    closedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'seasons';
  @override
  VerificationContext validateIntegrity(
    Insertable<Season> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('xp_earned')) {
      context.handle(
        _xpEarnedMeta,
        xpEarned.isAcceptableOrUnknown(data['xp_earned']!, _xpEarnedMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('rank')) {
      context.handle(
        _rankMeta,
        rank.isAcceptableOrUnknown(data['rank']!, _rankMeta),
      );
    }
    if (data.containsKey('tasks_completed')) {
      context.handle(
        _tasksCompletedMeta,
        tasksCompleted.isAcceptableOrUnknown(
          data['tasks_completed']!,
          _tasksCompletedMeta,
        ),
      );
    }
    if (data.containsKey('habits_completed')) {
      context.handle(
        _habitsCompletedMeta,
        habitsCompleted.isAcceptableOrUnknown(
          data['habits_completed']!,
          _habitsCompletedMeta,
        ),
      );
    }
    if (data.containsKey('best_streak')) {
      context.handle(
        _bestStreakMeta,
        bestStreak.isAcceptableOrUnknown(data['best_streak']!, _bestStreakMeta),
      );
    }
    if (data.containsKey('top_axis_name')) {
      context.handle(
        _topAxisNameMeta,
        topAxisName.isAcceptableOrUnknown(
          data['top_axis_name']!,
          _topAxisNameMeta,
        ),
      );
    }
    if (data.containsKey('gems_awarded')) {
      context.handle(
        _gemsAwardedMeta,
        gemsAwarded.isAcceptableOrUnknown(
          data['gems_awarded']!,
          _gemsAwardedMeta,
        ),
      );
    }
    if (data.containsKey('closed_at')) {
      context.handle(
        _closedAtMeta,
        closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Season map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Season(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}month'],
      )!,
      xpEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_earned'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      rank: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rank'],
      )!,
      tasksCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tasks_completed'],
      )!,
      habitsCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habits_completed'],
      )!,
      bestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_streak'],
      )!,
      topAxisName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}top_axis_name'],
      ),
      gemsAwarded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gems_awarded'],
      )!,
      closedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}closed_at'],
      )!,
    );
  }

  @override
  $SeasonsTable createAlias(String alias) {
    return $SeasonsTable(attachedDatabase, alias);
  }
}

class Season extends DataClass implements Insertable<Season> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final int year;
  final int month;
  final int xpEarned;
  final int level;
  final String rank;
  final int tasksCompleted;
  final int habitsCompleted;
  final int bestStreak;
  final String? topAxisName;
  final int gemsAwarded;
  final DateTime closedAt;
  const Season({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.year,
    required this.month,
    required this.xpEarned,
    required this.level,
    required this.rank,
    required this.tasksCompleted,
    required this.habitsCompleted,
    required this.bestStreak,
    this.topAxisName,
    required this.gemsAwarded,
    required this.closedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    map['xp_earned'] = Variable<int>(xpEarned);
    map['level'] = Variable<int>(level);
    map['rank'] = Variable<String>(rank);
    map['tasks_completed'] = Variable<int>(tasksCompleted);
    map['habits_completed'] = Variable<int>(habitsCompleted);
    map['best_streak'] = Variable<int>(bestStreak);
    if (!nullToAbsent || topAxisName != null) {
      map['top_axis_name'] = Variable<String>(topAxisName);
    }
    map['gems_awarded'] = Variable<int>(gemsAwarded);
    map['closed_at'] = Variable<DateTime>(closedAt);
    return map;
  }

  SeasonsCompanion toCompanion(bool nullToAbsent) {
    return SeasonsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      year: Value(year),
      month: Value(month),
      xpEarned: Value(xpEarned),
      level: Value(level),
      rank: Value(rank),
      tasksCompleted: Value(tasksCompleted),
      habitsCompleted: Value(habitsCompleted),
      bestStreak: Value(bestStreak),
      topAxisName: topAxisName == null && nullToAbsent
          ? const Value.absent()
          : Value(topAxisName),
      gemsAwarded: Value(gemsAwarded),
      closedAt: Value(closedAt),
    );
  }

  factory Season.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Season(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      xpEarned: serializer.fromJson<int>(json['xpEarned']),
      level: serializer.fromJson<int>(json['level']),
      rank: serializer.fromJson<String>(json['rank']),
      tasksCompleted: serializer.fromJson<int>(json['tasksCompleted']),
      habitsCompleted: serializer.fromJson<int>(json['habitsCompleted']),
      bestStreak: serializer.fromJson<int>(json['bestStreak']),
      topAxisName: serializer.fromJson<String?>(json['topAxisName']),
      gemsAwarded: serializer.fromJson<int>(json['gemsAwarded']),
      closedAt: serializer.fromJson<DateTime>(json['closedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'xpEarned': serializer.toJson<int>(xpEarned),
      'level': serializer.toJson<int>(level),
      'rank': serializer.toJson<String>(rank),
      'tasksCompleted': serializer.toJson<int>(tasksCompleted),
      'habitsCompleted': serializer.toJson<int>(habitsCompleted),
      'bestStreak': serializer.toJson<int>(bestStreak),
      'topAxisName': serializer.toJson<String?>(topAxisName),
      'gemsAwarded': serializer.toJson<int>(gemsAwarded),
      'closedAt': serializer.toJson<DateTime>(closedAt),
    };
  }

  Season copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    int? year,
    int? month,
    int? xpEarned,
    int? level,
    String? rank,
    int? tasksCompleted,
    int? habitsCompleted,
    int? bestStreak,
    Value<String?> topAxisName = const Value.absent(),
    int? gemsAwarded,
    DateTime? closedAt,
  }) => Season(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    year: year ?? this.year,
    month: month ?? this.month,
    xpEarned: xpEarned ?? this.xpEarned,
    level: level ?? this.level,
    rank: rank ?? this.rank,
    tasksCompleted: tasksCompleted ?? this.tasksCompleted,
    habitsCompleted: habitsCompleted ?? this.habitsCompleted,
    bestStreak: bestStreak ?? this.bestStreak,
    topAxisName: topAxisName.present ? topAxisName.value : this.topAxisName,
    gemsAwarded: gemsAwarded ?? this.gemsAwarded,
    closedAt: closedAt ?? this.closedAt,
  );
  Season copyWithCompanion(SeasonsCompanion data) {
    return Season(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      year: data.year.present ? data.year.value : this.year,
      month: data.month.present ? data.month.value : this.month,
      xpEarned: data.xpEarned.present ? data.xpEarned.value : this.xpEarned,
      level: data.level.present ? data.level.value : this.level,
      rank: data.rank.present ? data.rank.value : this.rank,
      tasksCompleted: data.tasksCompleted.present
          ? data.tasksCompleted.value
          : this.tasksCompleted,
      habitsCompleted: data.habitsCompleted.present
          ? data.habitsCompleted.value
          : this.habitsCompleted,
      bestStreak: data.bestStreak.present
          ? data.bestStreak.value
          : this.bestStreak,
      topAxisName: data.topAxisName.present
          ? data.topAxisName.value
          : this.topAxisName,
      gemsAwarded: data.gemsAwarded.present
          ? data.gemsAwarded.value
          : this.gemsAwarded,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Season(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('level: $level, ')
          ..write('rank: $rank, ')
          ..write('tasksCompleted: $tasksCompleted, ')
          ..write('habitsCompleted: $habitsCompleted, ')
          ..write('bestStreak: $bestStreak, ')
          ..write('topAxisName: $topAxisName, ')
          ..write('gemsAwarded: $gemsAwarded, ')
          ..write('closedAt: $closedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    year,
    month,
    xpEarned,
    level,
    rank,
    tasksCompleted,
    habitsCompleted,
    bestStreak,
    topAxisName,
    gemsAwarded,
    closedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Season &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.year == this.year &&
          other.month == this.month &&
          other.xpEarned == this.xpEarned &&
          other.level == this.level &&
          other.rank == this.rank &&
          other.tasksCompleted == this.tasksCompleted &&
          other.habitsCompleted == this.habitsCompleted &&
          other.bestStreak == this.bestStreak &&
          other.topAxisName == this.topAxisName &&
          other.gemsAwarded == this.gemsAwarded &&
          other.closedAt == this.closedAt);
}

class SeasonsCompanion extends UpdateCompanion<Season> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<int> year;
  final Value<int> month;
  final Value<int> xpEarned;
  final Value<int> level;
  final Value<String> rank;
  final Value<int> tasksCompleted;
  final Value<int> habitsCompleted;
  final Value<int> bestStreak;
  final Value<String?> topAxisName;
  final Value<int> gemsAwarded;
  final Value<DateTime> closedAt;
  final Value<int> rowid;
  const SeasonsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.level = const Value.absent(),
    this.rank = const Value.absent(),
    this.tasksCompleted = const Value.absent(),
    this.habitsCompleted = const Value.absent(),
    this.bestStreak = const Value.absent(),
    this.topAxisName = const Value.absent(),
    this.gemsAwarded = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SeasonsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required int year,
    required int month,
    this.xpEarned = const Value.absent(),
    this.level = const Value.absent(),
    this.rank = const Value.absent(),
    this.tasksCompleted = const Value.absent(),
    this.habitsCompleted = const Value.absent(),
    this.bestStreak = const Value.absent(),
    this.topAxisName = const Value.absent(),
    this.gemsAwarded = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       year = Value(year),
       month = Value(month);
  static Insertable<Season> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<int>? year,
    Expression<int>? month,
    Expression<int>? xpEarned,
    Expression<int>? level,
    Expression<String>? rank,
    Expression<int>? tasksCompleted,
    Expression<int>? habitsCompleted,
    Expression<int>? bestStreak,
    Expression<String>? topAxisName,
    Expression<int>? gemsAwarded,
    Expression<DateTime>? closedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (xpEarned != null) 'xp_earned': xpEarned,
      if (level != null) 'level': level,
      if (rank != null) 'rank': rank,
      if (tasksCompleted != null) 'tasks_completed': tasksCompleted,
      if (habitsCompleted != null) 'habits_completed': habitsCompleted,
      if (bestStreak != null) 'best_streak': bestStreak,
      if (topAxisName != null) 'top_axis_name': topAxisName,
      if (gemsAwarded != null) 'gems_awarded': gemsAwarded,
      if (closedAt != null) 'closed_at': closedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SeasonsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<int>? year,
    Value<int>? month,
    Value<int>? xpEarned,
    Value<int>? level,
    Value<String>? rank,
    Value<int>? tasksCompleted,
    Value<int>? habitsCompleted,
    Value<int>? bestStreak,
    Value<String?>? topAxisName,
    Value<int>? gemsAwarded,
    Value<DateTime>? closedAt,
    Value<int>? rowid,
  }) {
    return SeasonsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      year: year ?? this.year,
      month: month ?? this.month,
      xpEarned: xpEarned ?? this.xpEarned,
      level: level ?? this.level,
      rank: rank ?? this.rank,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      habitsCompleted: habitsCompleted ?? this.habitsCompleted,
      bestStreak: bestStreak ?? this.bestStreak,
      topAxisName: topAxisName ?? this.topAxisName,
      gemsAwarded: gemsAwarded ?? this.gemsAwarded,
      closedAt: closedAt ?? this.closedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (xpEarned.present) {
      map['xp_earned'] = Variable<int>(xpEarned.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (rank.present) {
      map['rank'] = Variable<String>(rank.value);
    }
    if (tasksCompleted.present) {
      map['tasks_completed'] = Variable<int>(tasksCompleted.value);
    }
    if (habitsCompleted.present) {
      map['habits_completed'] = Variable<int>(habitsCompleted.value);
    }
    if (bestStreak.present) {
      map['best_streak'] = Variable<int>(bestStreak.value);
    }
    if (topAxisName.present) {
      map['top_axis_name'] = Variable<String>(topAxisName.value);
    }
    if (gemsAwarded.present) {
      map['gems_awarded'] = Variable<int>(gemsAwarded.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeasonsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('level: $level, ')
          ..write('rank: $rank, ')
          ..write('tasksCompleted: $tasksCompleted, ')
          ..write('habitsCompleted: $habitsCompleted, ')
          ..write('bestStreak: $bestStreak, ')
          ..write('topAxisName: $topAxisName, ')
          ..write('gemsAwarded: $gemsAwarded, ')
          ..write('closedAt: $closedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _axisIdMeta = const VerificationMeta('axisId');
  @override
  late final GeneratedColumn<String> axisId = GeneratedColumn<String>(
    'axis_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skill_axes (id)',
    ),
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
    'mood',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pinnedMeta = const VerificationMeta('pinned');
  @override
  late final GeneratedColumn<bool> pinned = GeneratedColumn<bool>(
    'pinned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pinned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    isDeleted,
    dirty,
    title,
    body,
    axisId,
    mood,
    pinned,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Note> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    }
    if (data.containsKey('axis_id')) {
      context.handle(
        _axisIdMeta,
        axisId.isAcceptableOrUnknown(data['axis_id']!, _axisIdMeta),
      );
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    }
    if (data.containsKey('pinned')) {
      context.handle(
        _pinnedMeta,
        pinned.isAcceptableOrUnknown(data['pinned']!, _pinnedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      axisId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}axis_id'],
      ),
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood'],
      ),
      pinned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pinned'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final String id;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool dirty;
  final String title;
  final String body;
  final String? axisId;
  final String? mood;
  final bool pinned;
  final DateTime createdAt;
  const Note({
    required this.id,
    required this.updatedAt,
    required this.isDeleted,
    required this.dirty,
    required this.title,
    required this.body,
    this.axisId,
    this.mood,
    required this.pinned,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['dirty'] = Variable<bool>(dirty);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || axisId != null) {
      map['axis_id'] = Variable<String>(axisId);
    }
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<String>(mood);
    }
    map['pinned'] = Variable<bool>(pinned);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      dirty: Value(dirty),
      title: Value(title),
      body: Value(body),
      axisId: axisId == null && nullToAbsent
          ? const Value.absent()
          : Value(axisId),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      pinned: Value(pinned),
      createdAt: Value(createdAt),
    );
  }

  factory Note.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      axisId: serializer.fromJson<String?>(json['axisId']),
      mood: serializer.fromJson<String?>(json['mood']),
      pinned: serializer.fromJson<bool>(json['pinned']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'dirty': serializer.toJson<bool>(dirty),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'axisId': serializer.toJson<String?>(axisId),
      'mood': serializer.toJson<String?>(mood),
      'pinned': serializer.toJson<bool>(pinned),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Note copyWith({
    String? id,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? dirty,
    String? title,
    String? body,
    Value<String?> axisId = const Value.absent(),
    Value<String?> mood = const Value.absent(),
    bool? pinned,
    DateTime? createdAt,
  }) => Note(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    dirty: dirty ?? this.dirty,
    title: title ?? this.title,
    body: body ?? this.body,
    axisId: axisId.present ? axisId.value : this.axisId,
    mood: mood.present ? mood.value : this.mood,
    pinned: pinned ?? this.pinned,
    createdAt: createdAt ?? this.createdAt,
  );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      axisId: data.axisId.present ? data.axisId.value : this.axisId,
      mood: data.mood.present ? data.mood.value : this.mood,
      pinned: data.pinned.present ? data.pinned.value : this.pinned,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('axisId: $axisId, ')
          ..write('mood: $mood, ')
          ..write('pinned: $pinned, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    isDeleted,
    dirty,
    title,
    body,
    axisId,
    mood,
    pinned,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.dirty == this.dirty &&
          other.title == this.title &&
          other.body == this.body &&
          other.axisId == this.axisId &&
          other.mood == this.mood &&
          other.pinned == this.pinned &&
          other.createdAt == this.createdAt);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> dirty;
  final Value<String> title;
  final Value<String> body;
  final Value<String?> axisId;
  final Value<String?> mood;
  final Value<bool> pinned;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.axisId = const Value.absent(),
    this.mood = const Value.absent(),
    this.pinned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.axisId = const Value.absent(),
    this.mood = const Value.absent(),
    this.pinned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Note> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? dirty,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? axisId,
    Expression<String>? mood,
    Expression<bool>? pinned,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dirty != null) 'dirty': dirty,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (axisId != null) 'axis_id': axisId,
      if (mood != null) 'mood': mood,
      if (pinned != null) 'pinned': pinned,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? dirty,
    Value<String>? title,
    Value<String>? body,
    Value<String?>? axisId,
    Value<String?>? mood,
    Value<bool>? pinned,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      dirty: dirty ?? this.dirty,
      title: title ?? this.title,
      body: body ?? this.body,
      axisId: axisId ?? this.axisId,
      mood: mood ?? this.mood,
      pinned: pinned ?? this.pinned,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (axisId.present) {
      map['axis_id'] = Variable<String>(axisId.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (pinned.present) {
      map['pinned'] = Variable<bool>(pinned.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dirty: $dirty, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('axisId: $axisId, ')
          ..write('mood: $mood, ')
          ..write('pinned: $pinned, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SkillAxesTable skillAxes = $SkillAxesTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitLogsTable habitLogs = $HabitLogsTable(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $CurrencyTransactionsTable currencyTransactions =
      $CurrencyTransactionsTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $GoalStepsTable goalSteps = $GoalStepsTable(this);
  late final $DailyQuestsTable dailyQuests = $DailyQuestsTable(this);
  late final $UserAchievementsTable userAchievements = $UserAchievementsTable(
    this,
  );
  late final $InventoryItemsTable inventoryItems = $InventoryItemsTable(this);
  late final $SleepLogsTable sleepLogs = $SleepLogsTable(this);
  late final $CodexEntriesTable codexEntries = $CodexEntriesTable(this);
  late final $StatSnapshotsTable statSnapshots = $StatSnapshotsTable(this);
  late final $SeasonsTable seasons = $SeasonsTable(this);
  late final $NotesTable notes = $NotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    skillAxes,
    tasks,
    habits,
    habitLogs,
    profiles,
    currencyTransactions,
    goals,
    goalSteps,
    dailyQuests,
    userAchievements,
    inventoryItems,
    sleepLogs,
    codexEntries,
    statSnapshots,
    seasons,
    notes,
  ];
}

typedef $$SkillAxesTableCreateCompanionBuilder =
    SkillAxesCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      required String name,
      required int iconCodePoint,
      required int colorValue,
      Value<bool> isDefault,
      Value<int> sortOrder,
      Value<int> xp,
      Value<int> rowid,
    });
typedef $$SkillAxesTableUpdateCompanionBuilder =
    SkillAxesCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> name,
      Value<int> iconCodePoint,
      Value<int> colorValue,
      Value<bool> isDefault,
      Value<int> sortOrder,
      Value<int> xp,
      Value<int> rowid,
    });

final class $$SkillAxesTableReferences
    extends BaseReferences<_$AppDatabase, $SkillAxesTable, SkillAxe> {
  $$SkillAxesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: 'skill_axes__id__tasks__axis_id',
  );

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.axisId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HabitsTable, List<Habit>> _habitsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.habits,
    aliasName: 'skill_axes__id__habits__axis_id',
  );

  $$HabitsTableProcessedTableManager get habitsRefs {
    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.axisId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GoalsTable, List<Goal>> _goalsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.goals,
    aliasName: 'skill_axes__id__goals__axis_id',
  );

  $$GoalsTableProcessedTableManager get goalsRefs {
    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.axisId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_goalsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$NotesTable, List<Note>> _notesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.notes,
    aliasName: 'skill_axes__id__notes__axis_id',
  );

  $$NotesTableProcessedTableManager get notesRefs {
    final manager = $$NotesTableTableManager(
      $_db,
      $_db.notes,
    ).filter((f) => f.axisId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_notesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SkillAxesTableFilterComposer
    extends Composer<_$AppDatabase, $SkillAxesTable> {
  $$SkillAxesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tasksRefs(
    Expression<bool> Function($$TasksTableFilterComposer f) f,
  ) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.axisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> habitsRefs(
    Expression<bool> Function($$HabitsTableFilterComposer f) f,
  ) {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.axisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> goalsRefs(
    Expression<bool> Function($$GoalsTableFilterComposer f) f,
  ) {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.axisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> notesRefs(
    Expression<bool> Function($$NotesTableFilterComposer f) f,
  ) {
    final $$NotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.axisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableFilterComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkillAxesTableOrderingComposer
    extends Composer<_$AppDatabase, $SkillAxesTable> {
  $$SkillAxesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkillAxesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkillAxesTable> {
  $$SkillAxesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($$TasksTableAnnotationComposer a) f,
  ) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.axisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> habitsRefs<T extends Object>(
    Expression<T> Function($$HabitsTableAnnotationComposer a) f,
  ) {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.axisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> goalsRefs<T extends Object>(
    Expression<T> Function($$GoalsTableAnnotationComposer a) f,
  ) {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.axisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> notesRefs<T extends Object>(
    Expression<T> Function($$NotesTableAnnotationComposer a) f,
  ) {
    final $$NotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.axisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableAnnotationComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkillAxesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkillAxesTable,
          SkillAxe,
          $$SkillAxesTableFilterComposer,
          $$SkillAxesTableOrderingComposer,
          $$SkillAxesTableAnnotationComposer,
          $$SkillAxesTableCreateCompanionBuilder,
          $$SkillAxesTableUpdateCompanionBuilder,
          (SkillAxe, $$SkillAxesTableReferences),
          SkillAxe,
          PrefetchHooks Function({
            bool tasksRefs,
            bool habitsRefs,
            bool goalsRefs,
            bool notesRefs,
          })
        > {
  $$SkillAxesTableTableManager(_$AppDatabase db, $SkillAxesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkillAxesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkillAxesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkillAxesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> iconCodePoint = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkillAxesCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                name: name,
                iconCodePoint: iconCodePoint,
                colorValue: colorValue,
                isDefault: isDefault,
                sortOrder: sortOrder,
                xp: xp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String name,
                required int iconCodePoint,
                required int colorValue,
                Value<bool> isDefault = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkillAxesCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                name: name,
                iconCodePoint: iconCodePoint,
                colorValue: colorValue,
                isDefault: isDefault,
                sortOrder: sortOrder,
                xp: xp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SkillAxesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tasksRefs = false,
                habitsRefs = false,
                goalsRefs = false,
                notesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (tasksRefs) db.tasks,
                    if (habitsRefs) db.habits,
                    if (goalsRefs) db.goals,
                    if (notesRefs) db.notes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tasksRefs)
                        await $_getPrefetchedData<
                          SkillAxe,
                          $SkillAxesTable,
                          Task
                        >(
                          currentTable: table,
                          referencedTable: $$SkillAxesTableReferences
                              ._tasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SkillAxesTableReferences(
                                db,
                                table,
                                p0,
                              ).tasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.axisId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (habitsRefs)
                        await $_getPrefetchedData<
                          SkillAxe,
                          $SkillAxesTable,
                          Habit
                        >(
                          currentTable: table,
                          referencedTable: $$SkillAxesTableReferences
                              ._habitsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SkillAxesTableReferences(
                                db,
                                table,
                                p0,
                              ).habitsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.axisId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (goalsRefs)
                        await $_getPrefetchedData<
                          SkillAxe,
                          $SkillAxesTable,
                          Goal
                        >(
                          currentTable: table,
                          referencedTable: $$SkillAxesTableReferences
                              ._goalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SkillAxesTableReferences(
                                db,
                                table,
                                p0,
                              ).goalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.axisId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (notesRefs)
                        await $_getPrefetchedData<
                          SkillAxe,
                          $SkillAxesTable,
                          Note
                        >(
                          currentTable: table,
                          referencedTable: $$SkillAxesTableReferences
                              ._notesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SkillAxesTableReferences(
                                db,
                                table,
                                p0,
                              ).notesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.axisId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SkillAxesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkillAxesTable,
      SkillAxe,
      $$SkillAxesTableFilterComposer,
      $$SkillAxesTableOrderingComposer,
      $$SkillAxesTableAnnotationComposer,
      $$SkillAxesTableCreateCompanionBuilder,
      $$SkillAxesTableUpdateCompanionBuilder,
      (SkillAxe, $$SkillAxesTableReferences),
      SkillAxe,
      PrefetchHooks Function({
        bool tasksRefs,
        bool habitsRefs,
        bool goalsRefs,
        bool notesRefs,
      })
    >;
typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      required String title,
      Value<String?> notes,
      Value<String?> axisId,
      Value<Difficulty> difficulty,
      Value<int> estimatedMinutes,
      Value<DateTime?> dueAt,
      Value<DateTime?> reminderAt,
      Value<TaskStatus> status,
      Value<DateTime?> completedAt,
      Value<int> xpAwarded,
      Value<int> goldAwarded,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> title,
      Value<String?> notes,
      Value<String?> axisId,
      Value<Difficulty> difficulty,
      Value<int> estimatedMinutes,
      Value<DateTime?> dueAt,
      Value<DateTime?> reminderAt,
      Value<TaskStatus> status,
      Value<DateTime?> completedAt,
      Value<int> xpAwarded,
      Value<int> goldAwarded,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SkillAxesTable _axisIdTable(_$AppDatabase db) =>
      db.skillAxes.createAlias('tasks__axis_id__skill_axes__id');

  $$SkillAxesTableProcessedTableManager? get axisId {
    final $_column = $_itemColumn<String>('axis_id');
    if ($_column == null) return null;
    final manager = $$SkillAxesTableTableManager(
      $_db,
      $_db.skillAxes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_axisIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Difficulty, Difficulty, int> get difficulty =>
      $composableBuilder(
        column: $table.difficulty,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reminderAt => $composableBuilder(
    column: $table.reminderAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TaskStatus, TaskStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpAwarded => $composableBuilder(
    column: $table.xpAwarded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goldAwarded => $composableBuilder(
    column: $table.goldAwarded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SkillAxesTableFilterComposer get axisId {
    final $$SkillAxesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.axisId,
      referencedTable: $db.skillAxes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillAxesTableFilterComposer(
            $db: $db,
            $table: $db.skillAxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reminderAt => $composableBuilder(
    column: $table.reminderAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpAwarded => $composableBuilder(
    column: $table.xpAwarded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goldAwarded => $composableBuilder(
    column: $table.goldAwarded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SkillAxesTableOrderingComposer get axisId {
    final $$SkillAxesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.axisId,
      referencedTable: $db.skillAxes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillAxesTableOrderingComposer(
            $db: $db,
            $table: $db.skillAxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Difficulty, int> get difficulty =>
      $composableBuilder(
        column: $table.difficulty,
        builder: (column) => column,
      );

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<DateTime> get reminderAt => $composableBuilder(
    column: $table.reminderAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<TaskStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xpAwarded =>
      $composableBuilder(column: $table.xpAwarded, builder: (column) => column);

  GeneratedColumn<int> get goldAwarded => $composableBuilder(
    column: $table.goldAwarded,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SkillAxesTableAnnotationComposer get axisId {
    final $$SkillAxesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.axisId,
      referencedTable: $db.skillAxes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillAxesTableAnnotationComposer(
            $db: $db,
            $table: $db.skillAxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, $$TasksTableReferences),
          Task,
          PrefetchHooks Function({bool axisId})
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> axisId = const Value.absent(),
                Value<Difficulty> difficulty = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<DateTime?> reminderAt = const Value.absent(),
                Value<TaskStatus> status = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> xpAwarded = const Value.absent(),
                Value<int> goldAwarded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                title: title,
                notes: notes,
                axisId: axisId,
                difficulty: difficulty,
                estimatedMinutes: estimatedMinutes,
                dueAt: dueAt,
                reminderAt: reminderAt,
                status: status,
                completedAt: completedAt,
                xpAwarded: xpAwarded,
                goldAwarded: goldAwarded,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String title,
                Value<String?> notes = const Value.absent(),
                Value<String?> axisId = const Value.absent(),
                Value<Difficulty> difficulty = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<DateTime?> reminderAt = const Value.absent(),
                Value<TaskStatus> status = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> xpAwarded = const Value.absent(),
                Value<int> goldAwarded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                title: title,
                notes: notes,
                axisId: axisId,
                difficulty: difficulty,
                estimatedMinutes: estimatedMinutes,
                dueAt: dueAt,
                reminderAt: reminderAt,
                status: status,
                completedAt: completedAt,
                xpAwarded: xpAwarded,
                goldAwarded: goldAwarded,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TasksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({axisId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (axisId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.axisId,
                                referencedTable: $$TasksTableReferences
                                    ._axisIdTable(db),
                                referencedColumn: $$TasksTableReferences
                                    ._axisIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, $$TasksTableReferences),
      Task,
      PrefetchHooks Function({bool axisId})
    >;
typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      required String title,
      Value<String?> axisId,
      Value<HabitType> type,
      Value<Frequency> frequency,
      Value<Difficulty> difficulty,
      Value<int> streakCurrent,
      Value<int> streakBest,
      Value<int?> reminderMinutes,
      Value<DateTime?> lastCompletedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> title,
      Value<String?> axisId,
      Value<HabitType> type,
      Value<Frequency> frequency,
      Value<Difficulty> difficulty,
      Value<int> streakCurrent,
      Value<int> streakBest,
      Value<int?> reminderMinutes,
      Value<DateTime?> lastCompletedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, Habit> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SkillAxesTable _axisIdTable(_$AppDatabase db) =>
      db.skillAxes.createAlias('habits__axis_id__skill_axes__id');

  $$SkillAxesTableProcessedTableManager? get axisId {
    final $_column = $_itemColumn<String>('axis_id');
    if ($_column == null) return null;
    final manager = $$SkillAxesTableTableManager(
      $_db,
      $_db.skillAxes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_axisIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$HabitLogsTable, List<HabitLog>>
  _habitLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitLogs,
    aliasName: 'habits__id__habit_logs__habit_id',
  );

  $$HabitLogsTableProcessedTableManager get habitLogsRefs {
    final manager = $$HabitLogsTableTableManager(
      $_db,
      $_db.habitLogs,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HabitType, HabitType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Frequency, Frequency, int> get frequency =>
      $composableBuilder(
        column: $table.frequency,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Difficulty, Difficulty, int> get difficulty =>
      $composableBuilder(
        column: $table.difficulty,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get streakCurrent => $composableBuilder(
    column: $table.streakCurrent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streakBest => $composableBuilder(
    column: $table.streakBest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastCompletedAt => $composableBuilder(
    column: $table.lastCompletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SkillAxesTableFilterComposer get axisId {
    final $$SkillAxesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.axisId,
      referencedTable: $db.skillAxes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillAxesTableFilterComposer(
            $db: $db,
            $table: $db.skillAxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> habitLogsRefs(
    Expression<bool> Function($$HabitLogsTableFilterComposer f) f,
  ) {
    final $$HabitLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableFilterComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakCurrent => $composableBuilder(
    column: $table.streakCurrent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakBest => $composableBuilder(
    column: $table.streakBest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastCompletedAt => $composableBuilder(
    column: $table.lastCompletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SkillAxesTableOrderingComposer get axisId {
    final $$SkillAxesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.axisId,
      referencedTable: $db.skillAxes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillAxesTableOrderingComposer(
            $db: $db,
            $table: $db.skillAxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HabitType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Frequency, int> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Difficulty, int> get difficulty =>
      $composableBuilder(
        column: $table.difficulty,
        builder: (column) => column,
      );

  GeneratedColumn<int> get streakCurrent => $composableBuilder(
    column: $table.streakCurrent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get streakBest => $composableBuilder(
    column: $table.streakBest,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastCompletedAt => $composableBuilder(
    column: $table.lastCompletedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SkillAxesTableAnnotationComposer get axisId {
    final $$SkillAxesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.axisId,
      referencedTable: $db.skillAxes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillAxesTableAnnotationComposer(
            $db: $db,
            $table: $db.skillAxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> habitLogsRefs<T extends Object>(
    Expression<T> Function($$HabitLogsTableAnnotationComposer a) f,
  ) {
    final $$HabitLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          Habit,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (Habit, $$HabitsTableReferences),
          Habit,
          PrefetchHooks Function({bool axisId, bool habitLogsRefs})
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> axisId = const Value.absent(),
                Value<HabitType> type = const Value.absent(),
                Value<Frequency> frequency = const Value.absent(),
                Value<Difficulty> difficulty = const Value.absent(),
                Value<int> streakCurrent = const Value.absent(),
                Value<int> streakBest = const Value.absent(),
                Value<int?> reminderMinutes = const Value.absent(),
                Value<DateTime?> lastCompletedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                title: title,
                axisId: axisId,
                type: type,
                frequency: frequency,
                difficulty: difficulty,
                streakCurrent: streakCurrent,
                streakBest: streakBest,
                reminderMinutes: reminderMinutes,
                lastCompletedAt: lastCompletedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String title,
                Value<String?> axisId = const Value.absent(),
                Value<HabitType> type = const Value.absent(),
                Value<Frequency> frequency = const Value.absent(),
                Value<Difficulty> difficulty = const Value.absent(),
                Value<int> streakCurrent = const Value.absent(),
                Value<int> streakBest = const Value.absent(),
                Value<int?> reminderMinutes = const Value.absent(),
                Value<DateTime?> lastCompletedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                title: title,
                axisId: axisId,
                type: type,
                frequency: frequency,
                difficulty: difficulty,
                streakCurrent: streakCurrent,
                streakBest: streakBest,
                reminderMinutes: reminderMinutes,
                lastCompletedAt: lastCompletedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HabitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({axisId = false, habitLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (habitLogsRefs) db.habitLogs],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (axisId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.axisId,
                                referencedTable: $$HabitsTableReferences
                                    ._axisIdTable(db),
                                referencedColumn: $$HabitsTableReferences
                                    ._axisIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitLogsRefs)
                    await $_getPrefetchedData<Habit, $HabitsTable, HabitLog>(
                      currentTable: table,
                      referencedTable: $$HabitsTableReferences
                          ._habitLogsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$HabitsTableReferences(db, table, p0).habitLogsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.habitId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      Habit,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (Habit, $$HabitsTableReferences),
      Habit,
      PrefetchHooks Function({bool axisId, bool habitLogsRefs})
    >;
typedef $$HabitLogsTableCreateCompanionBuilder =
    HabitLogsCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      required String habitId,
      Value<DateTime> completedAt,
      Value<int> value,
      Value<int> xp,
      Value<int> gold,
      Value<int> rowid,
    });
typedef $$HabitLogsTableUpdateCompanionBuilder =
    HabitLogsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> habitId,
      Value<DateTime> completedAt,
      Value<int> value,
      Value<int> xp,
      Value<int> gold,
      Value<int> rowid,
    });

final class $$HabitLogsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitLogsTable, HabitLog> {
  $$HabitLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) =>
      db.habits.createAlias('habit_logs__habit_id__habits__id');

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<String>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<int> get gold =>
      $composableBuilder(column: $table.gold, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitLogsTable,
          HabitLog,
          $$HabitLogsTableFilterComposer,
          $$HabitLogsTableOrderingComposer,
          $$HabitLogsTableAnnotationComposer,
          $$HabitLogsTableCreateCompanionBuilder,
          $$HabitLogsTableUpdateCompanionBuilder,
          (HabitLog, $$HabitLogsTableReferences),
          HabitLog,
          PrefetchHooks Function({bool habitId})
        > {
  $$HabitLogsTableTableManager(_$AppDatabase db, $HabitLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> value = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> gold = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitLogsCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                habitId: habitId,
                completedAt: completedAt,
                value: value,
                xp: xp,
                gold: gold,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String habitId,
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> value = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> gold = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitLogsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                habitId: habitId,
                completedAt: completedAt,
                value: value,
                xp: xp,
                gold: gold,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable: $$HabitLogsTableReferences
                                    ._habitIdTable(db),
                                referencedColumn: $$HabitLogsTableReferences
                                    ._habitIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitLogsTable,
      HabitLog,
      $$HabitLogsTableFilterComposer,
      $$HabitLogsTableOrderingComposer,
      $$HabitLogsTableAnnotationComposer,
      $$HabitLogsTableCreateCompanionBuilder,
      $$HabitLogsTableUpdateCompanionBuilder,
      (HabitLog, $$HabitLogsTableReferences),
      HabitLog,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$ProfilesTableCreateCompanionBuilder =
    ProfilesCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> displayName,
      Value<int> totalXp,
      Value<int> lifetimeXp,
      Value<int> prestige,
      Value<int> seasonYear,
      Value<int> seasonMonth,
      Value<int> gold,
      Value<int> gems,
      Value<int> rowid,
    });
typedef $$ProfilesTableUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> displayName,
      Value<int> totalXp,
      Value<int> lifetimeXp,
      Value<int> prestige,
      Value<int> seasonYear,
      Value<int> seasonMonth,
      Value<int> gold,
      Value<int> gems,
      Value<int> rowid,
    });

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lifetimeXp => $composableBuilder(
    column: $table.lifetimeXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prestige => $composableBuilder(
    column: $table.prestige,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seasonYear => $composableBuilder(
    column: $table.seasonYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seasonMonth => $composableBuilder(
    column: $table.seasonMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gems => $composableBuilder(
    column: $table.gems,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lifetimeXp => $composableBuilder(
    column: $table.lifetimeXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prestige => $composableBuilder(
    column: $table.prestige,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seasonYear => $composableBuilder(
    column: $table.seasonYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seasonMonth => $composableBuilder(
    column: $table.seasonMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gems => $composableBuilder(
    column: $table.gems,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalXp =>
      $composableBuilder(column: $table.totalXp, builder: (column) => column);

  GeneratedColumn<int> get lifetimeXp => $composableBuilder(
    column: $table.lifetimeXp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get prestige =>
      $composableBuilder(column: $table.prestige, builder: (column) => column);

  GeneratedColumn<int> get seasonYear => $composableBuilder(
    column: $table.seasonYear,
    builder: (column) => column,
  );

  GeneratedColumn<int> get seasonMonth => $composableBuilder(
    column: $table.seasonMonth,
    builder: (column) => column,
  );

  GeneratedColumn<int> get gold =>
      $composableBuilder(column: $table.gold, builder: (column) => column);

  GeneratedColumn<int> get gems =>
      $composableBuilder(column: $table.gems, builder: (column) => column);
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          Profile,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
          Profile,
          PrefetchHooks Function()
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> lifetimeXp = const Value.absent(),
                Value<int> prestige = const Value.absent(),
                Value<int> seasonYear = const Value.absent(),
                Value<int> seasonMonth = const Value.absent(),
                Value<int> gold = const Value.absent(),
                Value<int> gems = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                displayName: displayName,
                totalXp: totalXp,
                lifetimeXp: lifetimeXp,
                prestige: prestige,
                seasonYear: seasonYear,
                seasonMonth: seasonMonth,
                gold: gold,
                gems: gems,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> lifetimeXp = const Value.absent(),
                Value<int> prestige = const Value.absent(),
                Value<int> seasonYear = const Value.absent(),
                Value<int> seasonMonth = const Value.absent(),
                Value<int> gold = const Value.absent(),
                Value<int> gems = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                displayName: displayName,
                totalXp: totalXp,
                lifetimeXp: lifetimeXp,
                prestige: prestige,
                seasonYear: seasonYear,
                seasonMonth: seasonMonth,
                gold: gold,
                gems: gems,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      Profile,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
      Profile,
      PrefetchHooks Function()
    >;
typedef $$CurrencyTransactionsTableCreateCompanionBuilder =
    CurrencyTransactionsCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      required CurrencyKind kind,
      required int amount,
      required RewardReason reason,
      Value<String?> refEntity,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$CurrencyTransactionsTableUpdateCompanionBuilder =
    CurrencyTransactionsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<CurrencyKind> kind,
      Value<int> amount,
      Value<RewardReason> reason,
      Value<String?> refEntity,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$CurrencyTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $CurrencyTransactionsTable> {
  $$CurrencyTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CurrencyKind, CurrencyKind, int> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RewardReason, RewardReason, int> get reason =>
      $composableBuilder(
        column: $table.reason,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get refEntity => $composableBuilder(
    column: $table.refEntity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CurrencyTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CurrencyTransactionsTable> {
  $$CurrencyTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refEntity => $composableBuilder(
    column: $table.refEntity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CurrencyTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CurrencyTransactionsTable> {
  $$CurrencyTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CurrencyKind, int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RewardReason, int> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get refEntity =>
      $composableBuilder(column: $table.refEntity, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CurrencyTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CurrencyTransactionsTable,
          CurrencyTransaction,
          $$CurrencyTransactionsTableFilterComposer,
          $$CurrencyTransactionsTableOrderingComposer,
          $$CurrencyTransactionsTableAnnotationComposer,
          $$CurrencyTransactionsTableCreateCompanionBuilder,
          $$CurrencyTransactionsTableUpdateCompanionBuilder,
          (
            CurrencyTransaction,
            BaseReferences<
              _$AppDatabase,
              $CurrencyTransactionsTable,
              CurrencyTransaction
            >,
          ),
          CurrencyTransaction,
          PrefetchHooks Function()
        > {
  $$CurrencyTransactionsTableTableManager(
    _$AppDatabase db,
    $CurrencyTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CurrencyTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CurrencyTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CurrencyTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<CurrencyKind> kind = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<RewardReason> reason = const Value.absent(),
                Value<String?> refEntity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CurrencyTransactionsCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                kind: kind,
                amount: amount,
                reason: reason,
                refEntity: refEntity,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required CurrencyKind kind,
                required int amount,
                required RewardReason reason,
                Value<String?> refEntity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CurrencyTransactionsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                kind: kind,
                amount: amount,
                reason: reason,
                refEntity: refEntity,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CurrencyTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CurrencyTransactionsTable,
      CurrencyTransaction,
      $$CurrencyTransactionsTableFilterComposer,
      $$CurrencyTransactionsTableOrderingComposer,
      $$CurrencyTransactionsTableAnnotationComposer,
      $$CurrencyTransactionsTableCreateCompanionBuilder,
      $$CurrencyTransactionsTableUpdateCompanionBuilder,
      (
        CurrencyTransaction,
        BaseReferences<
          _$AppDatabase,
          $CurrencyTransactionsTable,
          CurrencyTransaction
        >,
      ),
      CurrencyTransaction,
      PrefetchHooks Function()
    >;
typedef $$GoalsTableCreateCompanionBuilder =
    GoalsCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      required String title,
      Value<String?> notes,
      Value<String?> axisId,
      Value<bool> isBoss,
      Value<int> hpTotal,
      Value<int> hpRemaining,
      Value<GoalStatus> status,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$GoalsTableUpdateCompanionBuilder =
    GoalsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> title,
      Value<String?> notes,
      Value<String?> axisId,
      Value<bool> isBoss,
      Value<int> hpTotal,
      Value<int> hpRemaining,
      Value<GoalStatus> status,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$GoalsTableReferences
    extends BaseReferences<_$AppDatabase, $GoalsTable, Goal> {
  $$GoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SkillAxesTable _axisIdTable(_$AppDatabase db) =>
      db.skillAxes.createAlias('goals__axis_id__skill_axes__id');

  $$SkillAxesTableProcessedTableManager? get axisId {
    final $_column = $_itemColumn<String>('axis_id');
    if ($_column == null) return null;
    final manager = $$SkillAxesTableTableManager(
      $_db,
      $_db.skillAxes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_axisIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$GoalStepsTable, List<GoalStep>>
  _goalStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.goalSteps,
    aliasName: 'goals__id__goal_steps__goal_id',
  );

  $$GoalStepsTableProcessedTableManager get goalStepsRefs {
    final manager = $$GoalStepsTableTableManager(
      $_db,
      $_db.goalSteps,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_goalStepsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBoss => $composableBuilder(
    column: $table.isBoss,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hpTotal => $composableBuilder(
    column: $table.hpTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hpRemaining => $composableBuilder(
    column: $table.hpRemaining,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GoalStatus, GoalStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SkillAxesTableFilterComposer get axisId {
    final $$SkillAxesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.axisId,
      referencedTable: $db.skillAxes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillAxesTableFilterComposer(
            $db: $db,
            $table: $db.skillAxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> goalStepsRefs(
    Expression<bool> Function($$GoalStepsTableFilterComposer f) f,
  ) {
    final $$GoalStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalSteps,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalStepsTableFilterComposer(
            $db: $db,
            $table: $db.goalSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBoss => $composableBuilder(
    column: $table.isBoss,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hpTotal => $composableBuilder(
    column: $table.hpTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hpRemaining => $composableBuilder(
    column: $table.hpRemaining,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SkillAxesTableOrderingComposer get axisId {
    final $$SkillAxesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.axisId,
      referencedTable: $db.skillAxes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillAxesTableOrderingComposer(
            $db: $db,
            $table: $db.skillAxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isBoss =>
      $composableBuilder(column: $table.isBoss, builder: (column) => column);

  GeneratedColumn<int> get hpTotal =>
      $composableBuilder(column: $table.hpTotal, builder: (column) => column);

  GeneratedColumn<int> get hpRemaining => $composableBuilder(
    column: $table.hpRemaining,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<GoalStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SkillAxesTableAnnotationComposer get axisId {
    final $$SkillAxesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.axisId,
      referencedTable: $db.skillAxes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillAxesTableAnnotationComposer(
            $db: $db,
            $table: $db.skillAxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> goalStepsRefs<T extends Object>(
    Expression<T> Function($$GoalStepsTableAnnotationComposer a) f,
  ) {
    final $$GoalStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalSteps,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.goalSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTable,
          Goal,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (Goal, $$GoalsTableReferences),
          Goal,
          PrefetchHooks Function({bool axisId, bool goalStepsRefs})
        > {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> axisId = const Value.absent(),
                Value<bool> isBoss = const Value.absent(),
                Value<int> hpTotal = const Value.absent(),
                Value<int> hpRemaining = const Value.absent(),
                Value<GoalStatus> status = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                title: title,
                notes: notes,
                axisId: axisId,
                isBoss: isBoss,
                hpTotal: hpTotal,
                hpRemaining: hpRemaining,
                status: status,
                completedAt: completedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String title,
                Value<String?> notes = const Value.absent(),
                Value<String?> axisId = const Value.absent(),
                Value<bool> isBoss = const Value.absent(),
                Value<int> hpTotal = const Value.absent(),
                Value<int> hpRemaining = const Value.absent(),
                Value<GoalStatus> status = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                title: title,
                notes: notes,
                axisId: axisId,
                isBoss: isBoss,
                hpTotal: hpTotal,
                hpRemaining: hpRemaining,
                status: status,
                completedAt: completedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GoalsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({axisId = false, goalStepsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (goalStepsRefs) db.goalSteps],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (axisId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.axisId,
                                referencedTable: $$GoalsTableReferences
                                    ._axisIdTable(db),
                                referencedColumn: $$GoalsTableReferences
                                    ._axisIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (goalStepsRefs)
                    await $_getPrefetchedData<Goal, $GoalsTable, GoalStep>(
                      currentTable: table,
                      referencedTable: $$GoalsTableReferences
                          ._goalStepsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GoalsTableReferences(db, table, p0).goalStepsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.goalId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTable,
      Goal,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (Goal, $$GoalsTableReferences),
      Goal,
      PrefetchHooks Function({bool axisId, bool goalStepsRefs})
    >;
typedef $$GoalStepsTableCreateCompanionBuilder =
    GoalStepsCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      required String goalId,
      required String title,
      Value<Difficulty> difficulty,
      Value<int> estimatedMinutes,
      Value<int> expectedXp,
      Value<TaskStatus> status,
      Value<DateTime?> completedAt,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$GoalStepsTableUpdateCompanionBuilder =
    GoalStepsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> goalId,
      Value<String> title,
      Value<Difficulty> difficulty,
      Value<int> estimatedMinutes,
      Value<int> expectedXp,
      Value<TaskStatus> status,
      Value<DateTime?> completedAt,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$GoalStepsTableReferences
    extends BaseReferences<_$AppDatabase, $GoalStepsTable, GoalStep> {
  $$GoalStepsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('goal_steps__goal_id__goals__id');

  $$GoalsTableProcessedTableManager get goalId {
    final $_column = $_itemColumn<String>('goal_id')!;

    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GoalStepsTableFilterComposer
    extends Composer<_$AppDatabase, $GoalStepsTable> {
  $$GoalStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Difficulty, Difficulty, int> get difficulty =>
      $composableBuilder(
        column: $table.difficulty,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expectedXp => $composableBuilder(
    column: $table.expectedXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TaskStatus, TaskStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalStepsTable> {
  $$GoalStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedXp => $composableBuilder(
    column: $table.expectedXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalStepsTable> {
  $$GoalStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Difficulty, int> get difficulty =>
      $composableBuilder(
        column: $table.difficulty,
        builder: (column) => column,
      );

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get expectedXp => $composableBuilder(
    column: $table.expectedXp,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<TaskStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalStepsTable,
          GoalStep,
          $$GoalStepsTableFilterComposer,
          $$GoalStepsTableOrderingComposer,
          $$GoalStepsTableAnnotationComposer,
          $$GoalStepsTableCreateCompanionBuilder,
          $$GoalStepsTableUpdateCompanionBuilder,
          (GoalStep, $$GoalStepsTableReferences),
          GoalStep,
          PrefetchHooks Function({bool goalId})
        > {
  $$GoalStepsTableTableManager(_$AppDatabase db, $GoalStepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> goalId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<Difficulty> difficulty = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<int> expectedXp = const Value.absent(),
                Value<TaskStatus> status = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalStepsCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                goalId: goalId,
                title: title,
                difficulty: difficulty,
                estimatedMinutes: estimatedMinutes,
                expectedXp: expectedXp,
                status: status,
                completedAt: completedAt,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String goalId,
                required String title,
                Value<Difficulty> difficulty = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<int> expectedXp = const Value.absent(),
                Value<TaskStatus> status = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalStepsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                goalId: goalId,
                title: title,
                difficulty: difficulty,
                estimatedMinutes: estimatedMinutes,
                expectedXp: expectedXp,
                status: status,
                completedAt: completedAt,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GoalStepsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (goalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.goalId,
                                referencedTable: $$GoalStepsTableReferences
                                    ._goalIdTable(db),
                                referencedColumn: $$GoalStepsTableReferences
                                    ._goalIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GoalStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalStepsTable,
      GoalStep,
      $$GoalStepsTableFilterComposer,
      $$GoalStepsTableOrderingComposer,
      $$GoalStepsTableAnnotationComposer,
      $$GoalStepsTableCreateCompanionBuilder,
      $$GoalStepsTableUpdateCompanionBuilder,
      (GoalStep, $$GoalStepsTableReferences),
      GoalStep,
      PrefetchHooks Function({bool goalId})
    >;
typedef $$DailyQuestsTableCreateCompanionBuilder =
    DailyQuestsCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      required String dateKey,
      required QuestType type,
      required int target,
      required int rewardXp,
      required int rewardGold,
      Value<bool> claimed,
      Value<int> rowid,
    });
typedef $$DailyQuestsTableUpdateCompanionBuilder =
    DailyQuestsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> dateKey,
      Value<QuestType> type,
      Value<int> target,
      Value<int> rewardXp,
      Value<int> rewardGold,
      Value<bool> claimed,
      Value<int> rowid,
    });

class $$DailyQuestsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyQuestsTable> {
  $$DailyQuestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<QuestType, QuestType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardXp => $composableBuilder(
    column: $table.rewardXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardGold => $composableBuilder(
    column: $table.rewardGold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get claimed => $composableBuilder(
    column: $table.claimed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyQuestsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyQuestsTable> {
  $$DailyQuestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardXp => $composableBuilder(
    column: $table.rewardXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardGold => $composableBuilder(
    column: $table.rewardGold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get claimed => $composableBuilder(
    column: $table.claimed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyQuestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyQuestsTable> {
  $$DailyQuestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get dateKey =>
      $composableBuilder(column: $table.dateKey, builder: (column) => column);

  GeneratedColumnWithTypeConverter<QuestType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<int> get rewardXp =>
      $composableBuilder(column: $table.rewardXp, builder: (column) => column);

  GeneratedColumn<int> get rewardGold => $composableBuilder(
    column: $table.rewardGold,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get claimed =>
      $composableBuilder(column: $table.claimed, builder: (column) => column);
}

class $$DailyQuestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyQuestsTable,
          DailyQuest,
          $$DailyQuestsTableFilterComposer,
          $$DailyQuestsTableOrderingComposer,
          $$DailyQuestsTableAnnotationComposer,
          $$DailyQuestsTableCreateCompanionBuilder,
          $$DailyQuestsTableUpdateCompanionBuilder,
          (
            DailyQuest,
            BaseReferences<_$AppDatabase, $DailyQuestsTable, DailyQuest>,
          ),
          DailyQuest,
          PrefetchHooks Function()
        > {
  $$DailyQuestsTableTableManager(_$AppDatabase db, $DailyQuestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyQuestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyQuestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyQuestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> dateKey = const Value.absent(),
                Value<QuestType> type = const Value.absent(),
                Value<int> target = const Value.absent(),
                Value<int> rewardXp = const Value.absent(),
                Value<int> rewardGold = const Value.absent(),
                Value<bool> claimed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyQuestsCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                dateKey: dateKey,
                type: type,
                target: target,
                rewardXp: rewardXp,
                rewardGold: rewardGold,
                claimed: claimed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String dateKey,
                required QuestType type,
                required int target,
                required int rewardXp,
                required int rewardGold,
                Value<bool> claimed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyQuestsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                dateKey: dateKey,
                type: type,
                target: target,
                rewardXp: rewardXp,
                rewardGold: rewardGold,
                claimed: claimed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyQuestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyQuestsTable,
      DailyQuest,
      $$DailyQuestsTableFilterComposer,
      $$DailyQuestsTableOrderingComposer,
      $$DailyQuestsTableAnnotationComposer,
      $$DailyQuestsTableCreateCompanionBuilder,
      $$DailyQuestsTableUpdateCompanionBuilder,
      (
        DailyQuest,
        BaseReferences<_$AppDatabase, $DailyQuestsTable, DailyQuest>,
      ),
      DailyQuest,
      PrefetchHooks Function()
    >;
typedef $$UserAchievementsTableCreateCompanionBuilder =
    UserAchievementsCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<DateTime> unlockedAt,
      Value<int> rowid,
    });
typedef $$UserAchievementsTableUpdateCompanionBuilder =
    UserAchievementsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<DateTime> unlockedAt,
      Value<int> rowid,
    });

class $$UserAchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $UserAchievementsTable> {
  $$UserAchievementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserAchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserAchievementsTable> {
  $$UserAchievementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserAchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserAchievementsTable> {
  $$UserAchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$UserAchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserAchievementsTable,
          UserAchievement,
          $$UserAchievementsTableFilterComposer,
          $$UserAchievementsTableOrderingComposer,
          $$UserAchievementsTableAnnotationComposer,
          $$UserAchievementsTableCreateCompanionBuilder,
          $$UserAchievementsTableUpdateCompanionBuilder,
          (
            UserAchievement,
            BaseReferences<
              _$AppDatabase,
              $UserAchievementsTable,
              UserAchievement
            >,
          ),
          UserAchievement,
          PrefetchHooks Function()
        > {
  $$UserAchievementsTableTableManager(
    _$AppDatabase db,
    $UserAchievementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserAchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserAchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserAchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<DateTime> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserAchievementsCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<DateTime> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserAchievementsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserAchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserAchievementsTable,
      UserAchievement,
      $$UserAchievementsTableFilterComposer,
      $$UserAchievementsTableOrderingComposer,
      $$UserAchievementsTableAnnotationComposer,
      $$UserAchievementsTableCreateCompanionBuilder,
      $$UserAchievementsTableUpdateCompanionBuilder,
      (
        UserAchievement,
        BaseReferences<_$AppDatabase, $UserAchievementsTable, UserAchievement>,
      ),
      UserAchievement,
      PrefetchHooks Function()
    >;
typedef $$InventoryItemsTableCreateCompanionBuilder =
    InventoryItemsCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<DateTime> acquiredAt,
      Value<bool> equipped,
      Value<int> rowid,
    });
typedef $$InventoryItemsTableUpdateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<DateTime> acquiredAt,
      Value<bool> equipped,
      Value<int> rowid,
    });

class $$InventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get equipped => $composableBuilder(
    column: $table.equipped,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get equipped => $composableBuilder(
    column: $table.equipped,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get equipped =>
      $composableBuilder(column: $table.equipped, builder: (column) => column);
}

class $$InventoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryItemsTable,
          InventoryItem,
          $$InventoryItemsTableFilterComposer,
          $$InventoryItemsTableOrderingComposer,
          $$InventoryItemsTableAnnotationComposer,
          $$InventoryItemsTableCreateCompanionBuilder,
          $$InventoryItemsTableUpdateCompanionBuilder,
          (
            InventoryItem,
            BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>,
          ),
          InventoryItem,
          PrefetchHooks Function()
        > {
  $$InventoryItemsTableTableManager(
    _$AppDatabase db,
    $InventoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<DateTime> acquiredAt = const Value.absent(),
                Value<bool> equipped = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                acquiredAt: acquiredAt,
                equipped: equipped,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<DateTime> acquiredAt = const Value.absent(),
                Value<bool> equipped = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                acquiredAt: acquiredAt,
                equipped: equipped,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryItemsTable,
      InventoryItem,
      $$InventoryItemsTableFilterComposer,
      $$InventoryItemsTableOrderingComposer,
      $$InventoryItemsTableAnnotationComposer,
      $$InventoryItemsTableCreateCompanionBuilder,
      $$InventoryItemsTableUpdateCompanionBuilder,
      (
        InventoryItem,
        BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>,
      ),
      InventoryItem,
      PrefetchHooks Function()
    >;
typedef $$SleepLogsTableCreateCompanionBuilder =
    SleepLogsCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      required String dateKey,
      required DateTime bedTime,
      required DateTime wakeTime,
      Value<String?> note,
      Value<int> xpAwarded,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$SleepLogsTableUpdateCompanionBuilder =
    SleepLogsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> dateKey,
      Value<DateTime> bedTime,
      Value<DateTime> wakeTime,
      Value<String?> note,
      Value<int> xpAwarded,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SleepLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bedTime => $composableBuilder(
    column: $table.bedTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get wakeTime => $composableBuilder(
    column: $table.wakeTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpAwarded => $composableBuilder(
    column: $table.xpAwarded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SleepLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bedTime => $composableBuilder(
    column: $table.bedTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get wakeTime => $composableBuilder(
    column: $table.wakeTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpAwarded => $composableBuilder(
    column: $table.xpAwarded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get dateKey =>
      $composableBuilder(column: $table.dateKey, builder: (column) => column);

  GeneratedColumn<DateTime> get bedTime =>
      $composableBuilder(column: $table.bedTime, builder: (column) => column);

  GeneratedColumn<DateTime> get wakeTime =>
      $composableBuilder(column: $table.wakeTime, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get xpAwarded =>
      $composableBuilder(column: $table.xpAwarded, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SleepLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepLogsTable,
          SleepLog,
          $$SleepLogsTableFilterComposer,
          $$SleepLogsTableOrderingComposer,
          $$SleepLogsTableAnnotationComposer,
          $$SleepLogsTableCreateCompanionBuilder,
          $$SleepLogsTableUpdateCompanionBuilder,
          (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
          SleepLog,
          PrefetchHooks Function()
        > {
  $$SleepLogsTableTableManager(_$AppDatabase db, $SleepLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> dateKey = const Value.absent(),
                Value<DateTime> bedTime = const Value.absent(),
                Value<DateTime> wakeTime = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> xpAwarded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepLogsCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                dateKey: dateKey,
                bedTime: bedTime,
                wakeTime: wakeTime,
                note: note,
                xpAwarded: xpAwarded,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String dateKey,
                required DateTime bedTime,
                required DateTime wakeTime,
                Value<String?> note = const Value.absent(),
                Value<int> xpAwarded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepLogsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                dateKey: dateKey,
                bedTime: bedTime,
                wakeTime: wakeTime,
                note: note,
                xpAwarded: xpAwarded,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SleepLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepLogsTable,
      SleepLog,
      $$SleepLogsTableFilterComposer,
      $$SleepLogsTableOrderingComposer,
      $$SleepLogsTableAnnotationComposer,
      $$SleepLogsTableCreateCompanionBuilder,
      $$SleepLogsTableUpdateCompanionBuilder,
      (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
      SleepLog,
      PrefetchHooks Function()
    >;
typedef $$CodexEntriesTableCreateCompanionBuilder =
    CodexEntriesCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<DateTime> discoveredAt,
      Value<bool> isFavorite,
      Value<int> rowid,
    });
typedef $$CodexEntriesTableUpdateCompanionBuilder =
    CodexEntriesCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<DateTime> discoveredAt,
      Value<bool> isFavorite,
      Value<int> rowid,
    });

class $$CodexEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CodexEntriesTable> {
  $$CodexEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get discoveredAt => $composableBuilder(
    column: $table.discoveredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CodexEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CodexEntriesTable> {
  $$CodexEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get discoveredAt => $composableBuilder(
    column: $table.discoveredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CodexEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CodexEntriesTable> {
  $$CodexEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<DateTime> get discoveredAt => $composableBuilder(
    column: $table.discoveredAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );
}

class $$CodexEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CodexEntriesTable,
          CodexEntry,
          $$CodexEntriesTableFilterComposer,
          $$CodexEntriesTableOrderingComposer,
          $$CodexEntriesTableAnnotationComposer,
          $$CodexEntriesTableCreateCompanionBuilder,
          $$CodexEntriesTableUpdateCompanionBuilder,
          (
            CodexEntry,
            BaseReferences<_$AppDatabase, $CodexEntriesTable, CodexEntry>,
          ),
          CodexEntry,
          PrefetchHooks Function()
        > {
  $$CodexEntriesTableTableManager(_$AppDatabase db, $CodexEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CodexEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CodexEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CodexEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<DateTime> discoveredAt = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CodexEntriesCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                discoveredAt: discoveredAt,
                isFavorite: isFavorite,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<DateTime> discoveredAt = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CodexEntriesCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                discoveredAt: discoveredAt,
                isFavorite: isFavorite,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CodexEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CodexEntriesTable,
      CodexEntry,
      $$CodexEntriesTableFilterComposer,
      $$CodexEntriesTableOrderingComposer,
      $$CodexEntriesTableAnnotationComposer,
      $$CodexEntriesTableCreateCompanionBuilder,
      $$CodexEntriesTableUpdateCompanionBuilder,
      (
        CodexEntry,
        BaseReferences<_$AppDatabase, $CodexEntriesTable, CodexEntry>,
      ),
      CodexEntry,
      PrefetchHooks Function()
    >;
typedef $$StatSnapshotsTableCreateCompanionBuilder =
    StatSnapshotsCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      required String dateKey,
      Value<int> totalXp,
      Value<int> lifetimeXp,
      Value<int> level,
      Value<int> gold,
      Value<int> gems,
      Value<int> tasksDone,
      Value<int> habitsLogged,
      Value<int> focusSessions,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$StatSnapshotsTableUpdateCompanionBuilder =
    StatSnapshotsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> dateKey,
      Value<int> totalXp,
      Value<int> lifetimeXp,
      Value<int> level,
      Value<int> gold,
      Value<int> gems,
      Value<int> tasksDone,
      Value<int> habitsLogged,
      Value<int> focusSessions,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$StatSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $StatSnapshotsTable> {
  $$StatSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lifetimeXp => $composableBuilder(
    column: $table.lifetimeXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gems => $composableBuilder(
    column: $table.gems,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tasksDone => $composableBuilder(
    column: $table.tasksDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get habitsLogged => $composableBuilder(
    column: $table.habitsLogged,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get focusSessions => $composableBuilder(
    column: $table.focusSessions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StatSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $StatSnapshotsTable> {
  $$StatSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lifetimeXp => $composableBuilder(
    column: $table.lifetimeXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gems => $composableBuilder(
    column: $table.gems,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tasksDone => $composableBuilder(
    column: $table.tasksDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get habitsLogged => $composableBuilder(
    column: $table.habitsLogged,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get focusSessions => $composableBuilder(
    column: $table.focusSessions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StatSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StatSnapshotsTable> {
  $$StatSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get dateKey =>
      $composableBuilder(column: $table.dateKey, builder: (column) => column);

  GeneratedColumn<int> get totalXp =>
      $composableBuilder(column: $table.totalXp, builder: (column) => column);

  GeneratedColumn<int> get lifetimeXp => $composableBuilder(
    column: $table.lifetimeXp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get gold =>
      $composableBuilder(column: $table.gold, builder: (column) => column);

  GeneratedColumn<int> get gems =>
      $composableBuilder(column: $table.gems, builder: (column) => column);

  GeneratedColumn<int> get tasksDone =>
      $composableBuilder(column: $table.tasksDone, builder: (column) => column);

  GeneratedColumn<int> get habitsLogged => $composableBuilder(
    column: $table.habitsLogged,
    builder: (column) => column,
  );

  GeneratedColumn<int> get focusSessions => $composableBuilder(
    column: $table.focusSessions,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$StatSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StatSnapshotsTable,
          StatSnapshot,
          $$StatSnapshotsTableFilterComposer,
          $$StatSnapshotsTableOrderingComposer,
          $$StatSnapshotsTableAnnotationComposer,
          $$StatSnapshotsTableCreateCompanionBuilder,
          $$StatSnapshotsTableUpdateCompanionBuilder,
          (
            StatSnapshot,
            BaseReferences<_$AppDatabase, $StatSnapshotsTable, StatSnapshot>,
          ),
          StatSnapshot,
          PrefetchHooks Function()
        > {
  $$StatSnapshotsTableTableManager(_$AppDatabase db, $StatSnapshotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StatSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StatSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StatSnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> dateKey = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> lifetimeXp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> gold = const Value.absent(),
                Value<int> gems = const Value.absent(),
                Value<int> tasksDone = const Value.absent(),
                Value<int> habitsLogged = const Value.absent(),
                Value<int> focusSessions = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StatSnapshotsCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                dateKey: dateKey,
                totalXp: totalXp,
                lifetimeXp: lifetimeXp,
                level: level,
                gold: gold,
                gems: gems,
                tasksDone: tasksDone,
                habitsLogged: habitsLogged,
                focusSessions: focusSessions,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String dateKey,
                Value<int> totalXp = const Value.absent(),
                Value<int> lifetimeXp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> gold = const Value.absent(),
                Value<int> gems = const Value.absent(),
                Value<int> tasksDone = const Value.absent(),
                Value<int> habitsLogged = const Value.absent(),
                Value<int> focusSessions = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StatSnapshotsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                dateKey: dateKey,
                totalXp: totalXp,
                lifetimeXp: lifetimeXp,
                level: level,
                gold: gold,
                gems: gems,
                tasksDone: tasksDone,
                habitsLogged: habitsLogged,
                focusSessions: focusSessions,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StatSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StatSnapshotsTable,
      StatSnapshot,
      $$StatSnapshotsTableFilterComposer,
      $$StatSnapshotsTableOrderingComposer,
      $$StatSnapshotsTableAnnotationComposer,
      $$StatSnapshotsTableCreateCompanionBuilder,
      $$StatSnapshotsTableUpdateCompanionBuilder,
      (
        StatSnapshot,
        BaseReferences<_$AppDatabase, $StatSnapshotsTable, StatSnapshot>,
      ),
      StatSnapshot,
      PrefetchHooks Function()
    >;
typedef $$SeasonsTableCreateCompanionBuilder =
    SeasonsCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      required int year,
      required int month,
      Value<int> xpEarned,
      Value<int> level,
      Value<String> rank,
      Value<int> tasksCompleted,
      Value<int> habitsCompleted,
      Value<int> bestStreak,
      Value<String?> topAxisName,
      Value<int> gemsAwarded,
      Value<DateTime> closedAt,
      Value<int> rowid,
    });
typedef $$SeasonsTableUpdateCompanionBuilder =
    SeasonsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<int> year,
      Value<int> month,
      Value<int> xpEarned,
      Value<int> level,
      Value<String> rank,
      Value<int> tasksCompleted,
      Value<int> habitsCompleted,
      Value<int> bestStreak,
      Value<String?> topAxisName,
      Value<int> gemsAwarded,
      Value<DateTime> closedAt,
      Value<int> rowid,
    });

class $$SeasonsTableFilterComposer
    extends Composer<_$AppDatabase, $SeasonsTable> {
  $$SeasonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tasksCompleted => $composableBuilder(
    column: $table.tasksCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get habitsCompleted => $composableBuilder(
    column: $table.habitsCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topAxisName => $composableBuilder(
    column: $table.topAxisName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gemsAwarded => $composableBuilder(
    column: $table.gemsAwarded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SeasonsTableOrderingComposer
    extends Composer<_$AppDatabase, $SeasonsTable> {
  $$SeasonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tasksCompleted => $composableBuilder(
    column: $table.tasksCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get habitsCompleted => $composableBuilder(
    column: $table.habitsCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topAxisName => $composableBuilder(
    column: $table.topAxisName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gemsAwarded => $composableBuilder(
    column: $table.gemsAwarded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SeasonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SeasonsTable> {
  $$SeasonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<int> get xpEarned =>
      $composableBuilder(column: $table.xpEarned, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);

  GeneratedColumn<int> get tasksCompleted => $composableBuilder(
    column: $table.tasksCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get habitsCompleted => $composableBuilder(
    column: $table.habitsCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<String> get topAxisName => $composableBuilder(
    column: $table.topAxisName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get gemsAwarded => $composableBuilder(
    column: $table.gemsAwarded,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);
}

class $$SeasonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SeasonsTable,
          Season,
          $$SeasonsTableFilterComposer,
          $$SeasonsTableOrderingComposer,
          $$SeasonsTableAnnotationComposer,
          $$SeasonsTableCreateCompanionBuilder,
          $$SeasonsTableUpdateCompanionBuilder,
          (Season, BaseReferences<_$AppDatabase, $SeasonsTable, Season>),
          Season,
          PrefetchHooks Function()
        > {
  $$SeasonsTableTableManager(_$AppDatabase db, $SeasonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SeasonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SeasonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SeasonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<int> month = const Value.absent(),
                Value<int> xpEarned = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<String> rank = const Value.absent(),
                Value<int> tasksCompleted = const Value.absent(),
                Value<int> habitsCompleted = const Value.absent(),
                Value<int> bestStreak = const Value.absent(),
                Value<String?> topAxisName = const Value.absent(),
                Value<int> gemsAwarded = const Value.absent(),
                Value<DateTime> closedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SeasonsCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                year: year,
                month: month,
                xpEarned: xpEarned,
                level: level,
                rank: rank,
                tasksCompleted: tasksCompleted,
                habitsCompleted: habitsCompleted,
                bestStreak: bestStreak,
                topAxisName: topAxisName,
                gemsAwarded: gemsAwarded,
                closedAt: closedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required int year,
                required int month,
                Value<int> xpEarned = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<String> rank = const Value.absent(),
                Value<int> tasksCompleted = const Value.absent(),
                Value<int> habitsCompleted = const Value.absent(),
                Value<int> bestStreak = const Value.absent(),
                Value<String?> topAxisName = const Value.absent(),
                Value<int> gemsAwarded = const Value.absent(),
                Value<DateTime> closedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SeasonsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                year: year,
                month: month,
                xpEarned: xpEarned,
                level: level,
                rank: rank,
                tasksCompleted: tasksCompleted,
                habitsCompleted: habitsCompleted,
                bestStreak: bestStreak,
                topAxisName: topAxisName,
                gemsAwarded: gemsAwarded,
                closedAt: closedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SeasonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SeasonsTable,
      Season,
      $$SeasonsTableFilterComposer,
      $$SeasonsTableOrderingComposer,
      $$SeasonsTableAnnotationComposer,
      $$SeasonsTableCreateCompanionBuilder,
      $$SeasonsTableUpdateCompanionBuilder,
      (Season, BaseReferences<_$AppDatabase, $SeasonsTable, Season>),
      Season,
      PrefetchHooks Function()
    >;
typedef $$NotesTableCreateCompanionBuilder =
    NotesCompanion Function({
      required String id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> title,
      Value<String> body,
      Value<String?> axisId,
      Value<String?> mood,
      Value<bool> pinned,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$NotesTableUpdateCompanionBuilder =
    NotesCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> dirty,
      Value<String> title,
      Value<String> body,
      Value<String?> axisId,
      Value<String?> mood,
      Value<bool> pinned,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$NotesTableReferences
    extends BaseReferences<_$AppDatabase, $NotesTable, Note> {
  $$NotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SkillAxesTable _axisIdTable(_$AppDatabase db) =>
      db.skillAxes.createAlias('notes__axis_id__skill_axes__id');

  $$SkillAxesTableProcessedTableManager? get axisId {
    final $_column = $_itemColumn<String>('axis_id');
    if ($_column == null) return null;
    final manager = $$SkillAxesTableTableManager(
      $_db,
      $_db.skillAxes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_axisIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pinned => $composableBuilder(
    column: $table.pinned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SkillAxesTableFilterComposer get axisId {
    final $$SkillAxesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.axisId,
      referencedTable: $db.skillAxes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillAxesTableFilterComposer(
            $db: $db,
            $table: $db.skillAxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pinned => $composableBuilder(
    column: $table.pinned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SkillAxesTableOrderingComposer get axisId {
    final $$SkillAxesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.axisId,
      referencedTable: $db.skillAxes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillAxesTableOrderingComposer(
            $db: $db,
            $table: $db.skillAxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<bool> get pinned =>
      $composableBuilder(column: $table.pinned, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SkillAxesTableAnnotationComposer get axisId {
    final $$SkillAxesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.axisId,
      referencedTable: $db.skillAxes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillAxesTableAnnotationComposer(
            $db: $db,
            $table: $db.skillAxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTable,
          Note,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (Note, $$NotesTableReferences),
          Note,
          PrefetchHooks Function({bool axisId})
        > {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String?> axisId = const Value.absent(),
                Value<String?> mood = const Value.absent(),
                Value<bool> pinned = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                title: title,
                body: body,
                axisId: axisId,
                mood: mood,
                pinned: pinned,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String?> axisId = const Value.absent(),
                Value<String?> mood = const Value.absent(),
                Value<bool> pinned = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                dirty: dirty,
                title: title,
                body: body,
                axisId: axisId,
                mood: mood,
                pinned: pinned,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$NotesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({axisId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (axisId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.axisId,
                                referencedTable: $$NotesTableReferences
                                    ._axisIdTable(db),
                                referencedColumn: $$NotesTableReferences
                                    ._axisIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTable,
      Note,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (Note, $$NotesTableReferences),
      Note,
      PrefetchHooks Function({bool axisId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SkillAxesTableTableManager get skillAxes =>
      $$SkillAxesTableTableManager(_db, _db.skillAxes);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitLogsTableTableManager get habitLogs =>
      $$HabitLogsTableTableManager(_db, _db.habitLogs);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$CurrencyTransactionsTableTableManager get currencyTransactions =>
      $$CurrencyTransactionsTableTableManager(_db, _db.currencyTransactions);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$GoalStepsTableTableManager get goalSteps =>
      $$GoalStepsTableTableManager(_db, _db.goalSteps);
  $$DailyQuestsTableTableManager get dailyQuests =>
      $$DailyQuestsTableTableManager(_db, _db.dailyQuests);
  $$UserAchievementsTableTableManager get userAchievements =>
      $$UserAchievementsTableTableManager(_db, _db.userAchievements);
  $$InventoryItemsTableTableManager get inventoryItems =>
      $$InventoryItemsTableTableManager(_db, _db.inventoryItems);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db, _db.sleepLogs);
  $$CodexEntriesTableTableManager get codexEntries =>
      $$CodexEntriesTableTableManager(_db, _db.codexEntries);
  $$StatSnapshotsTableTableManager get statSnapshots =>
      $$StatSnapshotsTableTableManager(_db, _db.statSnapshots);
  $$SeasonsTableTableManager get seasons =>
      $$SeasonsTableTableManager(_db, _db.seasons);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
}
