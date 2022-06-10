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

  ItemListDao? _itemListDaoInstance;

  ListCategoryDao? _listCategoryDaoInstance;

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
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ItemList` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `listCategoryId` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ListCategory` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `color` INTEGER, `type` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ItemDao get itemDao {
    return _itemDaoInstance ??= _$ItemDao(database, changeListener);
  }

  @override
  ItemListDao get itemListDao {
    return _itemListDaoInstance ??= _$ItemListDao(database, changeListener);
  }

  @override
  ListCategoryDao get listCategoryDao {
    return _listCategoryDaoInstance ??=
        _$ListCategoryDao(database, changeListener);
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
  Future<void> deleteById(String id) async {
    await _queryAdapter
        .queryNoReturn('Delete FROM Item WHERE id = ?1', arguments: [id]);
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

class _$ItemListDao extends ItemListDao {
  _$ItemListDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _itemListInsertionAdapter = InsertionAdapter(
            database,
            'ItemList',
            (ItemList item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'listCategoryId': item.listCategoryId
                },
            changeListener),
        _itemListUpdateAdapter = UpdateAdapter(
            database,
            'ItemList',
            ['id'],
            (ItemList item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'listCategoryId': item.listCategoryId
                },
            changeListener),
        _itemListDeletionAdapter = DeletionAdapter(
            database,
            'ItemList',
            ['id'],
            (ItemList item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'listCategoryId': item.listCategoryId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ItemList> _itemListInsertionAdapter;

  final UpdateAdapter<ItemList> _itemListUpdateAdapter;

  final DeletionAdapter<ItemList> _itemListDeletionAdapter;

  @override
  Future<void> deleteAllItemLists() async {
    await _queryAdapter.queryNoReturn('DELETE * FROM ItemList');
  }

  @override
  Stream<List<ItemList>> getAllItemLists() {
    return _queryAdapter.queryListStream('SELECT * FROM ItemList',
        mapper: (Map<String, Object?> row) => ItemList(
            id: row['id'] as int?,
            title: row['title'] as String?,
            listCategoryId: row['listCategoryId'] as String?),
        queryableName: 'ItemList',
        isView: false);
  }

  @override
  Stream<List<ItemList>> getItemListByListCategoryId(String listCategoryId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM ItemList WHERE listCategoryId = ?1',
        mapper: (Map<String, Object?> row) => ItemList(
            id: row['id'] as int?,
            title: row['title'] as String?,
            listCategoryId: row['listCategoryId'] as String?),
        arguments: [listCategoryId],
        queryableName: 'ItemList',
        isView: false);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter
        .queryNoReturn('Delete FROM ItemList WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertData(ItemList data) async {
    await _itemListInsertionAdapter.insert(data, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(ItemList data) async {
    await _itemListUpdateAdapter.update(data, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(ItemList data) async {
    await _itemListDeletionAdapter.delete(data);
  }
}

class _$ListCategoryDao extends ListCategoryDao {
  _$ListCategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _listCategoryInsertionAdapter = InsertionAdapter(
            database,
            'ListCategory',
            (ListCategory item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'color': item.color,
                  'type': item.type
                },
            changeListener),
        _listCategoryUpdateAdapter = UpdateAdapter(
            database,
            'ListCategory',
            ['id'],
            (ListCategory item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'color': item.color,
                  'type': item.type
                },
            changeListener),
        _listCategoryDeletionAdapter = DeletionAdapter(
            database,
            'ListCategory',
            ['id'],
            (ListCategory item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'color': item.color,
                  'type': item.type
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ListCategory> _listCategoryInsertionAdapter;

  final UpdateAdapter<ListCategory> _listCategoryUpdateAdapter;

  final DeletionAdapter<ListCategory> _listCategoryDeletionAdapter;

  @override
  Future<void> deleteAllCategories() async {
    await _queryAdapter.queryNoReturn('DELETE * FROM ListCategory');
  }

  @override
  Stream<List<ListCategory>> getAllCategories() {
    return _queryAdapter.queryListStream('SELECT * FROM ListCategory',
        mapper: (Map<String, Object?> row) => ListCategory(
            id: row['id'] as int?,
            title: row['title'] as String?,
            type: row['type'] as String?,
            color: row['color'] as int?),
        queryableName: 'ListCategory',
        isView: false);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn('Delete FROM ListCategory WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertData(ListCategory data) async {
    await _listCategoryInsertionAdapter.insert(data, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(ListCategory data) async {
    await _listCategoryUpdateAdapter.update(data, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(ListCategory data) async {
    await _listCategoryDeletionAdapter.delete(data);
  }
}
