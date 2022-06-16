// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:floor/floor.dart';

import '../models/item_list.dart';
import '../models/list_category.dart';
import '../models/item.dart';

import '../dao/category_dao.dart';
import '../dao/item_dao.dart';
import '../dao/item_list_dao.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'lista10_database.g.dart';

@Database(version: 1, entities: [Item, ItemList, ListCategory])
abstract class AppDatabase extends FloorDatabase {
  ItemDao get itemDao;
  ItemListDao get itemListDao;
  ListCategoryDao get listCategoryDao;
}
