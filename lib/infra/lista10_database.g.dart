// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista10_database.dart';

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

  ItemDao? _itemDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `Item` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `itemListId` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ItemDao get itemDao {
    return _itemDaoInstance ??= _$ItemDao(database, changeListener);
  }
}

class _$ItemDao extends ItemDao {
  _$ItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _itemInsertionAdapter = InsertionAdapter(
            database,
            'Item',
            (Item item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'itemListId': item.itemListId
                },
            changeListener),
        _itemUpdateAdapter = UpdateAdapter(
            database,
            'Item',
            ['id'],
            (Item item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'itemListId': item.itemListId
                },
            changeListener),
        _itemDeletionAdapter = DeletionAdapter(
            database,
            'Item',
            ['id'],
            (Item item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'itemListId': item.itemListId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Item> _itemInsertionAdapter;

  final UpdateAdapter<Item> _itemUpdateAdapter;

  final DeletionAdapter<Item> _itemDeletionAdapter;

  @override
  Future<void> deleteAllItems() async {
    await _queryAdapter.queryNoReturn('DELETE * FROM Item');
  }

  @override
  Stream<List<Item>> getAllItems() {
    return _queryAdapter.queryListStream('SELECT * FROM Item',
        mapper: (Map<String, Object?> row) => Item(
            id: row['id'] as int?,
            title: row['title'] as String?,
            itemListId: row['itemListId'] as String?),
        queryableName: 'Item',
        isView: false);
  }

  @override
  Stream<List<Item>> getItemListByItemListId(String itemListId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Item WHERE itemListId = ?1',
        mapper: (Map<String, Object?> row) => Item(
            id: row['id'] as int?,
            title: row['title'] as String?,
            itemListId: row['itemListId'] as String?),
        arguments: [itemListId],
        queryableName: 'Item',
        isView: false);
  }

  @override
  Stream<Item?> getItemById(String id) {
    return _queryAdapter.queryStream('SELECT 1 FROM Item WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Item(
            id: row['id'] as int?,
            title: row['title'] as String?,
            itemListId: row['itemListId'] as String?),
        arguments: [id],
        queryableName: 'Item',
        isView: false);
  }

  @override
  Future<void> insertItem(Item item) async {
    await _itemInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateItem(Item item) async {
    await _itemUpdateAdapter.update(item, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteItem(Item item) async {
    await _itemDeletionAdapter.delete(item);
  }
}
