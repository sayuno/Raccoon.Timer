// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RoutineTypesTable extends RoutineTypes
    with TableInfo<$RoutineTypesTable, RoutineType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _labelPtMeta = const VerificationMeta(
    'labelPt',
  );
  @override
  late final GeneratedColumn<String> labelPt = GeneratedColumn<String>(
    'label_pt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    labelPt,
    icon,
    color,
    isSystem,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('label_pt')) {
      context.handle(
        _labelPtMeta,
        labelPt.isAcceptableOrUnknown(data['label_pt']!, _labelPtMeta),
      );
    } else if (isInserting) {
      context.missing(_labelPtMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      labelPt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_pt'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $RoutineTypesTable createAlias(String alias) {
    return $RoutineTypesTable(attachedDatabase, alias);
  }
}

class RoutineType extends DataClass implements Insertable<RoutineType> {
  final int id;
  final String name;
  final String labelPt;
  final String icon;
  final String color;
  final bool isSystem;
  final bool isActive;
  const RoutineType({
    required this.id,
    required this.name,
    required this.labelPt,
    required this.icon,
    required this.color,
    required this.isSystem,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['label_pt'] = Variable<String>(labelPt);
    map['icon'] = Variable<String>(icon);
    map['color'] = Variable<String>(color);
    map['is_system'] = Variable<bool>(isSystem);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  RoutineTypesCompanion toCompanion(bool nullToAbsent) {
    return RoutineTypesCompanion(
      id: Value(id),
      name: Value(name),
      labelPt: Value(labelPt),
      icon: Value(icon),
      color: Value(color),
      isSystem: Value(isSystem),
      isActive: Value(isActive),
    );
  }

  factory RoutineType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      labelPt: serializer.fromJson<String>(json['labelPt']),
      icon: serializer.fromJson<String>(json['icon']),
      color: serializer.fromJson<String>(json['color']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'labelPt': serializer.toJson<String>(labelPt),
      'icon': serializer.toJson<String>(icon),
      'color': serializer.toJson<String>(color),
      'isSystem': serializer.toJson<bool>(isSystem),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  RoutineType copyWith({
    int? id,
    String? name,
    String? labelPt,
    String? icon,
    String? color,
    bool? isSystem,
    bool? isActive,
  }) => RoutineType(
    id: id ?? this.id,
    name: name ?? this.name,
    labelPt: labelPt ?? this.labelPt,
    icon: icon ?? this.icon,
    color: color ?? this.color,
    isSystem: isSystem ?? this.isSystem,
    isActive: isActive ?? this.isActive,
  );
  RoutineType copyWithCompanion(RoutineTypesCompanion data) {
    return RoutineType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      labelPt: data.labelPt.present ? data.labelPt.value : this.labelPt,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('labelPt: $labelPt, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('isSystem: $isSystem, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, labelPt, icon, color, isSystem, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineType &&
          other.id == this.id &&
          other.name == this.name &&
          other.labelPt == this.labelPt &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.isSystem == this.isSystem &&
          other.isActive == this.isActive);
}

class RoutineTypesCompanion extends UpdateCompanion<RoutineType> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> labelPt;
  final Value<String> icon;
  final Value<String> color;
  final Value<bool> isSystem;
  final Value<bool> isActive;
  const RoutineTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.labelPt = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  RoutineTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String labelPt,
    required String icon,
    required String color,
    this.isSystem = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : name = Value(name),
       labelPt = Value(labelPt),
       icon = Value(icon),
       color = Value(color);
  static Insertable<RoutineType> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? labelPt,
    Expression<String>? icon,
    Expression<String>? color,
    Expression<bool>? isSystem,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (labelPt != null) 'label_pt': labelPt,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (isSystem != null) 'is_system': isSystem,
      if (isActive != null) 'is_active': isActive,
    });
  }

  RoutineTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? labelPt,
    Value<String>? icon,
    Value<String>? color,
    Value<bool>? isSystem,
    Value<bool>? isActive,
  }) {
    return RoutineTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      labelPt: labelPt ?? this.labelPt,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      isSystem: isSystem ?? this.isSystem,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (labelPt.present) {
      map['label_pt'] = Variable<String>(labelPt.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('labelPt: $labelPt, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('isSystem: $isSystem, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $SoundSourcesTable extends SoundSources
    with TableInfo<$SoundSourcesTable, SoundSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoundSourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _labelPtMeta = const VerificationMeta(
    'labelPt',
  );
  @override
  late final GeneratedColumn<String> labelPt = GeneratedColumn<String>(
    'label_pt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, labelPt, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sound_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<SoundSource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('label_pt')) {
      context.handle(
        _labelPtMeta,
        labelPt.isAcceptableOrUnknown(data['label_pt']!, _labelPtMeta),
      );
    } else if (isInserting) {
      context.missing(_labelPtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SoundSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoundSource(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      labelPt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_pt'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $SoundSourcesTable createAlias(String alias) {
    return $SoundSourcesTable(attachedDatabase, alias);
  }
}

class SoundSource extends DataClass implements Insertable<SoundSource> {
  final int id;
  final String name;
  final String labelPt;
  final bool isActive;
  const SoundSource({
    required this.id,
    required this.name,
    required this.labelPt,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['label_pt'] = Variable<String>(labelPt);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  SoundSourcesCompanion toCompanion(bool nullToAbsent) {
    return SoundSourcesCompanion(
      id: Value(id),
      name: Value(name),
      labelPt: Value(labelPt),
      isActive: Value(isActive),
    );
  }

  factory SoundSource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoundSource(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      labelPt: serializer.fromJson<String>(json['labelPt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'labelPt': serializer.toJson<String>(labelPt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  SoundSource copyWith({
    int? id,
    String? name,
    String? labelPt,
    bool? isActive,
  }) => SoundSource(
    id: id ?? this.id,
    name: name ?? this.name,
    labelPt: labelPt ?? this.labelPt,
    isActive: isActive ?? this.isActive,
  );
  SoundSource copyWithCompanion(SoundSourcesCompanion data) {
    return SoundSource(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      labelPt: data.labelPt.present ? data.labelPt.value : this.labelPt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SoundSource(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('labelPt: $labelPt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, labelPt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoundSource &&
          other.id == this.id &&
          other.name == this.name &&
          other.labelPt == this.labelPt &&
          other.isActive == this.isActive);
}

class SoundSourcesCompanion extends UpdateCompanion<SoundSource> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> labelPt;
  final Value<bool> isActive;
  const SoundSourcesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.labelPt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  SoundSourcesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String labelPt,
    this.isActive = const Value.absent(),
  }) : name = Value(name),
       labelPt = Value(labelPt);
  static Insertable<SoundSource> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? labelPt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (labelPt != null) 'label_pt': labelPt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  SoundSourcesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? labelPt,
    Value<bool>? isActive,
  }) {
    return SoundSourcesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      labelPt: labelPt ?? this.labelPt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (labelPt.present) {
      map['label_pt'] = Variable<String>(labelPt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoundSourcesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('labelPt: $labelPt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $TriggerStatusesTable extends TriggerStatuses
    with TableInfo<$TriggerStatusesTable, TriggerStatuse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TriggerStatusesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _labelPtMeta = const VerificationMeta(
    'labelPt',
  );
  @override
  late final GeneratedColumn<String> labelPt = GeneratedColumn<String>(
    'label_pt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, labelPt, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trigger_statuses';
  @override
  VerificationContext validateIntegrity(
    Insertable<TriggerStatuse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('label_pt')) {
      context.handle(
        _labelPtMeta,
        labelPt.isAcceptableOrUnknown(data['label_pt']!, _labelPtMeta),
      );
    } else if (isInserting) {
      context.missing(_labelPtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TriggerStatuse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TriggerStatuse(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      labelPt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_pt'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $TriggerStatusesTable createAlias(String alias) {
    return $TriggerStatusesTable(attachedDatabase, alias);
  }
}

class TriggerStatuse extends DataClass implements Insertable<TriggerStatuse> {
  final int id;
  final String name;
  final String labelPt;
  final bool isActive;
  const TriggerStatuse({
    required this.id,
    required this.name,
    required this.labelPt,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['label_pt'] = Variable<String>(labelPt);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  TriggerStatusesCompanion toCompanion(bool nullToAbsent) {
    return TriggerStatusesCompanion(
      id: Value(id),
      name: Value(name),
      labelPt: Value(labelPt),
      isActive: Value(isActive),
    );
  }

  factory TriggerStatuse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TriggerStatuse(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      labelPt: serializer.fromJson<String>(json['labelPt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'labelPt': serializer.toJson<String>(labelPt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  TriggerStatuse copyWith({
    int? id,
    String? name,
    String? labelPt,
    bool? isActive,
  }) => TriggerStatuse(
    id: id ?? this.id,
    name: name ?? this.name,
    labelPt: labelPt ?? this.labelPt,
    isActive: isActive ?? this.isActive,
  );
  TriggerStatuse copyWithCompanion(TriggerStatusesCompanion data) {
    return TriggerStatuse(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      labelPt: data.labelPt.present ? data.labelPt.value : this.labelPt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TriggerStatuse(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('labelPt: $labelPt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, labelPt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TriggerStatuse &&
          other.id == this.id &&
          other.name == this.name &&
          other.labelPt == this.labelPt &&
          other.isActive == this.isActive);
}

class TriggerStatusesCompanion extends UpdateCompanion<TriggerStatuse> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> labelPt;
  final Value<bool> isActive;
  const TriggerStatusesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.labelPt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  TriggerStatusesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String labelPt,
    this.isActive = const Value.absent(),
  }) : name = Value(name),
       labelPt = Value(labelPt);
  static Insertable<TriggerStatuse> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? labelPt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (labelPt != null) 'label_pt': labelPt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  TriggerStatusesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? labelPt,
    Value<bool>? isActive,
  }) {
    return TriggerStatusesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      labelPt: labelPt ?? this.labelPt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (labelPt.present) {
      map['label_pt'] = Variable<String>(labelPt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TriggerStatusesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('labelPt: $labelPt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $RoutinesTable extends Routines with TableInfo<$RoutinesTable, Routine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routine_types (id)',
    ),
  );
  static const VerificationMeta _scheduleModeMeta = const VerificationMeta(
    'scheduleMode',
  );
  @override
  late final GeneratedColumn<String> scheduleMode = GeneratedColumn<String>(
    'schedule_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _oneShotAtMeta = const VerificationMeta(
    'oneShotAt',
  );
  @override
  late final GeneratedColumn<int> oneShotAt = GeneratedColumn<int>(
    'one_shot_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _atTimeMeta = const VerificationMeta('atTime');
  @override
  late final GeneratedColumn<String> atTime = GeneratedColumn<String>(
    'at_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intervalHoursMeta = const VerificationMeta(
    'intervalHours',
  );
  @override
  late final GeneratedColumn<int> intervalHours = GeneratedColumn<int>(
    'interval_hours',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intervalMinutesMeta = const VerificationMeta(
    'intervalMinutes',
  );
  @override
  late final GeneratedColumn<int> intervalMinutes = GeneratedColumn<int>(
    'interval_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _windowStartMeta = const VerificationMeta(
    'windowStart',
  );
  @override
  late final GeneratedColumn<String> windowStart = GeneratedColumn<String>(
    'window_start',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _windowEndMeta = const VerificationMeta(
    'windowEnd',
  );
  @override
  late final GeneratedColumn<String> windowEnd = GeneratedColumn<String>(
    'window_end',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weekdaysMaskMeta = const VerificationMeta(
    'weekdaysMask',
  );
  @override
  late final GeneratedColumn<int> weekdaysMask = GeneratedColumn<int>(
    'weekdays_mask',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _soundSourceIdMeta = const VerificationMeta(
    'soundSourceId',
  );
  @override
  late final GeneratedColumn<int> soundSourceId = GeneratedColumn<int>(
    'sound_source_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sound_sources (id)',
    ),
  );
  static const VerificationMeta _soundRefMeta = const VerificationMeta(
    'soundRef',
  );
  @override
  late final GeneratedColumn<String> soundRef = GeneratedColumn<String>(
    'sound_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _soundLabelMeta = const VerificationMeta(
    'soundLabel',
  );
  @override
  late final GeneratedColumn<String> soundLabel = GeneratedColumn<String>(
    'sound_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<int> volume = GeneratedColumn<int>(
    'volume',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(80),
  );
  static const VerificationMeta _fadeInMeta = const VerificationMeta('fadeIn');
  @override
  late final GeneratedColumn<bool> fadeIn = GeneratedColumn<bool>(
    'fade_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("fade_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _nextTriggerAtMeta = const VerificationMeta(
    'nextTriggerAt',
  );
  @override
  late final GeneratedColumn<int> nextTriggerAt = GeneratedColumn<int>(
    'next_trigger_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _snoozeUntilMeta = const VerificationMeta(
    'snoozeUntil',
  );
  @override
  late final GeneratedColumn<int> snoozeUntil = GeneratedColumn<int>(
    'snooze_until',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    typeId,
    scheduleMode,
    oneShotAt,
    atTime,
    intervalHours,
    intervalMinutes,
    windowStart,
    windowEnd,
    weekdaysMask,
    soundSourceId,
    soundRef,
    soundLabel,
    volume,
    fadeIn,
    isEnabled,
    nextTriggerAt,
    snoozeUntil,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<Routine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('schedule_mode')) {
      context.handle(
        _scheduleModeMeta,
        scheduleMode.isAcceptableOrUnknown(
          data['schedule_mode']!,
          _scheduleModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleModeMeta);
    }
    if (data.containsKey('one_shot_at')) {
      context.handle(
        _oneShotAtMeta,
        oneShotAt.isAcceptableOrUnknown(data['one_shot_at']!, _oneShotAtMeta),
      );
    }
    if (data.containsKey('at_time')) {
      context.handle(
        _atTimeMeta,
        atTime.isAcceptableOrUnknown(data['at_time']!, _atTimeMeta),
      );
    }
    if (data.containsKey('interval_hours')) {
      context.handle(
        _intervalHoursMeta,
        intervalHours.isAcceptableOrUnknown(
          data['interval_hours']!,
          _intervalHoursMeta,
        ),
      );
    }
    if (data.containsKey('interval_minutes')) {
      context.handle(
        _intervalMinutesMeta,
        intervalMinutes.isAcceptableOrUnknown(
          data['interval_minutes']!,
          _intervalMinutesMeta,
        ),
      );
    }
    if (data.containsKey('window_start')) {
      context.handle(
        _windowStartMeta,
        windowStart.isAcceptableOrUnknown(
          data['window_start']!,
          _windowStartMeta,
        ),
      );
    }
    if (data.containsKey('window_end')) {
      context.handle(
        _windowEndMeta,
        windowEnd.isAcceptableOrUnknown(data['window_end']!, _windowEndMeta),
      );
    }
    if (data.containsKey('weekdays_mask')) {
      context.handle(
        _weekdaysMaskMeta,
        weekdaysMask.isAcceptableOrUnknown(
          data['weekdays_mask']!,
          _weekdaysMaskMeta,
        ),
      );
    }
    if (data.containsKey('sound_source_id')) {
      context.handle(
        _soundSourceIdMeta,
        soundSourceId.isAcceptableOrUnknown(
          data['sound_source_id']!,
          _soundSourceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_soundSourceIdMeta);
    }
    if (data.containsKey('sound_ref')) {
      context.handle(
        _soundRefMeta,
        soundRef.isAcceptableOrUnknown(data['sound_ref']!, _soundRefMeta),
      );
    }
    if (data.containsKey('sound_label')) {
      context.handle(
        _soundLabelMeta,
        soundLabel.isAcceptableOrUnknown(data['sound_label']!, _soundLabelMeta),
      );
    }
    if (data.containsKey('volume')) {
      context.handle(
        _volumeMeta,
        volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta),
      );
    }
    if (data.containsKey('fade_in')) {
      context.handle(
        _fadeInMeta,
        fadeIn.isAcceptableOrUnknown(data['fade_in']!, _fadeInMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('next_trigger_at')) {
      context.handle(
        _nextTriggerAtMeta,
        nextTriggerAt.isAcceptableOrUnknown(
          data['next_trigger_at']!,
          _nextTriggerAtMeta,
        ),
      );
    }
    if (data.containsKey('snooze_until')) {
      context.handle(
        _snoozeUntilMeta,
        snoozeUntil.isAcceptableOrUnknown(
          data['snooze_until']!,
          _snoozeUntilMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Routine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Routine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
      scheduleMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_mode'],
      )!,
      oneShotAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}one_shot_at'],
      ),
      atTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}at_time'],
      ),
      intervalHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_hours'],
      ),
      intervalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_minutes'],
      ),
      windowStart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}window_start'],
      ),
      windowEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}window_end'],
      ),
      weekdaysMask: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekdays_mask'],
      ),
      soundSourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sound_source_id'],
      )!,
      soundRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sound_ref'],
      ),
      soundLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sound_label'],
      ),
      volume: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}volume'],
      )!,
      fadeIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}fade_in'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      nextTriggerAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_trigger_at'],
      ),
      snoozeUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snooze_until'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }
}

class Routine extends DataClass implements Insertable<Routine> {
  final int id;
  final String name;
  final int typeId;

  /// 'one_shot' | 'interval' | 'daily'
  final String scheduleMode;
  final int? oneShotAt;
  final String? atTime;
  final int? intervalHours;
  final int? intervalMinutes;
  final String? windowStart;
  final String? windowEnd;
  final int? weekdaysMask;
  final int soundSourceId;
  final String? soundRef;
  final String? soundLabel;
  final int volume;
  final bool fadeIn;
  final bool isEnabled;
  final int? nextTriggerAt;
  final int? snoozeUntil;
  final bool isActive;
  final int createdAt;
  final int updatedAt;
  const Routine({
    required this.id,
    required this.name,
    required this.typeId,
    required this.scheduleMode,
    this.oneShotAt,
    this.atTime,
    this.intervalHours,
    this.intervalMinutes,
    this.windowStart,
    this.windowEnd,
    this.weekdaysMask,
    required this.soundSourceId,
    this.soundRef,
    this.soundLabel,
    required this.volume,
    required this.fadeIn,
    required this.isEnabled,
    this.nextTriggerAt,
    this.snoozeUntil,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type_id'] = Variable<int>(typeId);
    map['schedule_mode'] = Variable<String>(scheduleMode);
    if (!nullToAbsent || oneShotAt != null) {
      map['one_shot_at'] = Variable<int>(oneShotAt);
    }
    if (!nullToAbsent || atTime != null) {
      map['at_time'] = Variable<String>(atTime);
    }
    if (!nullToAbsent || intervalHours != null) {
      map['interval_hours'] = Variable<int>(intervalHours);
    }
    if (!nullToAbsent || intervalMinutes != null) {
      map['interval_minutes'] = Variable<int>(intervalMinutes);
    }
    if (!nullToAbsent || windowStart != null) {
      map['window_start'] = Variable<String>(windowStart);
    }
    if (!nullToAbsent || windowEnd != null) {
      map['window_end'] = Variable<String>(windowEnd);
    }
    if (!nullToAbsent || weekdaysMask != null) {
      map['weekdays_mask'] = Variable<int>(weekdaysMask);
    }
    map['sound_source_id'] = Variable<int>(soundSourceId);
    if (!nullToAbsent || soundRef != null) {
      map['sound_ref'] = Variable<String>(soundRef);
    }
    if (!nullToAbsent || soundLabel != null) {
      map['sound_label'] = Variable<String>(soundLabel);
    }
    map['volume'] = Variable<int>(volume);
    map['fade_in'] = Variable<bool>(fadeIn);
    map['is_enabled'] = Variable<bool>(isEnabled);
    if (!nullToAbsent || nextTriggerAt != null) {
      map['next_trigger_at'] = Variable<int>(nextTriggerAt);
    }
    if (!nullToAbsent || snoozeUntil != null) {
      map['snooze_until'] = Variable<int>(snoozeUntil);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      name: Value(name),
      typeId: Value(typeId),
      scheduleMode: Value(scheduleMode),
      oneShotAt: oneShotAt == null && nullToAbsent
          ? const Value.absent()
          : Value(oneShotAt),
      atTime: atTime == null && nullToAbsent
          ? const Value.absent()
          : Value(atTime),
      intervalHours: intervalHours == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalHours),
      intervalMinutes: intervalMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalMinutes),
      windowStart: windowStart == null && nullToAbsent
          ? const Value.absent()
          : Value(windowStart),
      windowEnd: windowEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(windowEnd),
      weekdaysMask: weekdaysMask == null && nullToAbsent
          ? const Value.absent()
          : Value(weekdaysMask),
      soundSourceId: Value(soundSourceId),
      soundRef: soundRef == null && nullToAbsent
          ? const Value.absent()
          : Value(soundRef),
      soundLabel: soundLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(soundLabel),
      volume: Value(volume),
      fadeIn: Value(fadeIn),
      isEnabled: Value(isEnabled),
      nextTriggerAt: nextTriggerAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextTriggerAt),
      snoozeUntil: snoozeUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozeUntil),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Routine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Routine(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      typeId: serializer.fromJson<int>(json['typeId']),
      scheduleMode: serializer.fromJson<String>(json['scheduleMode']),
      oneShotAt: serializer.fromJson<int?>(json['oneShotAt']),
      atTime: serializer.fromJson<String?>(json['atTime']),
      intervalHours: serializer.fromJson<int?>(json['intervalHours']),
      intervalMinutes: serializer.fromJson<int?>(json['intervalMinutes']),
      windowStart: serializer.fromJson<String?>(json['windowStart']),
      windowEnd: serializer.fromJson<String?>(json['windowEnd']),
      weekdaysMask: serializer.fromJson<int?>(json['weekdaysMask']),
      soundSourceId: serializer.fromJson<int>(json['soundSourceId']),
      soundRef: serializer.fromJson<String?>(json['soundRef']),
      soundLabel: serializer.fromJson<String?>(json['soundLabel']),
      volume: serializer.fromJson<int>(json['volume']),
      fadeIn: serializer.fromJson<bool>(json['fadeIn']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      nextTriggerAt: serializer.fromJson<int?>(json['nextTriggerAt']),
      snoozeUntil: serializer.fromJson<int?>(json['snoozeUntil']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'typeId': serializer.toJson<int>(typeId),
      'scheduleMode': serializer.toJson<String>(scheduleMode),
      'oneShotAt': serializer.toJson<int?>(oneShotAt),
      'atTime': serializer.toJson<String?>(atTime),
      'intervalHours': serializer.toJson<int?>(intervalHours),
      'intervalMinutes': serializer.toJson<int?>(intervalMinutes),
      'windowStart': serializer.toJson<String?>(windowStart),
      'windowEnd': serializer.toJson<String?>(windowEnd),
      'weekdaysMask': serializer.toJson<int?>(weekdaysMask),
      'soundSourceId': serializer.toJson<int>(soundSourceId),
      'soundRef': serializer.toJson<String?>(soundRef),
      'soundLabel': serializer.toJson<String?>(soundLabel),
      'volume': serializer.toJson<int>(volume),
      'fadeIn': serializer.toJson<bool>(fadeIn),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'nextTriggerAt': serializer.toJson<int?>(nextTriggerAt),
      'snoozeUntil': serializer.toJson<int?>(snoozeUntil),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  Routine copyWith({
    int? id,
    String? name,
    int? typeId,
    String? scheduleMode,
    Value<int?> oneShotAt = const Value.absent(),
    Value<String?> atTime = const Value.absent(),
    Value<int?> intervalHours = const Value.absent(),
    Value<int?> intervalMinutes = const Value.absent(),
    Value<String?> windowStart = const Value.absent(),
    Value<String?> windowEnd = const Value.absent(),
    Value<int?> weekdaysMask = const Value.absent(),
    int? soundSourceId,
    Value<String?> soundRef = const Value.absent(),
    Value<String?> soundLabel = const Value.absent(),
    int? volume,
    bool? fadeIn,
    bool? isEnabled,
    Value<int?> nextTriggerAt = const Value.absent(),
    Value<int?> snoozeUntil = const Value.absent(),
    bool? isActive,
    int? createdAt,
    int? updatedAt,
  }) => Routine(
    id: id ?? this.id,
    name: name ?? this.name,
    typeId: typeId ?? this.typeId,
    scheduleMode: scheduleMode ?? this.scheduleMode,
    oneShotAt: oneShotAt.present ? oneShotAt.value : this.oneShotAt,
    atTime: atTime.present ? atTime.value : this.atTime,
    intervalHours: intervalHours.present
        ? intervalHours.value
        : this.intervalHours,
    intervalMinutes: intervalMinutes.present
        ? intervalMinutes.value
        : this.intervalMinutes,
    windowStart: windowStart.present ? windowStart.value : this.windowStart,
    windowEnd: windowEnd.present ? windowEnd.value : this.windowEnd,
    weekdaysMask: weekdaysMask.present ? weekdaysMask.value : this.weekdaysMask,
    soundSourceId: soundSourceId ?? this.soundSourceId,
    soundRef: soundRef.present ? soundRef.value : this.soundRef,
    soundLabel: soundLabel.present ? soundLabel.value : this.soundLabel,
    volume: volume ?? this.volume,
    fadeIn: fadeIn ?? this.fadeIn,
    isEnabled: isEnabled ?? this.isEnabled,
    nextTriggerAt: nextTriggerAt.present
        ? nextTriggerAt.value
        : this.nextTriggerAt,
    snoozeUntil: snoozeUntil.present ? snoozeUntil.value : this.snoozeUntil,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Routine copyWithCompanion(RoutinesCompanion data) {
    return Routine(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      scheduleMode: data.scheduleMode.present
          ? data.scheduleMode.value
          : this.scheduleMode,
      oneShotAt: data.oneShotAt.present ? data.oneShotAt.value : this.oneShotAt,
      atTime: data.atTime.present ? data.atTime.value : this.atTime,
      intervalHours: data.intervalHours.present
          ? data.intervalHours.value
          : this.intervalHours,
      intervalMinutes: data.intervalMinutes.present
          ? data.intervalMinutes.value
          : this.intervalMinutes,
      windowStart: data.windowStart.present
          ? data.windowStart.value
          : this.windowStart,
      windowEnd: data.windowEnd.present ? data.windowEnd.value : this.windowEnd,
      weekdaysMask: data.weekdaysMask.present
          ? data.weekdaysMask.value
          : this.weekdaysMask,
      soundSourceId: data.soundSourceId.present
          ? data.soundSourceId.value
          : this.soundSourceId,
      soundRef: data.soundRef.present ? data.soundRef.value : this.soundRef,
      soundLabel: data.soundLabel.present
          ? data.soundLabel.value
          : this.soundLabel,
      volume: data.volume.present ? data.volume.value : this.volume,
      fadeIn: data.fadeIn.present ? data.fadeIn.value : this.fadeIn,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      nextTriggerAt: data.nextTriggerAt.present
          ? data.nextTriggerAt.value
          : this.nextTriggerAt,
      snoozeUntil: data.snoozeUntil.present
          ? data.snoozeUntil.value
          : this.snoozeUntil,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Routine(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('typeId: $typeId, ')
          ..write('scheduleMode: $scheduleMode, ')
          ..write('oneShotAt: $oneShotAt, ')
          ..write('atTime: $atTime, ')
          ..write('intervalHours: $intervalHours, ')
          ..write('intervalMinutes: $intervalMinutes, ')
          ..write('windowStart: $windowStart, ')
          ..write('windowEnd: $windowEnd, ')
          ..write('weekdaysMask: $weekdaysMask, ')
          ..write('soundSourceId: $soundSourceId, ')
          ..write('soundRef: $soundRef, ')
          ..write('soundLabel: $soundLabel, ')
          ..write('volume: $volume, ')
          ..write('fadeIn: $fadeIn, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('nextTriggerAt: $nextTriggerAt, ')
          ..write('snoozeUntil: $snoozeUntil, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    typeId,
    scheduleMode,
    oneShotAt,
    atTime,
    intervalHours,
    intervalMinutes,
    windowStart,
    windowEnd,
    weekdaysMask,
    soundSourceId,
    soundRef,
    soundLabel,
    volume,
    fadeIn,
    isEnabled,
    nextTriggerAt,
    snoozeUntil,
    isActive,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Routine &&
          other.id == this.id &&
          other.name == this.name &&
          other.typeId == this.typeId &&
          other.scheduleMode == this.scheduleMode &&
          other.oneShotAt == this.oneShotAt &&
          other.atTime == this.atTime &&
          other.intervalHours == this.intervalHours &&
          other.intervalMinutes == this.intervalMinutes &&
          other.windowStart == this.windowStart &&
          other.windowEnd == this.windowEnd &&
          other.weekdaysMask == this.weekdaysMask &&
          other.soundSourceId == this.soundSourceId &&
          other.soundRef == this.soundRef &&
          other.soundLabel == this.soundLabel &&
          other.volume == this.volume &&
          other.fadeIn == this.fadeIn &&
          other.isEnabled == this.isEnabled &&
          other.nextTriggerAt == this.nextTriggerAt &&
          other.snoozeUntil == this.snoozeUntil &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RoutinesCompanion extends UpdateCompanion<Routine> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> typeId;
  final Value<String> scheduleMode;
  final Value<int?> oneShotAt;
  final Value<String?> atTime;
  final Value<int?> intervalHours;
  final Value<int?> intervalMinutes;
  final Value<String?> windowStart;
  final Value<String?> windowEnd;
  final Value<int?> weekdaysMask;
  final Value<int> soundSourceId;
  final Value<String?> soundRef;
  final Value<String?> soundLabel;
  final Value<int> volume;
  final Value<bool> fadeIn;
  final Value<bool> isEnabled;
  final Value<int?> nextTriggerAt;
  final Value<int?> snoozeUntil;
  final Value<bool> isActive;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.typeId = const Value.absent(),
    this.scheduleMode = const Value.absent(),
    this.oneShotAt = const Value.absent(),
    this.atTime = const Value.absent(),
    this.intervalHours = const Value.absent(),
    this.intervalMinutes = const Value.absent(),
    this.windowStart = const Value.absent(),
    this.windowEnd = const Value.absent(),
    this.weekdaysMask = const Value.absent(),
    this.soundSourceId = const Value.absent(),
    this.soundRef = const Value.absent(),
    this.soundLabel = const Value.absent(),
    this.volume = const Value.absent(),
    this.fadeIn = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.nextTriggerAt = const Value.absent(),
    this.snoozeUntil = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RoutinesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int typeId,
    required String scheduleMode,
    this.oneShotAt = const Value.absent(),
    this.atTime = const Value.absent(),
    this.intervalHours = const Value.absent(),
    this.intervalMinutes = const Value.absent(),
    this.windowStart = const Value.absent(),
    this.windowEnd = const Value.absent(),
    this.weekdaysMask = const Value.absent(),
    required int soundSourceId,
    this.soundRef = const Value.absent(),
    this.soundLabel = const Value.absent(),
    this.volume = const Value.absent(),
    this.fadeIn = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.nextTriggerAt = const Value.absent(),
    this.snoozeUntil = const Value.absent(),
    this.isActive = const Value.absent(),
    required int createdAt,
    required int updatedAt,
  }) : name = Value(name),
       typeId = Value(typeId),
       scheduleMode = Value(scheduleMode),
       soundSourceId = Value(soundSourceId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Routine> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? typeId,
    Expression<String>? scheduleMode,
    Expression<int>? oneShotAt,
    Expression<String>? atTime,
    Expression<int>? intervalHours,
    Expression<int>? intervalMinutes,
    Expression<String>? windowStart,
    Expression<String>? windowEnd,
    Expression<int>? weekdaysMask,
    Expression<int>? soundSourceId,
    Expression<String>? soundRef,
    Expression<String>? soundLabel,
    Expression<int>? volume,
    Expression<bool>? fadeIn,
    Expression<bool>? isEnabled,
    Expression<int>? nextTriggerAt,
    Expression<int>? snoozeUntil,
    Expression<bool>? isActive,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (typeId != null) 'type_id': typeId,
      if (scheduleMode != null) 'schedule_mode': scheduleMode,
      if (oneShotAt != null) 'one_shot_at': oneShotAt,
      if (atTime != null) 'at_time': atTime,
      if (intervalHours != null) 'interval_hours': intervalHours,
      if (intervalMinutes != null) 'interval_minutes': intervalMinutes,
      if (windowStart != null) 'window_start': windowStart,
      if (windowEnd != null) 'window_end': windowEnd,
      if (weekdaysMask != null) 'weekdays_mask': weekdaysMask,
      if (soundSourceId != null) 'sound_source_id': soundSourceId,
      if (soundRef != null) 'sound_ref': soundRef,
      if (soundLabel != null) 'sound_label': soundLabel,
      if (volume != null) 'volume': volume,
      if (fadeIn != null) 'fade_in': fadeIn,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (nextTriggerAt != null) 'next_trigger_at': nextTriggerAt,
      if (snoozeUntil != null) 'snooze_until': snoozeUntil,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RoutinesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? typeId,
    Value<String>? scheduleMode,
    Value<int?>? oneShotAt,
    Value<String?>? atTime,
    Value<int?>? intervalHours,
    Value<int?>? intervalMinutes,
    Value<String?>? windowStart,
    Value<String?>? windowEnd,
    Value<int?>? weekdaysMask,
    Value<int>? soundSourceId,
    Value<String?>? soundRef,
    Value<String?>? soundLabel,
    Value<int>? volume,
    Value<bool>? fadeIn,
    Value<bool>? isEnabled,
    Value<int?>? nextTriggerAt,
    Value<int?>? snoozeUntil,
    Value<bool>? isActive,
    Value<int>? createdAt,
    Value<int>? updatedAt,
  }) {
    return RoutinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      typeId: typeId ?? this.typeId,
      scheduleMode: scheduleMode ?? this.scheduleMode,
      oneShotAt: oneShotAt ?? this.oneShotAt,
      atTime: atTime ?? this.atTime,
      intervalHours: intervalHours ?? this.intervalHours,
      intervalMinutes: intervalMinutes ?? this.intervalMinutes,
      windowStart: windowStart ?? this.windowStart,
      windowEnd: windowEnd ?? this.windowEnd,
      weekdaysMask: weekdaysMask ?? this.weekdaysMask,
      soundSourceId: soundSourceId ?? this.soundSourceId,
      soundRef: soundRef ?? this.soundRef,
      soundLabel: soundLabel ?? this.soundLabel,
      volume: volume ?? this.volume,
      fadeIn: fadeIn ?? this.fadeIn,
      isEnabled: isEnabled ?? this.isEnabled,
      nextTriggerAt: nextTriggerAt ?? this.nextTriggerAt,
      snoozeUntil: snoozeUntil ?? this.snoozeUntil,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (scheduleMode.present) {
      map['schedule_mode'] = Variable<String>(scheduleMode.value);
    }
    if (oneShotAt.present) {
      map['one_shot_at'] = Variable<int>(oneShotAt.value);
    }
    if (atTime.present) {
      map['at_time'] = Variable<String>(atTime.value);
    }
    if (intervalHours.present) {
      map['interval_hours'] = Variable<int>(intervalHours.value);
    }
    if (intervalMinutes.present) {
      map['interval_minutes'] = Variable<int>(intervalMinutes.value);
    }
    if (windowStart.present) {
      map['window_start'] = Variable<String>(windowStart.value);
    }
    if (windowEnd.present) {
      map['window_end'] = Variable<String>(windowEnd.value);
    }
    if (weekdaysMask.present) {
      map['weekdays_mask'] = Variable<int>(weekdaysMask.value);
    }
    if (soundSourceId.present) {
      map['sound_source_id'] = Variable<int>(soundSourceId.value);
    }
    if (soundRef.present) {
      map['sound_ref'] = Variable<String>(soundRef.value);
    }
    if (soundLabel.present) {
      map['sound_label'] = Variable<String>(soundLabel.value);
    }
    if (volume.present) {
      map['volume'] = Variable<int>(volume.value);
    }
    if (fadeIn.present) {
      map['fade_in'] = Variable<bool>(fadeIn.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (nextTriggerAt.present) {
      map['next_trigger_at'] = Variable<int>(nextTriggerAt.value);
    }
    if (snoozeUntil.present) {
      map['snooze_until'] = Variable<int>(snoozeUntil.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('typeId: $typeId, ')
          ..write('scheduleMode: $scheduleMode, ')
          ..write('oneShotAt: $oneShotAt, ')
          ..write('atTime: $atTime, ')
          ..write('intervalHours: $intervalHours, ')
          ..write('intervalMinutes: $intervalMinutes, ')
          ..write('windowStart: $windowStart, ')
          ..write('windowEnd: $windowEnd, ')
          ..write('weekdaysMask: $weekdaysMask, ')
          ..write('soundSourceId: $soundSourceId, ')
          ..write('soundRef: $soundRef, ')
          ..write('soundLabel: $soundLabel, ')
          ..write('volume: $volume, ')
          ..write('fadeIn: $fadeIn, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('nextTriggerAt: $nextTriggerAt, ')
          ..write('snoozeUntil: $snoozeUntil, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TriggerLogsTable extends TriggerLogs
    with TableInfo<$TriggerLogsTable, TriggerLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TriggerLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<int> routineId = GeneratedColumn<int>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routines (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<int> scheduledAt = GeneratedColumn<int>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firedAtMeta = const VerificationMeta(
    'firedAt',
  );
  @override
  late final GeneratedColumn<int> firedAt = GeneratedColumn<int>(
    'fired_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusIdMeta = const VerificationMeta(
    'statusId',
  );
  @override
  late final GeneratedColumn<int> statusId = GeneratedColumn<int>(
    'status_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trigger_statuses (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    scheduledAt,
    firedAt,
    statusId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trigger_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<TriggerLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('fired_at')) {
      context.handle(
        _firedAtMeta,
        firedAt.isAcceptableOrUnknown(data['fired_at']!, _firedAtMeta),
      );
    }
    if (data.containsKey('status_id')) {
      context.handle(
        _statusIdMeta,
        statusId.isAcceptableOrUnknown(data['status_id']!, _statusIdMeta),
      );
    } else if (isInserting) {
      context.missing(_statusIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TriggerLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TriggerLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}routine_id'],
      )!,
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scheduled_at'],
      )!,
      firedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fired_at'],
      ),
      statusId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TriggerLogsTable createAlias(String alias) {
    return $TriggerLogsTable(attachedDatabase, alias);
  }
}

class TriggerLog extends DataClass implements Insertable<TriggerLog> {
  final int id;
  final int routineId;
  final int scheduledAt;
  final int? firedAt;
  final int statusId;
  final int createdAt;
  const TriggerLog({
    required this.id,
    required this.routineId,
    required this.scheduledAt,
    this.firedAt,
    required this.statusId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['routine_id'] = Variable<int>(routineId);
    map['scheduled_at'] = Variable<int>(scheduledAt);
    if (!nullToAbsent || firedAt != null) {
      map['fired_at'] = Variable<int>(firedAt);
    }
    map['status_id'] = Variable<int>(statusId);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  TriggerLogsCompanion toCompanion(bool nullToAbsent) {
    return TriggerLogsCompanion(
      id: Value(id),
      routineId: Value(routineId),
      scheduledAt: Value(scheduledAt),
      firedAt: firedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(firedAt),
      statusId: Value(statusId),
      createdAt: Value(createdAt),
    );
  }

  factory TriggerLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TriggerLog(
      id: serializer.fromJson<int>(json['id']),
      routineId: serializer.fromJson<int>(json['routineId']),
      scheduledAt: serializer.fromJson<int>(json['scheduledAt']),
      firedAt: serializer.fromJson<int?>(json['firedAt']),
      statusId: serializer.fromJson<int>(json['statusId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routineId': serializer.toJson<int>(routineId),
      'scheduledAt': serializer.toJson<int>(scheduledAt),
      'firedAt': serializer.toJson<int?>(firedAt),
      'statusId': serializer.toJson<int>(statusId),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  TriggerLog copyWith({
    int? id,
    int? routineId,
    int? scheduledAt,
    Value<int?> firedAt = const Value.absent(),
    int? statusId,
    int? createdAt,
  }) => TriggerLog(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    firedAt: firedAt.present ? firedAt.value : this.firedAt,
    statusId: statusId ?? this.statusId,
    createdAt: createdAt ?? this.createdAt,
  );
  TriggerLog copyWithCompanion(TriggerLogsCompanion data) {
    return TriggerLog(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      firedAt: data.firedAt.present ? data.firedAt.value : this.firedAt,
      statusId: data.statusId.present ? data.statusId.value : this.statusId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TriggerLog(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('firedAt: $firedAt, ')
          ..write('statusId: $statusId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, routineId, scheduledAt, firedAt, statusId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TriggerLog &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.scheduledAt == this.scheduledAt &&
          other.firedAt == this.firedAt &&
          other.statusId == this.statusId &&
          other.createdAt == this.createdAt);
}

class TriggerLogsCompanion extends UpdateCompanion<TriggerLog> {
  final Value<int> id;
  final Value<int> routineId;
  final Value<int> scheduledAt;
  final Value<int?> firedAt;
  final Value<int> statusId;
  final Value<int> createdAt;
  const TriggerLogsCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.firedAt = const Value.absent(),
    this.statusId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TriggerLogsCompanion.insert({
    this.id = const Value.absent(),
    required int routineId,
    required int scheduledAt,
    this.firedAt = const Value.absent(),
    required int statusId,
    required int createdAt,
  }) : routineId = Value(routineId),
       scheduledAt = Value(scheduledAt),
       statusId = Value(statusId),
       createdAt = Value(createdAt);
  static Insertable<TriggerLog> custom({
    Expression<int>? id,
    Expression<int>? routineId,
    Expression<int>? scheduledAt,
    Expression<int>? firedAt,
    Expression<int>? statusId,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (firedAt != null) 'fired_at': firedAt,
      if (statusId != null) 'status_id': statusId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TriggerLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? routineId,
    Value<int>? scheduledAt,
    Value<int?>? firedAt,
    Value<int>? statusId,
    Value<int>? createdAt,
  }) {
    return TriggerLogsCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      firedAt: firedAt ?? this.firedAt,
      statusId: statusId ?? this.statusId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<int>(routineId.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<int>(scheduledAt.value);
    }
    if (firedAt.present) {
      map['fired_at'] = Variable<int>(firedAt.value);
    }
    if (statusId.present) {
      map['status_id'] = Variable<int>(statusId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TriggerLogsCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('firedAt: $firedAt, ')
          ..write('statusId: $statusId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String? value;
  const AppSetting({required this.key, this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
    };
  }

  AppSetting copyWith({
    String? key,
    Value<String?> value = const Value.absent(),
  }) => AppSetting(
    key: key ?? this.key,
    value: value.present ? value.value : this.value,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String?> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String?>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RoutineTypesTable routineTypes = $RoutineTypesTable(this);
  late final $SoundSourcesTable soundSources = $SoundSourcesTable(this);
  late final $TriggerStatusesTable triggerStatuses = $TriggerStatusesTable(
    this,
  );
  late final $RoutinesTable routines = $RoutinesTable(this);
  late final $TriggerLogsTable triggerLogs = $TriggerLogsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    routineTypes,
    soundSources,
    triggerStatuses,
    routines,
    triggerLogs,
    appSettings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'routines',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('trigger_logs', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$RoutineTypesTableCreateCompanionBuilder =
    RoutineTypesCompanion Function({
      Value<int> id,
      required String name,
      required String labelPt,
      required String icon,
      required String color,
      Value<bool> isSystem,
      Value<bool> isActive,
    });
typedef $$RoutineTypesTableUpdateCompanionBuilder =
    RoutineTypesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> labelPt,
      Value<String> icon,
      Value<String> color,
      Value<bool> isSystem,
      Value<bool> isActive,
    });

final class $$RoutineTypesTableReferences
    extends BaseReferences<_$AppDatabase, $RoutineTypesTable, RoutineType> {
  $$RoutineTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RoutinesTable, List<Routine>> _routinesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.routines,
    aliasName: 'routine_types__id__routines__type_id',
  );

  $$RoutinesTableProcessedTableManager get routinesRefs {
    final manager = $$RoutinesTableTableManager(
      $_db,
      $_db.routines,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_routinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoutineTypesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineTypesTable> {
  $$RoutineTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelPt => $composableBuilder(
    column: $table.labelPt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> routinesRefs(
    Expression<bool> Function($$RoutinesTableFilterComposer f) f,
  ) {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableFilterComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutineTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineTypesTable> {
  $$RoutineTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelPt => $composableBuilder(
    column: $table.labelPt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutineTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineTypesTable> {
  $$RoutineTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get labelPt =>
      $composableBuilder(column: $table.labelPt, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> routinesRefs<T extends Object>(
    Expression<T> Function($$RoutinesTableAnnotationComposer a) f,
  ) {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableAnnotationComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutineTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineTypesTable,
          RoutineType,
          $$RoutineTypesTableFilterComposer,
          $$RoutineTypesTableOrderingComposer,
          $$RoutineTypesTableAnnotationComposer,
          $$RoutineTypesTableCreateCompanionBuilder,
          $$RoutineTypesTableUpdateCompanionBuilder,
          (RoutineType, $$RoutineTypesTableReferences),
          RoutineType,
          PrefetchHooks Function({bool routinesRefs})
        > {
  $$RoutineTypesTableTableManager(_$AppDatabase db, $RoutineTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutineTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> labelPt = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => RoutineTypesCompanion(
                id: id,
                name: name,
                labelPt: labelPt,
                icon: icon,
                color: color,
                isSystem: isSystem,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String labelPt,
                required String icon,
                required String color,
                Value<bool> isSystem = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => RoutineTypesCompanion.insert(
                id: id,
                name: name,
                labelPt: labelPt,
                icon: icon,
                color: color,
                isSystem: isSystem,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RoutineTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routinesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (routinesRefs) db.routines],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (routinesRefs)
                    await $_getPrefetchedData<
                      RoutineType,
                      $RoutineTypesTable,
                      Routine
                    >(
                      currentTable: table,
                      referencedTable: $$RoutineTypesTableReferences
                          ._routinesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RoutineTypesTableReferences(
                            db,
                            table,
                            p0,
                          ).routinesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.typeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RoutineTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineTypesTable,
      RoutineType,
      $$RoutineTypesTableFilterComposer,
      $$RoutineTypesTableOrderingComposer,
      $$RoutineTypesTableAnnotationComposer,
      $$RoutineTypesTableCreateCompanionBuilder,
      $$RoutineTypesTableUpdateCompanionBuilder,
      (RoutineType, $$RoutineTypesTableReferences),
      RoutineType,
      PrefetchHooks Function({bool routinesRefs})
    >;
typedef $$SoundSourcesTableCreateCompanionBuilder =
    SoundSourcesCompanion Function({
      Value<int> id,
      required String name,
      required String labelPt,
      Value<bool> isActive,
    });
typedef $$SoundSourcesTableUpdateCompanionBuilder =
    SoundSourcesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> labelPt,
      Value<bool> isActive,
    });

final class $$SoundSourcesTableReferences
    extends BaseReferences<_$AppDatabase, $SoundSourcesTable, SoundSource> {
  $$SoundSourcesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RoutinesTable, List<Routine>> _routinesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.routines,
    aliasName: 'sound_sources__id__routines__sound_source_id',
  );

  $$RoutinesTableProcessedTableManager get routinesRefs {
    final manager = $$RoutinesTableTableManager(
      $_db,
      $_db.routines,
    ).filter((f) => f.soundSourceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_routinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SoundSourcesTableFilterComposer
    extends Composer<_$AppDatabase, $SoundSourcesTable> {
  $$SoundSourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelPt => $composableBuilder(
    column: $table.labelPt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> routinesRefs(
    Expression<bool> Function($$RoutinesTableFilterComposer f) f,
  ) {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.soundSourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableFilterComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SoundSourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $SoundSourcesTable> {
  $$SoundSourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelPt => $composableBuilder(
    column: $table.labelPt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SoundSourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SoundSourcesTable> {
  $$SoundSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get labelPt =>
      $composableBuilder(column: $table.labelPt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> routinesRefs<T extends Object>(
    Expression<T> Function($$RoutinesTableAnnotationComposer a) f,
  ) {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.soundSourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableAnnotationComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SoundSourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SoundSourcesTable,
          SoundSource,
          $$SoundSourcesTableFilterComposer,
          $$SoundSourcesTableOrderingComposer,
          $$SoundSourcesTableAnnotationComposer,
          $$SoundSourcesTableCreateCompanionBuilder,
          $$SoundSourcesTableUpdateCompanionBuilder,
          (SoundSource, $$SoundSourcesTableReferences),
          SoundSource,
          PrefetchHooks Function({bool routinesRefs})
        > {
  $$SoundSourcesTableTableManager(_$AppDatabase db, $SoundSourcesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SoundSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SoundSourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SoundSourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> labelPt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => SoundSourcesCompanion(
                id: id,
                name: name,
                labelPt: labelPt,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String labelPt,
                Value<bool> isActive = const Value.absent(),
              }) => SoundSourcesCompanion.insert(
                id: id,
                name: name,
                labelPt: labelPt,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SoundSourcesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routinesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (routinesRefs) db.routines],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (routinesRefs)
                    await $_getPrefetchedData<
                      SoundSource,
                      $SoundSourcesTable,
                      Routine
                    >(
                      currentTable: table,
                      referencedTable: $$SoundSourcesTableReferences
                          ._routinesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SoundSourcesTableReferences(
                            db,
                            table,
                            p0,
                          ).routinesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.soundSourceId == item.id,
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

typedef $$SoundSourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SoundSourcesTable,
      SoundSource,
      $$SoundSourcesTableFilterComposer,
      $$SoundSourcesTableOrderingComposer,
      $$SoundSourcesTableAnnotationComposer,
      $$SoundSourcesTableCreateCompanionBuilder,
      $$SoundSourcesTableUpdateCompanionBuilder,
      (SoundSource, $$SoundSourcesTableReferences),
      SoundSource,
      PrefetchHooks Function({bool routinesRefs})
    >;
typedef $$TriggerStatusesTableCreateCompanionBuilder =
    TriggerStatusesCompanion Function({
      Value<int> id,
      required String name,
      required String labelPt,
      Value<bool> isActive,
    });
typedef $$TriggerStatusesTableUpdateCompanionBuilder =
    TriggerStatusesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> labelPt,
      Value<bool> isActive,
    });

final class $$TriggerStatusesTableReferences
    extends
        BaseReferences<_$AppDatabase, $TriggerStatusesTable, TriggerStatuse> {
  $$TriggerStatusesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TriggerLogsTable, List<TriggerLog>>
  _triggerLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.triggerLogs,
    aliasName: 'trigger_statuses__id__trigger_logs__status_id',
  );

  $$TriggerLogsTableProcessedTableManager get triggerLogsRefs {
    final manager = $$TriggerLogsTableTableManager(
      $_db,
      $_db.triggerLogs,
    ).filter((f) => f.statusId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_triggerLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TriggerStatusesTableFilterComposer
    extends Composer<_$AppDatabase, $TriggerStatusesTable> {
  $$TriggerStatusesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelPt => $composableBuilder(
    column: $table.labelPt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> triggerLogsRefs(
    Expression<bool> Function($$TriggerLogsTableFilterComposer f) f,
  ) {
    final $$TriggerLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.triggerLogs,
      getReferencedColumn: (t) => t.statusId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriggerLogsTableFilterComposer(
            $db: $db,
            $table: $db.triggerLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TriggerStatusesTableOrderingComposer
    extends Composer<_$AppDatabase, $TriggerStatusesTable> {
  $$TriggerStatusesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelPt => $composableBuilder(
    column: $table.labelPt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TriggerStatusesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TriggerStatusesTable> {
  $$TriggerStatusesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get labelPt =>
      $composableBuilder(column: $table.labelPt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> triggerLogsRefs<T extends Object>(
    Expression<T> Function($$TriggerLogsTableAnnotationComposer a) f,
  ) {
    final $$TriggerLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.triggerLogs,
      getReferencedColumn: (t) => t.statusId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriggerLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.triggerLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TriggerStatusesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TriggerStatusesTable,
          TriggerStatuse,
          $$TriggerStatusesTableFilterComposer,
          $$TriggerStatusesTableOrderingComposer,
          $$TriggerStatusesTableAnnotationComposer,
          $$TriggerStatusesTableCreateCompanionBuilder,
          $$TriggerStatusesTableUpdateCompanionBuilder,
          (TriggerStatuse, $$TriggerStatusesTableReferences),
          TriggerStatuse,
          PrefetchHooks Function({bool triggerLogsRefs})
        > {
  $$TriggerStatusesTableTableManager(
    _$AppDatabase db,
    $TriggerStatusesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TriggerStatusesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TriggerStatusesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TriggerStatusesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> labelPt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => TriggerStatusesCompanion(
                id: id,
                name: name,
                labelPt: labelPt,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String labelPt,
                Value<bool> isActive = const Value.absent(),
              }) => TriggerStatusesCompanion.insert(
                id: id,
                name: name,
                labelPt: labelPt,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TriggerStatusesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({triggerLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (triggerLogsRefs) db.triggerLogs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (triggerLogsRefs)
                    await $_getPrefetchedData<
                      TriggerStatuse,
                      $TriggerStatusesTable,
                      TriggerLog
                    >(
                      currentTable: table,
                      referencedTable: $$TriggerStatusesTableReferences
                          ._triggerLogsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TriggerStatusesTableReferences(
                            db,
                            table,
                            p0,
                          ).triggerLogsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.statusId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TriggerStatusesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TriggerStatusesTable,
      TriggerStatuse,
      $$TriggerStatusesTableFilterComposer,
      $$TriggerStatusesTableOrderingComposer,
      $$TriggerStatusesTableAnnotationComposer,
      $$TriggerStatusesTableCreateCompanionBuilder,
      $$TriggerStatusesTableUpdateCompanionBuilder,
      (TriggerStatuse, $$TriggerStatusesTableReferences),
      TriggerStatuse,
      PrefetchHooks Function({bool triggerLogsRefs})
    >;
typedef $$RoutinesTableCreateCompanionBuilder =
    RoutinesCompanion Function({
      Value<int> id,
      required String name,
      required int typeId,
      required String scheduleMode,
      Value<int?> oneShotAt,
      Value<String?> atTime,
      Value<int?> intervalHours,
      Value<int?> intervalMinutes,
      Value<String?> windowStart,
      Value<String?> windowEnd,
      Value<int?> weekdaysMask,
      required int soundSourceId,
      Value<String?> soundRef,
      Value<String?> soundLabel,
      Value<int> volume,
      Value<bool> fadeIn,
      Value<bool> isEnabled,
      Value<int?> nextTriggerAt,
      Value<int?> snoozeUntil,
      Value<bool> isActive,
      required int createdAt,
      required int updatedAt,
    });
typedef $$RoutinesTableUpdateCompanionBuilder =
    RoutinesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> typeId,
      Value<String> scheduleMode,
      Value<int?> oneShotAt,
      Value<String?> atTime,
      Value<int?> intervalHours,
      Value<int?> intervalMinutes,
      Value<String?> windowStart,
      Value<String?> windowEnd,
      Value<int?> weekdaysMask,
      Value<int> soundSourceId,
      Value<String?> soundRef,
      Value<String?> soundLabel,
      Value<int> volume,
      Value<bool> fadeIn,
      Value<bool> isEnabled,
      Value<int?> nextTriggerAt,
      Value<int?> snoozeUntil,
      Value<bool> isActive,
      Value<int> createdAt,
      Value<int> updatedAt,
    });

final class $$RoutinesTableReferences
    extends BaseReferences<_$AppDatabase, $RoutinesTable, Routine> {
  $$RoutinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoutineTypesTable _typeIdTable(_$AppDatabase db) =>
      db.routineTypes.createAlias('routines__type_id__routine_types__id');

  $$RoutineTypesTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<int>('type_id')!;

    final manager = $$RoutineTypesTableTableManager(
      $_db,
      $_db.routineTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SoundSourcesTable _soundSourceIdTable(_$AppDatabase db) => db
      .soundSources
      .createAlias('routines__sound_source_id__sound_sources__id');

  $$SoundSourcesTableProcessedTableManager get soundSourceId {
    final $_column = $_itemColumn<int>('sound_source_id')!;

    final manager = $$SoundSourcesTableTableManager(
      $_db,
      $_db.soundSources,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_soundSourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TriggerLogsTable, List<TriggerLog>>
  _triggerLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.triggerLogs,
    aliasName: 'routines__id__trigger_logs__routine_id',
  );

  $$TriggerLogsTableProcessedTableManager get triggerLogsRefs {
    final manager = $$TriggerLogsTableTableManager(
      $_db,
      $_db.triggerLogs,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_triggerLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduleMode => $composableBuilder(
    column: $table.scheduleMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get oneShotAt => $composableBuilder(
    column: $table.oneShotAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get atTime => $composableBuilder(
    column: $table.atTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalHours => $composableBuilder(
    column: $table.intervalHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalMinutes => $composableBuilder(
    column: $table.intervalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get windowStart => $composableBuilder(
    column: $table.windowStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get windowEnd => $composableBuilder(
    column: $table.windowEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get soundRef => $composableBuilder(
    column: $table.soundRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get soundLabel => $composableBuilder(
    column: $table.soundLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get volume => $composableBuilder(
    column: $table.volume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get fadeIn => $composableBuilder(
    column: $table.fadeIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextTriggerAt => $composableBuilder(
    column: $table.nextTriggerAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get snoozeUntil => $composableBuilder(
    column: $table.snoozeUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RoutineTypesTableFilterComposer get typeId {
    final $$RoutineTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.routineTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTypesTableFilterComposer(
            $db: $db,
            $table: $db.routineTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SoundSourcesTableFilterComposer get soundSourceId {
    final $$SoundSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.soundSourceId,
      referencedTable: $db.soundSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoundSourcesTableFilterComposer(
            $db: $db,
            $table: $db.soundSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> triggerLogsRefs(
    Expression<bool> Function($$TriggerLogsTableFilterComposer f) f,
  ) {
    final $$TriggerLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.triggerLogs,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriggerLogsTableFilterComposer(
            $db: $db,
            $table: $db.triggerLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleMode => $composableBuilder(
    column: $table.scheduleMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get oneShotAt => $composableBuilder(
    column: $table.oneShotAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get atTime => $composableBuilder(
    column: $table.atTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalHours => $composableBuilder(
    column: $table.intervalHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalMinutes => $composableBuilder(
    column: $table.intervalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get windowStart => $composableBuilder(
    column: $table.windowStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get windowEnd => $composableBuilder(
    column: $table.windowEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get soundRef => $composableBuilder(
    column: $table.soundRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get soundLabel => $composableBuilder(
    column: $table.soundLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get volume => $composableBuilder(
    column: $table.volume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get fadeIn => $composableBuilder(
    column: $table.fadeIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextTriggerAt => $composableBuilder(
    column: $table.nextTriggerAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get snoozeUntil => $composableBuilder(
    column: $table.snoozeUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoutineTypesTableOrderingComposer get typeId {
    final $$RoutineTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.routineTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTypesTableOrderingComposer(
            $db: $db,
            $table: $db.routineTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SoundSourcesTableOrderingComposer get soundSourceId {
    final $$SoundSourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.soundSourceId,
      referencedTable: $db.soundSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoundSourcesTableOrderingComposer(
            $db: $db,
            $table: $db.soundSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get scheduleMode => $composableBuilder(
    column: $table.scheduleMode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get oneShotAt =>
      $composableBuilder(column: $table.oneShotAt, builder: (column) => column);

  GeneratedColumn<String> get atTime =>
      $composableBuilder(column: $table.atTime, builder: (column) => column);

  GeneratedColumn<int> get intervalHours => $composableBuilder(
    column: $table.intervalHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalMinutes => $composableBuilder(
    column: $table.intervalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get windowStart => $composableBuilder(
    column: $table.windowStart,
    builder: (column) => column,
  );

  GeneratedColumn<String> get windowEnd =>
      $composableBuilder(column: $table.windowEnd, builder: (column) => column);

  GeneratedColumn<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => column,
  );

  GeneratedColumn<String> get soundRef =>
      $composableBuilder(column: $table.soundRef, builder: (column) => column);

  GeneratedColumn<String> get soundLabel => $composableBuilder(
    column: $table.soundLabel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get volume =>
      $composableBuilder(column: $table.volume, builder: (column) => column);

  GeneratedColumn<bool> get fadeIn =>
      $composableBuilder(column: $table.fadeIn, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<int> get nextTriggerAt => $composableBuilder(
    column: $table.nextTriggerAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get snoozeUntil => $composableBuilder(
    column: $table.snoozeUntil,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$RoutineTypesTableAnnotationComposer get typeId {
    final $$RoutineTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.routineTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.routineTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SoundSourcesTableAnnotationComposer get soundSourceId {
    final $$SoundSourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.soundSourceId,
      referencedTable: $db.soundSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoundSourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.soundSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> triggerLogsRefs<T extends Object>(
    Expression<T> Function($$TriggerLogsTableAnnotationComposer a) f,
  ) {
    final $$TriggerLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.triggerLogs,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriggerLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.triggerLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutinesTable,
          Routine,
          $$RoutinesTableFilterComposer,
          $$RoutinesTableOrderingComposer,
          $$RoutinesTableAnnotationComposer,
          $$RoutinesTableCreateCompanionBuilder,
          $$RoutinesTableUpdateCompanionBuilder,
          (Routine, $$RoutinesTableReferences),
          Routine,
          PrefetchHooks Function({
            bool typeId,
            bool soundSourceId,
            bool triggerLogsRefs,
          })
        > {
  $$RoutinesTableTableManager(_$AppDatabase db, $RoutinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<String> scheduleMode = const Value.absent(),
                Value<int?> oneShotAt = const Value.absent(),
                Value<String?> atTime = const Value.absent(),
                Value<int?> intervalHours = const Value.absent(),
                Value<int?> intervalMinutes = const Value.absent(),
                Value<String?> windowStart = const Value.absent(),
                Value<String?> windowEnd = const Value.absent(),
                Value<int?> weekdaysMask = const Value.absent(),
                Value<int> soundSourceId = const Value.absent(),
                Value<String?> soundRef = const Value.absent(),
                Value<String?> soundLabel = const Value.absent(),
                Value<int> volume = const Value.absent(),
                Value<bool> fadeIn = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int?> nextTriggerAt = const Value.absent(),
                Value<int?> snoozeUntil = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
              }) => RoutinesCompanion(
                id: id,
                name: name,
                typeId: typeId,
                scheduleMode: scheduleMode,
                oneShotAt: oneShotAt,
                atTime: atTime,
                intervalHours: intervalHours,
                intervalMinutes: intervalMinutes,
                windowStart: windowStart,
                windowEnd: windowEnd,
                weekdaysMask: weekdaysMask,
                soundSourceId: soundSourceId,
                soundRef: soundRef,
                soundLabel: soundLabel,
                volume: volume,
                fadeIn: fadeIn,
                isEnabled: isEnabled,
                nextTriggerAt: nextTriggerAt,
                snoozeUntil: snoozeUntil,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int typeId,
                required String scheduleMode,
                Value<int?> oneShotAt = const Value.absent(),
                Value<String?> atTime = const Value.absent(),
                Value<int?> intervalHours = const Value.absent(),
                Value<int?> intervalMinutes = const Value.absent(),
                Value<String?> windowStart = const Value.absent(),
                Value<String?> windowEnd = const Value.absent(),
                Value<int?> weekdaysMask = const Value.absent(),
                required int soundSourceId,
                Value<String?> soundRef = const Value.absent(),
                Value<String?> soundLabel = const Value.absent(),
                Value<int> volume = const Value.absent(),
                Value<bool> fadeIn = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int?> nextTriggerAt = const Value.absent(),
                Value<int?> snoozeUntil = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required int createdAt,
                required int updatedAt,
              }) => RoutinesCompanion.insert(
                id: id,
                name: name,
                typeId: typeId,
                scheduleMode: scheduleMode,
                oneShotAt: oneShotAt,
                atTime: atTime,
                intervalHours: intervalHours,
                intervalMinutes: intervalMinutes,
                windowStart: windowStart,
                windowEnd: windowEnd,
                weekdaysMask: weekdaysMask,
                soundSourceId: soundSourceId,
                soundRef: soundRef,
                soundLabel: soundLabel,
                volume: volume,
                fadeIn: fadeIn,
                isEnabled: isEnabled,
                nextTriggerAt: nextTriggerAt,
                snoozeUntil: snoozeUntil,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RoutinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                typeId = false,
                soundSourceId = false,
                triggerLogsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (triggerLogsRefs) db.triggerLogs,
                  ],
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
                        if (typeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.typeId,
                                    referencedTable: $$RoutinesTableReferences
                                        ._typeIdTable(db),
                                    referencedColumn: $$RoutinesTableReferences
                                        ._typeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (soundSourceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.soundSourceId,
                                    referencedTable: $$RoutinesTableReferences
                                        ._soundSourceIdTable(db),
                                    referencedColumn: $$RoutinesTableReferences
                                        ._soundSourceIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (triggerLogsRefs)
                        await $_getPrefetchedData<
                          Routine,
                          $RoutinesTable,
                          TriggerLog
                        >(
                          currentTable: table,
                          referencedTable: $$RoutinesTableReferences
                              ._triggerLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoutinesTableReferences(
                                db,
                                table,
                                p0,
                              ).triggerLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.routineId == item.id,
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

typedef $$RoutinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutinesTable,
      Routine,
      $$RoutinesTableFilterComposer,
      $$RoutinesTableOrderingComposer,
      $$RoutinesTableAnnotationComposer,
      $$RoutinesTableCreateCompanionBuilder,
      $$RoutinesTableUpdateCompanionBuilder,
      (Routine, $$RoutinesTableReferences),
      Routine,
      PrefetchHooks Function({
        bool typeId,
        bool soundSourceId,
        bool triggerLogsRefs,
      })
    >;
typedef $$TriggerLogsTableCreateCompanionBuilder =
    TriggerLogsCompanion Function({
      Value<int> id,
      required int routineId,
      required int scheduledAt,
      Value<int?> firedAt,
      required int statusId,
      required int createdAt,
    });
typedef $$TriggerLogsTableUpdateCompanionBuilder =
    TriggerLogsCompanion Function({
      Value<int> id,
      Value<int> routineId,
      Value<int> scheduledAt,
      Value<int?> firedAt,
      Value<int> statusId,
      Value<int> createdAt,
    });

final class $$TriggerLogsTableReferences
    extends BaseReferences<_$AppDatabase, $TriggerLogsTable, TriggerLog> {
  $$TriggerLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoutinesTable _routineIdTable(_$AppDatabase db) =>
      db.routines.createAlias('trigger_logs__routine_id__routines__id');

  $$RoutinesTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<int>('routine_id')!;

    final manager = $$RoutinesTableTableManager(
      $_db,
      $_db.routines,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TriggerStatusesTable _statusIdTable(_$AppDatabase db) => db
      .triggerStatuses
      .createAlias('trigger_logs__status_id__trigger_statuses__id');

  $$TriggerStatusesTableProcessedTableManager get statusId {
    final $_column = $_itemColumn<int>('status_id')!;

    final manager = $$TriggerStatusesTableTableManager(
      $_db,
      $_db.triggerStatuses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_statusIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TriggerLogsTableFilterComposer
    extends Composer<_$AppDatabase, $TriggerLogsTable> {
  $$TriggerLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get firedAt => $composableBuilder(
    column: $table.firedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RoutinesTableFilterComposer get routineId {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableFilterComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TriggerStatusesTableFilterComposer get statusId {
    final $$TriggerStatusesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.statusId,
      referencedTable: $db.triggerStatuses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriggerStatusesTableFilterComposer(
            $db: $db,
            $table: $db.triggerStatuses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TriggerLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $TriggerLogsTable> {
  $$TriggerLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get firedAt => $composableBuilder(
    column: $table.firedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoutinesTableOrderingComposer get routineId {
    final $$RoutinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableOrderingComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TriggerStatusesTableOrderingComposer get statusId {
    final $$TriggerStatusesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.statusId,
      referencedTable: $db.triggerStatuses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriggerStatusesTableOrderingComposer(
            $db: $db,
            $table: $db.triggerStatuses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TriggerLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TriggerLogsTable> {
  $$TriggerLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get firedAt =>
      $composableBuilder(column: $table.firedAt, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$RoutinesTableAnnotationComposer get routineId {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableAnnotationComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TriggerStatusesTableAnnotationComposer get statusId {
    final $$TriggerStatusesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.statusId,
      referencedTable: $db.triggerStatuses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriggerStatusesTableAnnotationComposer(
            $db: $db,
            $table: $db.triggerStatuses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TriggerLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TriggerLogsTable,
          TriggerLog,
          $$TriggerLogsTableFilterComposer,
          $$TriggerLogsTableOrderingComposer,
          $$TriggerLogsTableAnnotationComposer,
          $$TriggerLogsTableCreateCompanionBuilder,
          $$TriggerLogsTableUpdateCompanionBuilder,
          (TriggerLog, $$TriggerLogsTableReferences),
          TriggerLog,
          PrefetchHooks Function({bool routineId, bool statusId})
        > {
  $$TriggerLogsTableTableManager(_$AppDatabase db, $TriggerLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TriggerLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TriggerLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TriggerLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> routineId = const Value.absent(),
                Value<int> scheduledAt = const Value.absent(),
                Value<int?> firedAt = const Value.absent(),
                Value<int> statusId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => TriggerLogsCompanion(
                id: id,
                routineId: routineId,
                scheduledAt: scheduledAt,
                firedAt: firedAt,
                statusId: statusId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int routineId,
                required int scheduledAt,
                Value<int?> firedAt = const Value.absent(),
                required int statusId,
                required int createdAt,
              }) => TriggerLogsCompanion.insert(
                id: id,
                routineId: routineId,
                scheduledAt: scheduledAt,
                firedAt: firedAt,
                statusId: statusId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TriggerLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routineId = false, statusId = false}) {
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
                    if (routineId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.routineId,
                                referencedTable: $$TriggerLogsTableReferences
                                    ._routineIdTable(db),
                                referencedColumn: $$TriggerLogsTableReferences
                                    ._routineIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (statusId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.statusId,
                                referencedTable: $$TriggerLogsTableReferences
                                    ._statusIdTable(db),
                                referencedColumn: $$TriggerLogsTableReferences
                                    ._statusIdTable(db)
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

typedef $$TriggerLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TriggerLogsTable,
      TriggerLog,
      $$TriggerLogsTableFilterComposer,
      $$TriggerLogsTableOrderingComposer,
      $$TriggerLogsTableAnnotationComposer,
      $$TriggerLogsTableCreateCompanionBuilder,
      $$TriggerLogsTableUpdateCompanionBuilder,
      (TriggerLog, $$TriggerLogsTableReferences),
      TriggerLog,
      PrefetchHooks Function({bool routineId, bool statusId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      Value<String?> value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String?> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RoutineTypesTableTableManager get routineTypes =>
      $$RoutineTypesTableTableManager(_db, _db.routineTypes);
  $$SoundSourcesTableTableManager get soundSources =>
      $$SoundSourcesTableTableManager(_db, _db.soundSources);
  $$TriggerStatusesTableTableManager get triggerStatuses =>
      $$TriggerStatusesTableTableManager(_db, _db.triggerStatuses);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
  $$TriggerLogsTableTableManager get triggerLogs =>
      $$TriggerLogsTableTableManager(_db, _db.triggerLogs);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
