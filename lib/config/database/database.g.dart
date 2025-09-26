// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TransportProblemsTable extends TransportProblems
    with TableInfo<$TransportProblemsTable, TransportProblem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransportProblemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _arrayJsonMeta =
      const VerificationMeta('arrayJson');
  @override
  late final GeneratedColumn<String> arrayJson = GeneratedColumn<String>(
      'array_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, arrayJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transport_problems';
  @override
  VerificationContext validateIntegrity(Insertable<TransportProblem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('array_json')) {
      context.handle(_arrayJsonMeta,
          arrayJson.isAcceptableOrUnknown(data['array_json']!, _arrayJsonMeta));
    } else if (isInserting) {
      context.missing(_arrayJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransportProblem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransportProblem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      arrayJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}array_json'])!,
    );
  }

  @override
  $TransportProblemsTable createAlias(String alias) {
    return $TransportProblemsTable(attachedDatabase, alias);
  }
}

class TransportProblem extends DataClass
    implements Insertable<TransportProblem> {
  final int id;
  final String name;
  final String arrayJson;
  const TransportProblem(
      {required this.id, required this.name, required this.arrayJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['array_json'] = Variable<String>(arrayJson);
    return map;
  }

  TransportProblemsCompanion toCompanion(bool nullToAbsent) {
    return TransportProblemsCompanion(
      id: Value(id),
      name: Value(name),
      arrayJson: Value(arrayJson),
    );
  }

  factory TransportProblem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransportProblem(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      arrayJson: serializer.fromJson<String>(json['arrayJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'arrayJson': serializer.toJson<String>(arrayJson),
    };
  }

  TransportProblem copyWith({int? id, String? name, String? arrayJson}) =>
      TransportProblem(
        id: id ?? this.id,
        name: name ?? this.name,
        arrayJson: arrayJson ?? this.arrayJson,
      );
  TransportProblem copyWithCompanion(TransportProblemsCompanion data) {
    return TransportProblem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      arrayJson: data.arrayJson.present ? data.arrayJson.value : this.arrayJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransportProblem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('arrayJson: $arrayJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, arrayJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransportProblem &&
          other.id == this.id &&
          other.name == this.name &&
          other.arrayJson == this.arrayJson);
}

class TransportProblemsCompanion extends UpdateCompanion<TransportProblem> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> arrayJson;
  const TransportProblemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.arrayJson = const Value.absent(),
  });
  TransportProblemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String arrayJson,
  })  : name = Value(name),
        arrayJson = Value(arrayJson);
  static Insertable<TransportProblem> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? arrayJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (arrayJson != null) 'array_json': arrayJson,
    });
  }

  TransportProblemsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? arrayJson}) {
    return TransportProblemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      arrayJson: arrayJson ?? this.arrayJson,
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
    if (arrayJson.present) {
      map['array_json'] = Variable<String>(arrayJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransportProblemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('arrayJson: $arrayJson')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TransportProblemsTable transportProblems =
      $TransportProblemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [transportProblems];
}

typedef $$TransportProblemsTableCreateCompanionBuilder
    = TransportProblemsCompanion Function({
  Value<int> id,
  required String name,
  required String arrayJson,
});
typedef $$TransportProblemsTableUpdateCompanionBuilder
    = TransportProblemsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> arrayJson,
});

class $$TransportProblemsTableFilterComposer
    extends Composer<_$AppDatabase, $TransportProblemsTable> {
  $$TransportProblemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get arrayJson => $composableBuilder(
      column: $table.arrayJson, builder: (column) => ColumnFilters(column));
}

class $$TransportProblemsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransportProblemsTable> {
  $$TransportProblemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get arrayJson => $composableBuilder(
      column: $table.arrayJson, builder: (column) => ColumnOrderings(column));
}

class $$TransportProblemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransportProblemsTable> {
  $$TransportProblemsTableAnnotationComposer({
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

  GeneratedColumn<String> get arrayJson =>
      $composableBuilder(column: $table.arrayJson, builder: (column) => column);
}

class $$TransportProblemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransportProblemsTable,
    TransportProblem,
    $$TransportProblemsTableFilterComposer,
    $$TransportProblemsTableOrderingComposer,
    $$TransportProblemsTableAnnotationComposer,
    $$TransportProblemsTableCreateCompanionBuilder,
    $$TransportProblemsTableUpdateCompanionBuilder,
    (
      TransportProblem,
      BaseReferences<_$AppDatabase, $TransportProblemsTable, TransportProblem>
    ),
    TransportProblem,
    PrefetchHooks Function()> {
  $$TransportProblemsTableTableManager(
      _$AppDatabase db, $TransportProblemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransportProblemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransportProblemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransportProblemsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> arrayJson = const Value.absent(),
          }) =>
              TransportProblemsCompanion(
            id: id,
            name: name,
            arrayJson: arrayJson,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String arrayJson,
          }) =>
              TransportProblemsCompanion.insert(
            id: id,
            name: name,
            arrayJson: arrayJson,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransportProblemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransportProblemsTable,
    TransportProblem,
    $$TransportProblemsTableFilterComposer,
    $$TransportProblemsTableOrderingComposer,
    $$TransportProblemsTableAnnotationComposer,
    $$TransportProblemsTableCreateCompanionBuilder,
    $$TransportProblemsTableUpdateCompanionBuilder,
    (
      TransportProblem,
      BaseReferences<_$AppDatabase, $TransportProblemsTable, TransportProblem>
    ),
    TransportProblem,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TransportProblemsTableTableManager get transportProblems =>
      $$TransportProblemsTableTableManager(_db, _db.transportProblems);
}
