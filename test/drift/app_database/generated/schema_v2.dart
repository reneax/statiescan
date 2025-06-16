// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class Stores extends Table with TableInfo<Stores, StoresData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Stores(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> lastExpiryTimeId = GeneratedColumn<int>(
    'last_expiry_time_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, lastExpiryTimeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stores';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoresData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoresData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      lastExpiryTimeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_expiry_time_id'],
      ),
    );
  }

  @override
  Stores createAlias(String alias) {
    return Stores(attachedDatabase, alias);
  }
}

class StoresData extends DataClass implements Insertable<StoresData> {
  final int id;
  final String name;
  final int? lastExpiryTimeId;
  const StoresData({
    required this.id,
    required this.name,
    this.lastExpiryTimeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || lastExpiryTimeId != null) {
      map['last_expiry_time_id'] = Variable<int>(lastExpiryTimeId);
    }
    return map;
  }

  StoresCompanion toCompanion(bool nullToAbsent) {
    return StoresCompanion(
      id: Value(id),
      name: Value(name),
      lastExpiryTimeId:
          lastExpiryTimeId == null && nullToAbsent
              ? const Value.absent()
              : Value(lastExpiryTimeId),
    );
  }

  factory StoresData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoresData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lastExpiryTimeId: serializer.fromJson<int?>(json['lastExpiryTimeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lastExpiryTimeId': serializer.toJson<int?>(lastExpiryTimeId),
    };
  }

  StoresData copyWith({
    int? id,
    String? name,
    Value<int?> lastExpiryTimeId = const Value.absent(),
  }) => StoresData(
    id: id ?? this.id,
    name: name ?? this.name,
    lastExpiryTimeId:
        lastExpiryTimeId.present
            ? lastExpiryTimeId.value
            : this.lastExpiryTimeId,
  );
  StoresData copyWithCompanion(StoresCompanion data) {
    return StoresData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      lastExpiryTimeId:
          data.lastExpiryTimeId.present
              ? data.lastExpiryTimeId.value
              : this.lastExpiryTimeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoresData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastExpiryTimeId: $lastExpiryTimeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, lastExpiryTimeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoresData &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastExpiryTimeId == this.lastExpiryTimeId);
}

class StoresCompanion extends UpdateCompanion<StoresData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> lastExpiryTimeId;
  const StoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastExpiryTimeId = const Value.absent(),
  });
  StoresCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.lastExpiryTimeId = const Value.absent(),
  }) : name = Value(name);
  static Insertable<StoresData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? lastExpiryTimeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastExpiryTimeId != null) 'last_expiry_time_id': lastExpiryTimeId,
    });
  }

  StoresCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int?>? lastExpiryTimeId,
  }) {
    return StoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lastExpiryTimeId: lastExpiryTimeId ?? this.lastExpiryTimeId,
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
    if (lastExpiryTimeId.present) {
      map['last_expiry_time_id'] = Variable<int>(lastExpiryTimeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoresCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastExpiryTimeId: $lastExpiryTimeId')
          ..write(')'))
        .toString();
  }
}

class Receipts extends Table with TableInfo<Receipts, ReceiptsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Receipts(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> amountInCents = GeneratedColumn<int>(
    'amount_in_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
    'store_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stores (id)',
    ),
  );
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('32'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    amountInCents,
    createdAt,
    expiresAt,
    storeId,
    typeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipts';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReceiptsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReceiptsData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      code:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}code'],
          )!,
      amountInCents:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}amount_in_cents'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
      storeId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}store_id'],
          )!,
      typeId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}type_id'],
          )!,
    );
  }

  @override
  Receipts createAlias(String alias) {
    return Receipts(attachedDatabase, alias);
  }
}

class ReceiptsData extends DataClass implements Insertable<ReceiptsData> {
  final int id;
  final String code;
  final int amountInCents;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final int storeId;
  final int typeId;
  const ReceiptsData({
    required this.id,
    required this.code,
    required this.amountInCents,
    required this.createdAt,
    this.expiresAt,
    required this.storeId,
    required this.typeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['amount_in_cents'] = Variable<int>(amountInCents);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    map['store_id'] = Variable<int>(storeId);
    map['type_id'] = Variable<int>(typeId);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      code: Value(code),
      amountInCents: Value(amountInCents),
      createdAt: Value(createdAt),
      expiresAt:
          expiresAt == null && nullToAbsent
              ? const Value.absent()
              : Value(expiresAt),
      storeId: Value(storeId),
      typeId: Value(typeId),
    );
  }

  factory ReceiptsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReceiptsData(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      amountInCents: serializer.fromJson<int>(json['amountInCents']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
      storeId: serializer.fromJson<int>(json['storeId']),
      typeId: serializer.fromJson<int>(json['typeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'amountInCents': serializer.toJson<int>(amountInCents),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
      'storeId': serializer.toJson<int>(storeId),
      'typeId': serializer.toJson<int>(typeId),
    };
  }

  ReceiptsData copyWith({
    int? id,
    String? code,
    int? amountInCents,
    DateTime? createdAt,
    Value<DateTime?> expiresAt = const Value.absent(),
    int? storeId,
    int? typeId,
  }) => ReceiptsData(
    id: id ?? this.id,
    code: code ?? this.code,
    amountInCents: amountInCents ?? this.amountInCents,
    createdAt: createdAt ?? this.createdAt,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    storeId: storeId ?? this.storeId,
    typeId: typeId ?? this.typeId,
  );
  ReceiptsData copyWithCompanion(ReceiptsCompanion data) {
    return ReceiptsData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      amountInCents:
          data.amountInCents.present
              ? data.amountInCents.value
              : this.amountInCents,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('amountInCents: $amountInCents, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('storeId: $storeId, ')
          ..write('typeId: $typeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    amountInCents,
    createdAt,
    expiresAt,
    storeId,
    typeId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReceiptsData &&
          other.id == this.id &&
          other.code == this.code &&
          other.amountInCents == this.amountInCents &&
          other.createdAt == this.createdAt &&
          other.expiresAt == this.expiresAt &&
          other.storeId == this.storeId &&
          other.typeId == this.typeId);
}

class ReceiptsCompanion extends UpdateCompanion<ReceiptsData> {
  final Value<int> id;
  final Value<String> code;
  final Value<int> amountInCents;
  final Value<DateTime> createdAt;
  final Value<DateTime?> expiresAt;
  final Value<int> storeId;
  final Value<int> typeId;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.amountInCents = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.storeId = const Value.absent(),
    this.typeId = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required int amountInCents,
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    required int storeId,
    this.typeId = const Value.absent(),
  }) : code = Value(code),
       amountInCents = Value(amountInCents),
       storeId = Value(storeId);
  static Insertable<ReceiptsData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<int>? amountInCents,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? expiresAt,
    Expression<int>? storeId,
    Expression<int>? typeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (amountInCents != null) 'amount_in_cents': amountInCents,
      if (createdAt != null) 'created_at': createdAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (storeId != null) 'store_id': storeId,
      if (typeId != null) 'type_id': typeId,
    });
  }

  ReceiptsCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<int>? amountInCents,
    Value<DateTime>? createdAt,
    Value<DateTime?>? expiresAt,
    Value<int>? storeId,
    Value<int>? typeId,
  }) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      amountInCents: amountInCents ?? this.amountInCents,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      storeId: storeId ?? this.storeId,
      typeId: typeId ?? this.typeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (amountInCents.present) {
      map['amount_in_cents'] = Variable<int>(amountInCents.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('amountInCents: $amountInCents, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('storeId: $storeId, ')
          ..write('typeId: $typeId')
          ..write(')'))
        .toString();
  }
}

class DatabaseAtV2 extends GeneratedDatabase {
  DatabaseAtV2(QueryExecutor e) : super(e);
  late final Stores stores = Stores(this);
  late final Receipts receipts = Receipts(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [stores, receipts];
  @override
  int get schemaVersion => 2;
}
