import 'dart:async';
import 'package:floor/floor.dart';

import '../dao/item_dao.dart';
import '../models/item.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'lista10_database.g.dart';

@Database(version: 1, entities: [Item])
abstract class AppDatabase extends FloorDatabase {
  ItemDao get itemDao;
}
