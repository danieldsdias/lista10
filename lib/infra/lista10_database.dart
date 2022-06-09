import 'dart:async';
import 'package:floor/floor.dart';
import 'package:lista10/models/item_list.dart';

import '../dao/item_dao.dart';
import '../dao/item_list_dao.dart';
import '../models/item.dart';
import '../models/item_list.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'lista10_database.g.dart';

@Database(version: 1, entities: [Item, ItemList])
abstract class AppDatabase extends FloorDatabase {
  ItemDao get itemDao;
  ItemListDao get itemListDao;
}
