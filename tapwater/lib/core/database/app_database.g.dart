// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DrinkTypesTable extends DrinkTypes
    with TableInfo<$DrinkTypesTable, DrinkType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrinkTypesTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hydrationMultiplierMeta =
      const VerificationMeta('hydrationMultiplier');
  @override
  late final GeneratedColumn<double> hydrationMultiplier =
      GeneratedColumn<double>(
        'hydration_multiplier',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(1.0),
      );
  static const VerificationMeta _defaultAmountMlMeta = const VerificationMeta(
    'defaultAmountMl',
  );
  @override
  late final GeneratedColumn<int> defaultAmountMl = GeneratedColumn<int>(
    'default_amount_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(250),
  );
  static const VerificationMeta _colorHexMeta = const VerificationMeta(
    'colorHex',
  );
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
    'color_hex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('FF2196F3'),
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    icon,
    hydrationMultiplier,
    defaultAmountMl,
    colorHex,
    isBuiltIn,
    isActive,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drink_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<DrinkType> instance, {
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
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('hydration_multiplier')) {
      context.handle(
        _hydrationMultiplierMeta,
        hydrationMultiplier.isAcceptableOrUnknown(
          data['hydration_multiplier']!,
          _hydrationMultiplierMeta,
        ),
      );
    }
    if (data.containsKey('default_amount_ml')) {
      context.handle(
        _defaultAmountMlMeta,
        defaultAmountMl.isAcceptableOrUnknown(
          data['default_amount_ml']!,
          _defaultAmountMlMeta,
        ),
      );
    }
    if (data.containsKey('color_hex')) {
      context.handle(
        _colorHexMeta,
        colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta),
      );
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrinkType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrinkType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      hydrationMultiplier: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hydration_multiplier'],
      )!,
      defaultAmountMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_amount_ml'],
      )!,
      colorHex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_hex'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $DrinkTypesTable createAlias(String alias) {
    return $DrinkTypesTable(attachedDatabase, alias);
  }
}

class DrinkType extends DataClass implements Insertable<DrinkType> {
  final int id;
  final String name;
  final String icon;
  final double hydrationMultiplier;
  final int defaultAmountMl;
  final String colorHex;
  final bool isBuiltIn;
  final bool isActive;
  final int sortOrder;
  const DrinkType({
    required this.id,
    required this.name,
    required this.icon,
    required this.hydrationMultiplier,
    required this.defaultAmountMl,
    required this.colorHex,
    required this.isBuiltIn,
    required this.isActive,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['hydration_multiplier'] = Variable<double>(hydrationMultiplier);
    map['default_amount_ml'] = Variable<int>(defaultAmountMl);
    map['color_hex'] = Variable<String>(colorHex);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['is_active'] = Variable<bool>(isActive);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  DrinkTypesCompanion toCompanion(bool nullToAbsent) {
    return DrinkTypesCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      hydrationMultiplier: Value(hydrationMultiplier),
      defaultAmountMl: Value(defaultAmountMl),
      colorHex: Value(colorHex),
      isBuiltIn: Value(isBuiltIn),
      isActive: Value(isActive),
      sortOrder: Value(sortOrder),
    );
  }

  factory DrinkType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrinkType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      hydrationMultiplier: serializer.fromJson<double>(
        json['hydrationMultiplier'],
      ),
      defaultAmountMl: serializer.fromJson<int>(json['defaultAmountMl']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'hydrationMultiplier': serializer.toJson<double>(hydrationMultiplier),
      'defaultAmountMl': serializer.toJson<int>(defaultAmountMl),
      'colorHex': serializer.toJson<String>(colorHex),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'isActive': serializer.toJson<bool>(isActive),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  DrinkType copyWith({
    int? id,
    String? name,
    String? icon,
    double? hydrationMultiplier,
    int? defaultAmountMl,
    String? colorHex,
    bool? isBuiltIn,
    bool? isActive,
    int? sortOrder,
  }) => DrinkType(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    hydrationMultiplier: hydrationMultiplier ?? this.hydrationMultiplier,
    defaultAmountMl: defaultAmountMl ?? this.defaultAmountMl,
    colorHex: colorHex ?? this.colorHex,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    isActive: isActive ?? this.isActive,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  DrinkType copyWithCompanion(DrinkTypesCompanion data) {
    return DrinkType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      hydrationMultiplier: data.hydrationMultiplier.present
          ? data.hydrationMultiplier.value
          : this.hydrationMultiplier,
      defaultAmountMl: data.defaultAmountMl.present
          ? data.defaultAmountMl.value
          : this.defaultAmountMl,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrinkType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('hydrationMultiplier: $hydrationMultiplier, ')
          ..write('defaultAmountMl: $defaultAmountMl, ')
          ..write('colorHex: $colorHex, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    icon,
    hydrationMultiplier,
    defaultAmountMl,
    colorHex,
    isBuiltIn,
    isActive,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrinkType &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.hydrationMultiplier == this.hydrationMultiplier &&
          other.defaultAmountMl == this.defaultAmountMl &&
          other.colorHex == this.colorHex &&
          other.isBuiltIn == this.isBuiltIn &&
          other.isActive == this.isActive &&
          other.sortOrder == this.sortOrder);
}

class DrinkTypesCompanion extends UpdateCompanion<DrinkType> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<double> hydrationMultiplier;
  final Value<int> defaultAmountMl;
  final Value<String> colorHex;
  final Value<bool> isBuiltIn;
  final Value<bool> isActive;
  final Value<int> sortOrder;
  const DrinkTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.hydrationMultiplier = const Value.absent(),
    this.defaultAmountMl = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  DrinkTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String icon,
    this.hydrationMultiplier = const Value.absent(),
    this.defaultAmountMl = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : name = Value(name),
       icon = Value(icon);
  static Insertable<DrinkType> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<double>? hydrationMultiplier,
    Expression<int>? defaultAmountMl,
    Expression<String>? colorHex,
    Expression<bool>? isBuiltIn,
    Expression<bool>? isActive,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (hydrationMultiplier != null)
        'hydration_multiplier': hydrationMultiplier,
      if (defaultAmountMl != null) 'default_amount_ml': defaultAmountMl,
      if (colorHex != null) 'color_hex': colorHex,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (isActive != null) 'is_active': isActive,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  DrinkTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<double>? hydrationMultiplier,
    Value<int>? defaultAmountMl,
    Value<String>? colorHex,
    Value<bool>? isBuiltIn,
    Value<bool>? isActive,
    Value<int>? sortOrder,
  }) {
    return DrinkTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      hydrationMultiplier: hydrationMultiplier ?? this.hydrationMultiplier,
      defaultAmountMl: defaultAmountMl ?? this.defaultAmountMl,
      colorHex: colorHex ?? this.colorHex,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
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
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (hydrationMultiplier.present) {
      map['hydration_multiplier'] = Variable<double>(hydrationMultiplier.value);
    }
    if (defaultAmountMl.present) {
      map['default_amount_ml'] = Variable<int>(defaultAmountMl.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrinkTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('hydrationMultiplier: $hydrationMultiplier, ')
          ..write('defaultAmountMl: $defaultAmountMl, ')
          ..write('colorHex: $colorHex, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $DrinkEntriesTable extends DrinkEntries
    with TableInfo<$DrinkEntriesTable, DrinkEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrinkEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _drinkTypeIdMeta = const VerificationMeta(
    'drinkTypeId',
  );
  @override
  late final GeneratedColumn<int> drinkTypeId = GeneratedColumn<int>(
    'drink_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES drink_types (id)',
    ),
  );
  static const VerificationMeta _amountMlMeta = const VerificationMeta(
    'amountMl',
  );
  @override
  late final GeneratedColumn<int> amountMl = GeneratedColumn<int>(
    'amount_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    drinkTypeId,
    amountMl,
    createdAt,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drink_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DrinkEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('drink_type_id')) {
      context.handle(
        _drinkTypeIdMeta,
        drinkTypeId.isAcceptableOrUnknown(
          data['drink_type_id']!,
          _drinkTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_drinkTypeIdMeta);
    }
    if (data.containsKey('amount_ml')) {
      context.handle(
        _amountMlMeta,
        amountMl.isAcceptableOrUnknown(data['amount_ml']!, _amountMlMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMlMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrinkEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrinkEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      drinkTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}drink_type_id'],
      )!,
      amountMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_ml'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
    );
  }

  @override
  $DrinkEntriesTable createAlias(String alias) {
    return $DrinkEntriesTable(attachedDatabase, alias);
  }
}

class DrinkEntry extends DataClass implements Insertable<DrinkEntry> {
  final int id;
  final int drinkTypeId;
  final int amountMl;
  final DateTime createdAt;
  final String source;
  const DrinkEntry({
    required this.id,
    required this.drinkTypeId,
    required this.amountMl,
    required this.createdAt,
    required this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['drink_type_id'] = Variable<int>(drinkTypeId);
    map['amount_ml'] = Variable<int>(amountMl);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['source'] = Variable<String>(source);
    return map;
  }

  DrinkEntriesCompanion toCompanion(bool nullToAbsent) {
    return DrinkEntriesCompanion(
      id: Value(id),
      drinkTypeId: Value(drinkTypeId),
      amountMl: Value(amountMl),
      createdAt: Value(createdAt),
      source: Value(source),
    );
  }

  factory DrinkEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrinkEntry(
      id: serializer.fromJson<int>(json['id']),
      drinkTypeId: serializer.fromJson<int>(json['drinkTypeId']),
      amountMl: serializer.fromJson<int>(json['amountMl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      source: serializer.fromJson<String>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'drinkTypeId': serializer.toJson<int>(drinkTypeId),
      'amountMl': serializer.toJson<int>(amountMl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'source': serializer.toJson<String>(source),
    };
  }

  DrinkEntry copyWith({
    int? id,
    int? drinkTypeId,
    int? amountMl,
    DateTime? createdAt,
    String? source,
  }) => DrinkEntry(
    id: id ?? this.id,
    drinkTypeId: drinkTypeId ?? this.drinkTypeId,
    amountMl: amountMl ?? this.amountMl,
    createdAt: createdAt ?? this.createdAt,
    source: source ?? this.source,
  );
  DrinkEntry copyWithCompanion(DrinkEntriesCompanion data) {
    return DrinkEntry(
      id: data.id.present ? data.id.value : this.id,
      drinkTypeId: data.drinkTypeId.present
          ? data.drinkTypeId.value
          : this.drinkTypeId,
      amountMl: data.amountMl.present ? data.amountMl.value : this.amountMl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrinkEntry(')
          ..write('id: $id, ')
          ..write('drinkTypeId: $drinkTypeId, ')
          ..write('amountMl: $amountMl, ')
          ..write('createdAt: $createdAt, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, drinkTypeId, amountMl, createdAt, source);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrinkEntry &&
          other.id == this.id &&
          other.drinkTypeId == this.drinkTypeId &&
          other.amountMl == this.amountMl &&
          other.createdAt == this.createdAt &&
          other.source == this.source);
}

class DrinkEntriesCompanion extends UpdateCompanion<DrinkEntry> {
  final Value<int> id;
  final Value<int> drinkTypeId;
  final Value<int> amountMl;
  final Value<DateTime> createdAt;
  final Value<String> source;
  const DrinkEntriesCompanion({
    this.id = const Value.absent(),
    this.drinkTypeId = const Value.absent(),
    this.amountMl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.source = const Value.absent(),
  });
  DrinkEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int drinkTypeId,
    required int amountMl,
    required DateTime createdAt,
    this.source = const Value.absent(),
  }) : drinkTypeId = Value(drinkTypeId),
       amountMl = Value(amountMl),
       createdAt = Value(createdAt);
  static Insertable<DrinkEntry> custom({
    Expression<int>? id,
    Expression<int>? drinkTypeId,
    Expression<int>? amountMl,
    Expression<DateTime>? createdAt,
    Expression<String>? source,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (drinkTypeId != null) 'drink_type_id': drinkTypeId,
      if (amountMl != null) 'amount_ml': amountMl,
      if (createdAt != null) 'created_at': createdAt,
      if (source != null) 'source': source,
    });
  }

  DrinkEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? drinkTypeId,
    Value<int>? amountMl,
    Value<DateTime>? createdAt,
    Value<String>? source,
  }) {
    return DrinkEntriesCompanion(
      id: id ?? this.id,
      drinkTypeId: drinkTypeId ?? this.drinkTypeId,
      amountMl: amountMl ?? this.amountMl,
      createdAt: createdAt ?? this.createdAt,
      source: source ?? this.source,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (drinkTypeId.present) {
      map['drink_type_id'] = Variable<int>(drinkTypeId.value);
    }
    if (amountMl.present) {
      map['amount_ml'] = Variable<int>(amountMl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrinkEntriesCompanion(')
          ..write('id: $id, ')
          ..write('drinkTypeId: $drinkTypeId, ')
          ..write('amountMl: $amountMl, ')
          ..write('createdAt: $createdAt, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }
}

class $DailyGoalsTable extends DailyGoals
    with TableInfo<$DailyGoalsTable, DailyGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyGoalsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _goalMlMeta = const VerificationMeta('goalMl');
  @override
  late final GeneratedColumn<int> goalMl = GeneratedColumn<int>(
    'goal_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2000),
  );
  static const VerificationMeta _effectiveFromMeta = const VerificationMeta(
    'effectiveFrom',
  );
  @override
  late final GeneratedColumn<DateTime> effectiveFrom =
      GeneratedColumn<DateTime>(
        'effective_from',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [id, goalMl, effectiveFrom];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyGoal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('goal_ml')) {
      context.handle(
        _goalMlMeta,
        goalMl.isAcceptableOrUnknown(data['goal_ml']!, _goalMlMeta),
      );
    }
    if (data.containsKey('effective_from')) {
      context.handle(
        _effectiveFromMeta,
        effectiveFrom.isAcceptableOrUnknown(
          data['effective_from']!,
          _effectiveFromMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveFromMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyGoal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      goalMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_ml'],
      )!,
      effectiveFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}effective_from'],
      )!,
    );
  }

  @override
  $DailyGoalsTable createAlias(String alias) {
    return $DailyGoalsTable(attachedDatabase, alias);
  }
}

class DailyGoal extends DataClass implements Insertable<DailyGoal> {
  final int id;
  final int goalMl;
  final DateTime effectiveFrom;
  const DailyGoal({
    required this.id,
    required this.goalMl,
    required this.effectiveFrom,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['goal_ml'] = Variable<int>(goalMl);
    map['effective_from'] = Variable<DateTime>(effectiveFrom);
    return map;
  }

  DailyGoalsCompanion toCompanion(bool nullToAbsent) {
    return DailyGoalsCompanion(
      id: Value(id),
      goalMl: Value(goalMl),
      effectiveFrom: Value(effectiveFrom),
    );
  }

  factory DailyGoal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyGoal(
      id: serializer.fromJson<int>(json['id']),
      goalMl: serializer.fromJson<int>(json['goalMl']),
      effectiveFrom: serializer.fromJson<DateTime>(json['effectiveFrom']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'goalMl': serializer.toJson<int>(goalMl),
      'effectiveFrom': serializer.toJson<DateTime>(effectiveFrom),
    };
  }

  DailyGoal copyWith({int? id, int? goalMl, DateTime? effectiveFrom}) =>
      DailyGoal(
        id: id ?? this.id,
        goalMl: goalMl ?? this.goalMl,
        effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      );
  DailyGoal copyWithCompanion(DailyGoalsCompanion data) {
    return DailyGoal(
      id: data.id.present ? data.id.value : this.id,
      goalMl: data.goalMl.present ? data.goalMl.value : this.goalMl,
      effectiveFrom: data.effectiveFrom.present
          ? data.effectiveFrom.value
          : this.effectiveFrom,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyGoal(')
          ..write('id: $id, ')
          ..write('goalMl: $goalMl, ')
          ..write('effectiveFrom: $effectiveFrom')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, goalMl, effectiveFrom);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyGoal &&
          other.id == this.id &&
          other.goalMl == this.goalMl &&
          other.effectiveFrom == this.effectiveFrom);
}

class DailyGoalsCompanion extends UpdateCompanion<DailyGoal> {
  final Value<int> id;
  final Value<int> goalMl;
  final Value<DateTime> effectiveFrom;
  const DailyGoalsCompanion({
    this.id = const Value.absent(),
    this.goalMl = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
  });
  DailyGoalsCompanion.insert({
    this.id = const Value.absent(),
    this.goalMl = const Value.absent(),
    required DateTime effectiveFrom,
  }) : effectiveFrom = Value(effectiveFrom);
  static Insertable<DailyGoal> custom({
    Expression<int>? id,
    Expression<int>? goalMl,
    Expression<DateTime>? effectiveFrom,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalMl != null) 'goal_ml': goalMl,
      if (effectiveFrom != null) 'effective_from': effectiveFrom,
    });
  }

  DailyGoalsCompanion copyWith({
    Value<int>? id,
    Value<int>? goalMl,
    Value<DateTime>? effectiveFrom,
  }) {
    return DailyGoalsCompanion(
      id: id ?? this.id,
      goalMl: goalMl ?? this.goalMl,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (goalMl.present) {
      map['goal_ml'] = Variable<int>(goalMl.value);
    }
    if (effectiveFrom.present) {
      map['effective_from'] = Variable<DateTime>(effectiveFrom.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyGoalsCompanion(')
          ..write('id: $id, ')
          ..write('goalMl: $goalMl, ')
          ..write('effectiveFrom: $effectiveFrom')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTable extends UserSettings
    with TableInfo<$UserSettingsTable, UserSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _unitSystemMeta = const VerificationMeta(
    'unitSystem',
  );
  @override
  late final GeneratedColumn<String> unitSystem = GeneratedColumn<String>(
    'unit_system',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('metric'),
  );
  static const VerificationMeta _dayBoundaryHourMeta = const VerificationMeta(
    'dayBoundaryHour',
  );
  @override
  late final GeneratedColumn<int> dayBoundaryHour = GeneratedColumn<int>(
    'day_boundary_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _remindersEnabledMeta = const VerificationMeta(
    'remindersEnabled',
  );
  @override
  late final GeneratedColumn<bool> remindersEnabled = GeneratedColumn<bool>(
    'reminders_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminders_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reminderStartHourMeta = const VerificationMeta(
    'reminderStartHour',
  );
  @override
  late final GeneratedColumn<int> reminderStartHour = GeneratedColumn<int>(
    'reminder_start_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(8),
  );
  static const VerificationMeta _reminderEndHourMeta = const VerificationMeta(
    'reminderEndHour',
  );
  @override
  late final GeneratedColumn<int> reminderEndHour = GeneratedColumn<int>(
    'reminder_end_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(22),
  );
  static const VerificationMeta _reminderIntervalMinutesMeta =
      const VerificationMeta('reminderIntervalMinutes');
  @override
  late final GeneratedColumn<int> reminderIntervalMinutes =
      GeneratedColumn<int>(
        'reminder_interval_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(120),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    unitSystem,
    dayBoundaryHour,
    remindersEnabled,
    reminderStartHour,
    reminderEndHour,
    reminderIntervalMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('unit_system')) {
      context.handle(
        _unitSystemMeta,
        unitSystem.isAcceptableOrUnknown(data['unit_system']!, _unitSystemMeta),
      );
    }
    if (data.containsKey('day_boundary_hour')) {
      context.handle(
        _dayBoundaryHourMeta,
        dayBoundaryHour.isAcceptableOrUnknown(
          data['day_boundary_hour']!,
          _dayBoundaryHourMeta,
        ),
      );
    }
    if (data.containsKey('reminders_enabled')) {
      context.handle(
        _remindersEnabledMeta,
        remindersEnabled.isAcceptableOrUnknown(
          data['reminders_enabled']!,
          _remindersEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reminder_start_hour')) {
      context.handle(
        _reminderStartHourMeta,
        reminderStartHour.isAcceptableOrUnknown(
          data['reminder_start_hour']!,
          _reminderStartHourMeta,
        ),
      );
    }
    if (data.containsKey('reminder_end_hour')) {
      context.handle(
        _reminderEndHourMeta,
        reminderEndHour.isAcceptableOrUnknown(
          data['reminder_end_hour']!,
          _reminderEndHourMeta,
        ),
      );
    }
    if (data.containsKey('reminder_interval_minutes')) {
      context.handle(
        _reminderIntervalMinutesMeta,
        reminderIntervalMinutes.isAcceptableOrUnknown(
          data['reminder_interval_minutes']!,
          _reminderIntervalMinutesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      unitSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_system'],
      )!,
      dayBoundaryHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_boundary_hour'],
      )!,
      remindersEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminders_enabled'],
      )!,
      reminderStartHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_start_hour'],
      )!,
      reminderEndHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_end_hour'],
      )!,
      reminderIntervalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_interval_minutes'],
      )!,
    );
  }

  @override
  $UserSettingsTable createAlias(String alias) {
    return $UserSettingsTable(attachedDatabase, alias);
  }
}

class UserSetting extends DataClass implements Insertable<UserSetting> {
  final int id;
  final String unitSystem;
  final int dayBoundaryHour;
  final bool remindersEnabled;
  final int reminderStartHour;
  final int reminderEndHour;
  final int reminderIntervalMinutes;
  const UserSetting({
    required this.id,
    required this.unitSystem,
    required this.dayBoundaryHour,
    required this.remindersEnabled,
    required this.reminderStartHour,
    required this.reminderEndHour,
    required this.reminderIntervalMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['unit_system'] = Variable<String>(unitSystem);
    map['day_boundary_hour'] = Variable<int>(dayBoundaryHour);
    map['reminders_enabled'] = Variable<bool>(remindersEnabled);
    map['reminder_start_hour'] = Variable<int>(reminderStartHour);
    map['reminder_end_hour'] = Variable<int>(reminderEndHour);
    map['reminder_interval_minutes'] = Variable<int>(reminderIntervalMinutes);
    return map;
  }

  UserSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsCompanion(
      id: Value(id),
      unitSystem: Value(unitSystem),
      dayBoundaryHour: Value(dayBoundaryHour),
      remindersEnabled: Value(remindersEnabled),
      reminderStartHour: Value(reminderStartHour),
      reminderEndHour: Value(reminderEndHour),
      reminderIntervalMinutes: Value(reminderIntervalMinutes),
    );
  }

  factory UserSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSetting(
      id: serializer.fromJson<int>(json['id']),
      unitSystem: serializer.fromJson<String>(json['unitSystem']),
      dayBoundaryHour: serializer.fromJson<int>(json['dayBoundaryHour']),
      remindersEnabled: serializer.fromJson<bool>(json['remindersEnabled']),
      reminderStartHour: serializer.fromJson<int>(json['reminderStartHour']),
      reminderEndHour: serializer.fromJson<int>(json['reminderEndHour']),
      reminderIntervalMinutes: serializer.fromJson<int>(
        json['reminderIntervalMinutes'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'unitSystem': serializer.toJson<String>(unitSystem),
      'dayBoundaryHour': serializer.toJson<int>(dayBoundaryHour),
      'remindersEnabled': serializer.toJson<bool>(remindersEnabled),
      'reminderStartHour': serializer.toJson<int>(reminderStartHour),
      'reminderEndHour': serializer.toJson<int>(reminderEndHour),
      'reminderIntervalMinutes': serializer.toJson<int>(
        reminderIntervalMinutes,
      ),
    };
  }

  UserSetting copyWith({
    int? id,
    String? unitSystem,
    int? dayBoundaryHour,
    bool? remindersEnabled,
    int? reminderStartHour,
    int? reminderEndHour,
    int? reminderIntervalMinutes,
  }) => UserSetting(
    id: id ?? this.id,
    unitSystem: unitSystem ?? this.unitSystem,
    dayBoundaryHour: dayBoundaryHour ?? this.dayBoundaryHour,
    remindersEnabled: remindersEnabled ?? this.remindersEnabled,
    reminderStartHour: reminderStartHour ?? this.reminderStartHour,
    reminderEndHour: reminderEndHour ?? this.reminderEndHour,
    reminderIntervalMinutes:
        reminderIntervalMinutes ?? this.reminderIntervalMinutes,
  );
  UserSetting copyWithCompanion(UserSettingsCompanion data) {
    return UserSetting(
      id: data.id.present ? data.id.value : this.id,
      unitSystem: data.unitSystem.present
          ? data.unitSystem.value
          : this.unitSystem,
      dayBoundaryHour: data.dayBoundaryHour.present
          ? data.dayBoundaryHour.value
          : this.dayBoundaryHour,
      remindersEnabled: data.remindersEnabled.present
          ? data.remindersEnabled.value
          : this.remindersEnabled,
      reminderStartHour: data.reminderStartHour.present
          ? data.reminderStartHour.value
          : this.reminderStartHour,
      reminderEndHour: data.reminderEndHour.present
          ? data.reminderEndHour.value
          : this.reminderEndHour,
      reminderIntervalMinutes: data.reminderIntervalMinutes.present
          ? data.reminderIntervalMinutes.value
          : this.reminderIntervalMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSetting(')
          ..write('id: $id, ')
          ..write('unitSystem: $unitSystem, ')
          ..write('dayBoundaryHour: $dayBoundaryHour, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('reminderStartHour: $reminderStartHour, ')
          ..write('reminderEndHour: $reminderEndHour, ')
          ..write('reminderIntervalMinutes: $reminderIntervalMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    unitSystem,
    dayBoundaryHour,
    remindersEnabled,
    reminderStartHour,
    reminderEndHour,
    reminderIntervalMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSetting &&
          other.id == this.id &&
          other.unitSystem == this.unitSystem &&
          other.dayBoundaryHour == this.dayBoundaryHour &&
          other.remindersEnabled == this.remindersEnabled &&
          other.reminderStartHour == this.reminderStartHour &&
          other.reminderEndHour == this.reminderEndHour &&
          other.reminderIntervalMinutes == this.reminderIntervalMinutes);
}

class UserSettingsCompanion extends UpdateCompanion<UserSetting> {
  final Value<int> id;
  final Value<String> unitSystem;
  final Value<int> dayBoundaryHour;
  final Value<bool> remindersEnabled;
  final Value<int> reminderStartHour;
  final Value<int> reminderEndHour;
  final Value<int> reminderIntervalMinutes;
  const UserSettingsCompanion({
    this.id = const Value.absent(),
    this.unitSystem = const Value.absent(),
    this.dayBoundaryHour = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    this.reminderStartHour = const Value.absent(),
    this.reminderEndHour = const Value.absent(),
    this.reminderIntervalMinutes = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.unitSystem = const Value.absent(),
    this.dayBoundaryHour = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    this.reminderStartHour = const Value.absent(),
    this.reminderEndHour = const Value.absent(),
    this.reminderIntervalMinutes = const Value.absent(),
  });
  static Insertable<UserSetting> custom({
    Expression<int>? id,
    Expression<String>? unitSystem,
    Expression<int>? dayBoundaryHour,
    Expression<bool>? remindersEnabled,
    Expression<int>? reminderStartHour,
    Expression<int>? reminderEndHour,
    Expression<int>? reminderIntervalMinutes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unitSystem != null) 'unit_system': unitSystem,
      if (dayBoundaryHour != null) 'day_boundary_hour': dayBoundaryHour,
      if (remindersEnabled != null) 'reminders_enabled': remindersEnabled,
      if (reminderStartHour != null) 'reminder_start_hour': reminderStartHour,
      if (reminderEndHour != null) 'reminder_end_hour': reminderEndHour,
      if (reminderIntervalMinutes != null)
        'reminder_interval_minutes': reminderIntervalMinutes,
    });
  }

  UserSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? unitSystem,
    Value<int>? dayBoundaryHour,
    Value<bool>? remindersEnabled,
    Value<int>? reminderStartHour,
    Value<int>? reminderEndHour,
    Value<int>? reminderIntervalMinutes,
  }) {
    return UserSettingsCompanion(
      id: id ?? this.id,
      unitSystem: unitSystem ?? this.unitSystem,
      dayBoundaryHour: dayBoundaryHour ?? this.dayBoundaryHour,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      reminderStartHour: reminderStartHour ?? this.reminderStartHour,
      reminderEndHour: reminderEndHour ?? this.reminderEndHour,
      reminderIntervalMinutes:
          reminderIntervalMinutes ?? this.reminderIntervalMinutes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (unitSystem.present) {
      map['unit_system'] = Variable<String>(unitSystem.value);
    }
    if (dayBoundaryHour.present) {
      map['day_boundary_hour'] = Variable<int>(dayBoundaryHour.value);
    }
    if (remindersEnabled.present) {
      map['reminders_enabled'] = Variable<bool>(remindersEnabled.value);
    }
    if (reminderStartHour.present) {
      map['reminder_start_hour'] = Variable<int>(reminderStartHour.value);
    }
    if (reminderEndHour.present) {
      map['reminder_end_hour'] = Variable<int>(reminderEndHour.value);
    }
    if (reminderIntervalMinutes.present) {
      map['reminder_interval_minutes'] = Variable<int>(
        reminderIntervalMinutes.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsCompanion(')
          ..write('id: $id, ')
          ..write('unitSystem: $unitSystem, ')
          ..write('dayBoundaryHour: $dayBoundaryHour, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('reminderStartHour: $reminderStartHour, ')
          ..write('reminderEndHour: $reminderEndHour, ')
          ..write('reminderIntervalMinutes: $reminderIntervalMinutes')
          ..write(')'))
        .toString();
  }
}

class $DailyTagsTable extends DailyTags
    with TableInfo<$DailyTagsTable, DailyTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyTagsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
    'tag',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, tag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
        _tagMeta,
        tag.isAcceptableOrUnknown(data['tag']!, _tagMeta),
      );
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyTag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      tag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag'],
      )!,
    );
  }

  @override
  $DailyTagsTable createAlias(String alias) {
    return $DailyTagsTable(attachedDatabase, alias);
  }
}

class DailyTag extends DataClass implements Insertable<DailyTag> {
  final int id;
  final DateTime date;
  final String tag;
  const DailyTag({required this.id, required this.date, required this.tag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['tag'] = Variable<String>(tag);
    return map;
  }

  DailyTagsCompanion toCompanion(bool nullToAbsent) {
    return DailyTagsCompanion(
      id: Value(id),
      date: Value(date),
      tag: Value(tag),
    );
  }

  factory DailyTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyTag(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      tag: serializer.fromJson<String>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'tag': serializer.toJson<String>(tag),
    };
  }

  DailyTag copyWith({int? id, DateTime? date, String? tag}) => DailyTag(
    id: id ?? this.id,
    date: date ?? this.date,
    tag: tag ?? this.tag,
  );
  DailyTag copyWithCompanion(DailyTagsCompanion data) {
    return DailyTag(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      tag: data.tag.present ? data.tag.value : this.tag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyTag(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyTag &&
          other.id == this.id &&
          other.date == this.date &&
          other.tag == this.tag);
}

class DailyTagsCompanion extends UpdateCompanion<DailyTag> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> tag;
  const DailyTagsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.tag = const Value.absent(),
  });
  DailyTagsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String tag,
  }) : date = Value(date),
       tag = Value(tag);
  static Insertable<DailyTag> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? tag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (tag != null) 'tag': tag,
    });
  }

  DailyTagsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? tag,
  }) {
    return DailyTagsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      tag: tag ?? this.tag,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyTagsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DrinkTypesTable drinkTypes = $DrinkTypesTable(this);
  late final $DrinkEntriesTable drinkEntries = $DrinkEntriesTable(this);
  late final $DailyGoalsTable dailyGoals = $DailyGoalsTable(this);
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  late final $DailyTagsTable dailyTags = $DailyTagsTable(this);
  late final DrinkEntryDao drinkEntryDao = DrinkEntryDao(this as AppDatabase);
  late final DrinkTypeDao drinkTypeDao = DrinkTypeDao(this as AppDatabase);
  late final DailyGoalDao dailyGoalDao = DailyGoalDao(this as AppDatabase);
  late final UserSettingsDao userSettingsDao = UserSettingsDao(
    this as AppDatabase,
  );
  late final DailyTagDao dailyTagDao = DailyTagDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    drinkTypes,
    drinkEntries,
    dailyGoals,
    userSettings,
    dailyTags,
  ];
}

typedef $$DrinkTypesTableCreateCompanionBuilder =
    DrinkTypesCompanion Function({
      Value<int> id,
      required String name,
      required String icon,
      Value<double> hydrationMultiplier,
      Value<int> defaultAmountMl,
      Value<String> colorHex,
      Value<bool> isBuiltIn,
      Value<bool> isActive,
      Value<int> sortOrder,
    });
typedef $$DrinkTypesTableUpdateCompanionBuilder =
    DrinkTypesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> icon,
      Value<double> hydrationMultiplier,
      Value<int> defaultAmountMl,
      Value<String> colorHex,
      Value<bool> isBuiltIn,
      Value<bool> isActive,
      Value<int> sortOrder,
    });

final class $$DrinkTypesTableReferences
    extends BaseReferences<_$AppDatabase, $DrinkTypesTable, DrinkType> {
  $$DrinkTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DrinkEntriesTable, List<DrinkEntry>>
  _drinkEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.drinkEntries,
    aliasName: $_aliasNameGenerator(
      db.drinkTypes.id,
      db.drinkEntries.drinkTypeId,
    ),
  );

  $$DrinkEntriesTableProcessedTableManager get drinkEntriesRefs {
    final manager = $$DrinkEntriesTableTableManager(
      $_db,
      $_db.drinkEntries,
    ).filter((f) => f.drinkTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_drinkEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DrinkTypesTableFilterComposer
    extends Composer<_$AppDatabase, $DrinkTypesTable> {
  $$DrinkTypesTableFilterComposer({
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

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hydrationMultiplier => $composableBuilder(
    column: $table.hydrationMultiplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultAmountMl => $composableBuilder(
    column: $table.defaultAmountMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> drinkEntriesRefs(
    Expression<bool> Function($$DrinkEntriesTableFilterComposer f) f,
  ) {
    final $$DrinkEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drinkEntries,
      getReferencedColumn: (t) => t.drinkTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinkEntriesTableFilterComposer(
            $db: $db,
            $table: $db.drinkEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DrinkTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $DrinkTypesTable> {
  $$DrinkTypesTableOrderingComposer({
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

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hydrationMultiplier => $composableBuilder(
    column: $table.hydrationMultiplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultAmountMl => $composableBuilder(
    column: $table.defaultAmountMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DrinkTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrinkTypesTable> {
  $$DrinkTypesTableAnnotationComposer({
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

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<double> get hydrationMultiplier => $composableBuilder(
    column: $table.hydrationMultiplier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultAmountMl => $composableBuilder(
    column: $table.defaultAmountMl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> drinkEntriesRefs<T extends Object>(
    Expression<T> Function($$DrinkEntriesTableAnnotationComposer a) f,
  ) {
    final $$DrinkEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drinkEntries,
      getReferencedColumn: (t) => t.drinkTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinkEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.drinkEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DrinkTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DrinkTypesTable,
          DrinkType,
          $$DrinkTypesTableFilterComposer,
          $$DrinkTypesTableOrderingComposer,
          $$DrinkTypesTableAnnotationComposer,
          $$DrinkTypesTableCreateCompanionBuilder,
          $$DrinkTypesTableUpdateCompanionBuilder,
          (DrinkType, $$DrinkTypesTableReferences),
          DrinkType,
          PrefetchHooks Function({bool drinkEntriesRefs})
        > {
  $$DrinkTypesTableTableManager(_$AppDatabase db, $DrinkTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrinkTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrinkTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrinkTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<double> hydrationMultiplier = const Value.absent(),
                Value<int> defaultAmountMl = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => DrinkTypesCompanion(
                id: id,
                name: name,
                icon: icon,
                hydrationMultiplier: hydrationMultiplier,
                defaultAmountMl: defaultAmountMl,
                colorHex: colorHex,
                isBuiltIn: isBuiltIn,
                isActive: isActive,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String icon,
                Value<double> hydrationMultiplier = const Value.absent(),
                Value<int> defaultAmountMl = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => DrinkTypesCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                hydrationMultiplier: hydrationMultiplier,
                defaultAmountMl: defaultAmountMl,
                colorHex: colorHex,
                isBuiltIn: isBuiltIn,
                isActive: isActive,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DrinkTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({drinkEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (drinkEntriesRefs) db.drinkEntries],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (drinkEntriesRefs)
                    await $_getPrefetchedData<
                      DrinkType,
                      $DrinkTypesTable,
                      DrinkEntry
                    >(
                      currentTable: table,
                      referencedTable: $$DrinkTypesTableReferences
                          ._drinkEntriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DrinkTypesTableReferences(
                            db,
                            table,
                            p0,
                          ).drinkEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.drinkTypeId == item.id,
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

typedef $$DrinkTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DrinkTypesTable,
      DrinkType,
      $$DrinkTypesTableFilterComposer,
      $$DrinkTypesTableOrderingComposer,
      $$DrinkTypesTableAnnotationComposer,
      $$DrinkTypesTableCreateCompanionBuilder,
      $$DrinkTypesTableUpdateCompanionBuilder,
      (DrinkType, $$DrinkTypesTableReferences),
      DrinkType,
      PrefetchHooks Function({bool drinkEntriesRefs})
    >;
typedef $$DrinkEntriesTableCreateCompanionBuilder =
    DrinkEntriesCompanion Function({
      Value<int> id,
      required int drinkTypeId,
      required int amountMl,
      required DateTime createdAt,
      Value<String> source,
    });
typedef $$DrinkEntriesTableUpdateCompanionBuilder =
    DrinkEntriesCompanion Function({
      Value<int> id,
      Value<int> drinkTypeId,
      Value<int> amountMl,
      Value<DateTime> createdAt,
      Value<String> source,
    });

final class $$DrinkEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $DrinkEntriesTable, DrinkEntry> {
  $$DrinkEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DrinkTypesTable _drinkTypeIdTable(_$AppDatabase db) =>
      db.drinkTypes.createAlias(
        $_aliasNameGenerator(db.drinkEntries.drinkTypeId, db.drinkTypes.id),
      );

  $$DrinkTypesTableProcessedTableManager get drinkTypeId {
    final $_column = $_itemColumn<int>('drink_type_id')!;

    final manager = $$DrinkTypesTableTableManager(
      $_db,
      $_db.drinkTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_drinkTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DrinkEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DrinkEntriesTable> {
  $$DrinkEntriesTableFilterComposer({
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

  ColumnFilters<int> get amountMl => $composableBuilder(
    column: $table.amountMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  $$DrinkTypesTableFilterComposer get drinkTypeId {
    final $$DrinkTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.drinkTypeId,
      referencedTable: $db.drinkTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinkTypesTableFilterComposer(
            $db: $db,
            $table: $db.drinkTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DrinkEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DrinkEntriesTable> {
  $$DrinkEntriesTableOrderingComposer({
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

  ColumnOrderings<int> get amountMl => $composableBuilder(
    column: $table.amountMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$DrinkTypesTableOrderingComposer get drinkTypeId {
    final $$DrinkTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.drinkTypeId,
      referencedTable: $db.drinkTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinkTypesTableOrderingComposer(
            $db: $db,
            $table: $db.drinkTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DrinkEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrinkEntriesTable> {
  $$DrinkEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountMl =>
      $composableBuilder(column: $table.amountMl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$DrinkTypesTableAnnotationComposer get drinkTypeId {
    final $$DrinkTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.drinkTypeId,
      referencedTable: $db.drinkTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinkTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.drinkTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DrinkEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DrinkEntriesTable,
          DrinkEntry,
          $$DrinkEntriesTableFilterComposer,
          $$DrinkEntriesTableOrderingComposer,
          $$DrinkEntriesTableAnnotationComposer,
          $$DrinkEntriesTableCreateCompanionBuilder,
          $$DrinkEntriesTableUpdateCompanionBuilder,
          (DrinkEntry, $$DrinkEntriesTableReferences),
          DrinkEntry,
          PrefetchHooks Function({bool drinkTypeId})
        > {
  $$DrinkEntriesTableTableManager(_$AppDatabase db, $DrinkEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrinkEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrinkEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrinkEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> drinkTypeId = const Value.absent(),
                Value<int> amountMl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> source = const Value.absent(),
              }) => DrinkEntriesCompanion(
                id: id,
                drinkTypeId: drinkTypeId,
                amountMl: amountMl,
                createdAt: createdAt,
                source: source,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int drinkTypeId,
                required int amountMl,
                required DateTime createdAt,
                Value<String> source = const Value.absent(),
              }) => DrinkEntriesCompanion.insert(
                id: id,
                drinkTypeId: drinkTypeId,
                amountMl: amountMl,
                createdAt: createdAt,
                source: source,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DrinkEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({drinkTypeId = false}) {
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
                    if (drinkTypeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.drinkTypeId,
                                referencedTable: $$DrinkEntriesTableReferences
                                    ._drinkTypeIdTable(db),
                                referencedColumn: $$DrinkEntriesTableReferences
                                    ._drinkTypeIdTable(db)
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

typedef $$DrinkEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DrinkEntriesTable,
      DrinkEntry,
      $$DrinkEntriesTableFilterComposer,
      $$DrinkEntriesTableOrderingComposer,
      $$DrinkEntriesTableAnnotationComposer,
      $$DrinkEntriesTableCreateCompanionBuilder,
      $$DrinkEntriesTableUpdateCompanionBuilder,
      (DrinkEntry, $$DrinkEntriesTableReferences),
      DrinkEntry,
      PrefetchHooks Function({bool drinkTypeId})
    >;
typedef $$DailyGoalsTableCreateCompanionBuilder =
    DailyGoalsCompanion Function({
      Value<int> id,
      Value<int> goalMl,
      required DateTime effectiveFrom,
    });
typedef $$DailyGoalsTableUpdateCompanionBuilder =
    DailyGoalsCompanion Function({
      Value<int> id,
      Value<int> goalMl,
      Value<DateTime> effectiveFrom,
    });

class $$DailyGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyGoalsTable> {
  $$DailyGoalsTableFilterComposer({
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

  ColumnFilters<int> get goalMl => $composableBuilder(
    column: $table.goalMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyGoalsTable> {
  $$DailyGoalsTableOrderingComposer({
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

  ColumnOrderings<int> get goalMl => $composableBuilder(
    column: $table.goalMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyGoalsTable> {
  $$DailyGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get goalMl =>
      $composableBuilder(column: $table.goalMl, builder: (column) => column);

  GeneratedColumn<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => column,
  );
}

class $$DailyGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyGoalsTable,
          DailyGoal,
          $$DailyGoalsTableFilterComposer,
          $$DailyGoalsTableOrderingComposer,
          $$DailyGoalsTableAnnotationComposer,
          $$DailyGoalsTableCreateCompanionBuilder,
          $$DailyGoalsTableUpdateCompanionBuilder,
          (
            DailyGoal,
            BaseReferences<_$AppDatabase, $DailyGoalsTable, DailyGoal>,
          ),
          DailyGoal,
          PrefetchHooks Function()
        > {
  $$DailyGoalsTableTableManager(_$AppDatabase db, $DailyGoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> goalMl = const Value.absent(),
                Value<DateTime> effectiveFrom = const Value.absent(),
              }) => DailyGoalsCompanion(
                id: id,
                goalMl: goalMl,
                effectiveFrom: effectiveFrom,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> goalMl = const Value.absent(),
                required DateTime effectiveFrom,
              }) => DailyGoalsCompanion.insert(
                id: id,
                goalMl: goalMl,
                effectiveFrom: effectiveFrom,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyGoalsTable,
      DailyGoal,
      $$DailyGoalsTableFilterComposer,
      $$DailyGoalsTableOrderingComposer,
      $$DailyGoalsTableAnnotationComposer,
      $$DailyGoalsTableCreateCompanionBuilder,
      $$DailyGoalsTableUpdateCompanionBuilder,
      (DailyGoal, BaseReferences<_$AppDatabase, $DailyGoalsTable, DailyGoal>),
      DailyGoal,
      PrefetchHooks Function()
    >;
typedef $$UserSettingsTableCreateCompanionBuilder =
    UserSettingsCompanion Function({
      Value<int> id,
      Value<String> unitSystem,
      Value<int> dayBoundaryHour,
      Value<bool> remindersEnabled,
      Value<int> reminderStartHour,
      Value<int> reminderEndHour,
      Value<int> reminderIntervalMinutes,
    });
typedef $$UserSettingsTableUpdateCompanionBuilder =
    UserSettingsCompanion Function({
      Value<int> id,
      Value<String> unitSystem,
      Value<int> dayBoundaryHour,
      Value<bool> remindersEnabled,
      Value<int> reminderStartHour,
      Value<int> reminderEndHour,
      Value<int> reminderIntervalMinutes,
    });

class $$UserSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableFilterComposer({
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

  ColumnFilters<String> get unitSystem => $composableBuilder(
    column: $table.unitSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayBoundaryHour => $composableBuilder(
    column: $table.dayBoundaryHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindersEnabled => $composableBuilder(
    column: $table.remindersEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderStartHour => $composableBuilder(
    column: $table.reminderStartHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderEndHour => $composableBuilder(
    column: $table.reminderEndHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderIntervalMinutes => $composableBuilder(
    column: $table.reminderIntervalMinutes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableOrderingComposer({
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

  ColumnOrderings<String> get unitSystem => $composableBuilder(
    column: $table.unitSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayBoundaryHour => $composableBuilder(
    column: $table.dayBoundaryHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindersEnabled => $composableBuilder(
    column: $table.remindersEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderStartHour => $composableBuilder(
    column: $table.reminderStartHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderEndHour => $composableBuilder(
    column: $table.reminderEndHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderIntervalMinutes => $composableBuilder(
    column: $table.reminderIntervalMinutes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get unitSystem => $composableBuilder(
    column: $table.unitSystem,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dayBoundaryHour => $composableBuilder(
    column: $table.dayBoundaryHour,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get remindersEnabled => $composableBuilder(
    column: $table.remindersEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderStartHour => $composableBuilder(
    column: $table.reminderStartHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderEndHour => $composableBuilder(
    column: $table.reminderEndHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderIntervalMinutes => $composableBuilder(
    column: $table.reminderIntervalMinutes,
    builder: (column) => column,
  );
}

class $$UserSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserSettingsTable,
          UserSetting,
          $$UserSettingsTableFilterComposer,
          $$UserSettingsTableOrderingComposer,
          $$UserSettingsTableAnnotationComposer,
          $$UserSettingsTableCreateCompanionBuilder,
          $$UserSettingsTableUpdateCompanionBuilder,
          (
            UserSetting,
            BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
          ),
          UserSetting,
          PrefetchHooks Function()
        > {
  $$UserSettingsTableTableManager(_$AppDatabase db, $UserSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> unitSystem = const Value.absent(),
                Value<int> dayBoundaryHour = const Value.absent(),
                Value<bool> remindersEnabled = const Value.absent(),
                Value<int> reminderStartHour = const Value.absent(),
                Value<int> reminderEndHour = const Value.absent(),
                Value<int> reminderIntervalMinutes = const Value.absent(),
              }) => UserSettingsCompanion(
                id: id,
                unitSystem: unitSystem,
                dayBoundaryHour: dayBoundaryHour,
                remindersEnabled: remindersEnabled,
                reminderStartHour: reminderStartHour,
                reminderEndHour: reminderEndHour,
                reminderIntervalMinutes: reminderIntervalMinutes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> unitSystem = const Value.absent(),
                Value<int> dayBoundaryHour = const Value.absent(),
                Value<bool> remindersEnabled = const Value.absent(),
                Value<int> reminderStartHour = const Value.absent(),
                Value<int> reminderEndHour = const Value.absent(),
                Value<int> reminderIntervalMinutes = const Value.absent(),
              }) => UserSettingsCompanion.insert(
                id: id,
                unitSystem: unitSystem,
                dayBoundaryHour: dayBoundaryHour,
                remindersEnabled: remindersEnabled,
                reminderStartHour: reminderStartHour,
                reminderEndHour: reminderEndHour,
                reminderIntervalMinutes: reminderIntervalMinutes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserSettingsTable,
      UserSetting,
      $$UserSettingsTableFilterComposer,
      $$UserSettingsTableOrderingComposer,
      $$UserSettingsTableAnnotationComposer,
      $$UserSettingsTableCreateCompanionBuilder,
      $$UserSettingsTableUpdateCompanionBuilder,
      (
        UserSetting,
        BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
      ),
      UserSetting,
      PrefetchHooks Function()
    >;
typedef $$DailyTagsTableCreateCompanionBuilder =
    DailyTagsCompanion Function({
      Value<int> id,
      required DateTime date,
      required String tag,
    });
typedef $$DailyTagsTableUpdateCompanionBuilder =
    DailyTagsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> tag,
    });

class $$DailyTagsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyTagsTable> {
  $$DailyTagsTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyTagsTable> {
  $$DailyTagsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyTagsTable> {
  $$DailyTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);
}

class $$DailyTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyTagsTable,
          DailyTag,
          $$DailyTagsTableFilterComposer,
          $$DailyTagsTableOrderingComposer,
          $$DailyTagsTableAnnotationComposer,
          $$DailyTagsTableCreateCompanionBuilder,
          $$DailyTagsTableUpdateCompanionBuilder,
          (DailyTag, BaseReferences<_$AppDatabase, $DailyTagsTable, DailyTag>),
          DailyTag,
          PrefetchHooks Function()
        > {
  $$DailyTagsTableTableManager(_$AppDatabase db, $DailyTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> tag = const Value.absent(),
              }) => DailyTagsCompanion(id: id, date: date, tag: tag),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String tag,
              }) => DailyTagsCompanion.insert(id: id, date: date, tag: tag),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyTagsTable,
      DailyTag,
      $$DailyTagsTableFilterComposer,
      $$DailyTagsTableOrderingComposer,
      $$DailyTagsTableAnnotationComposer,
      $$DailyTagsTableCreateCompanionBuilder,
      $$DailyTagsTableUpdateCompanionBuilder,
      (DailyTag, BaseReferences<_$AppDatabase, $DailyTagsTable, DailyTag>),
      DailyTag,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DrinkTypesTableTableManager get drinkTypes =>
      $$DrinkTypesTableTableManager(_db, _db.drinkTypes);
  $$DrinkEntriesTableTableManager get drinkEntries =>
      $$DrinkEntriesTableTableManager(_db, _db.drinkEntries);
  $$DailyGoalsTableTableManager get dailyGoals =>
      $$DailyGoalsTableTableManager(_db, _db.dailyGoals);
  $$UserSettingsTableTableManager get userSettings =>
      $$UserSettingsTableTableManager(_db, _db.userSettings);
  $$DailyTagsTableTableManager get dailyTags =>
      $$DailyTagsTableTableManager(_db, _db.dailyTags);
}
