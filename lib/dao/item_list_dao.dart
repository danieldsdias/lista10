import 'dart:core';
import 'package:floor/floor.dart';

import '../models/item_list.dart';

@dao
abstract class ItemListDao {
  @insert
  Future<void> insertData(ItemList data);

  @update
  Future<void> updateData(ItemList data);

  @delete
  Future<void> deleteData(ItemList data);

  @Query('DELETE * FROM ItemList')
  Future<void> deleteAllItemLists();

  @Query('SELECT * FROM ItemList')
  Stream<List<ItemList>> getAllItemLists();

  @Query('SELECT * FROM ItemList WHERE listCategoryId = :listCategoryId')
  Stream<List<ItemList>> getItemListByItemListId(String listCategoryId);
}
