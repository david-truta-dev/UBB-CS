// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EntityDao? _entityDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Plane` (`id` INTEGER, `name` TEXT, `status` TEXT, `size` INTEGER, `owner` TEXT, `manufacturer` TEXT, `capacity` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EntityDao get entityDao {
    return _entityDaoInstance ??= _$EntityDao(database, changeListener);
  }
}

class _$EntityDao extends EntityDao {
  _$EntityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _planeInsertionAdapter = InsertionAdapter(
            database,
            'Plane',
            (Plane item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'status': item.status,
                  'size': item.size,
                  'owner': item.owner,
                  'manufacturer': item.manufacturer,
                  'capacity': item.capacity
                }),
        _planeUpdateAdapter = UpdateAdapter(
            database,
            'Plane',
            ['id'],
            (Plane item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'status': item.status,
                  'size': item.size,
                  'owner': item.owner,
                  'manufacturer': item.manufacturer,
                  'capacity': item.capacity
                }),
        _planeDeletionAdapter = DeletionAdapter(
            database,
            'Plane',
            ['id'],
            (Plane item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'status': item.status,
                  'size': item.size,
                  'owner': item.owner,
                  'manufacturer': item.manufacturer,
                  'capacity': item.capacity
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Plane> _planeInsertionAdapter;

  final UpdateAdapter<Plane> _planeUpdateAdapter;

  final DeletionAdapter<Plane> _planeDeletionAdapter;

  @override
  Future<List<Plane>> findAllEntities() async {
    return _queryAdapter.queryList('SELECT * FROM Plane',
        mapper: (Map<String, Object?> row) => Plane(
            id: row['id'] as int?,
            name: row['name'] as String?,
            status: row['status'] as String?,
            size: row['size'] as int?,
            owner: row['owner'] as String?,
            manufacturer: row['manufacturer'] as String?,
            capacity: row['capacity'] as int?));
  }

  @override
  Future<void> deleteAllEntities() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Plane');
  }

  @override
  Future<void> insertEntity(Plane entity) async {
    await _planeInsertionAdapter.insert(entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEntity(Plane entity) async {
    await _planeUpdateAdapter.update(entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEntity(Plane entity) async {
    await _planeDeletionAdapter.delete(entity);
  }
}
