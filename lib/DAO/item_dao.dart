import 'dart:core';
import 'package:floor/floor.dart';

import '../models/item.dart';

@dao
abstract class ItemDao {
  @insert
  Future<void> insertItem(Item item);

  @update
  Future<void> updateItem(Item item);

  @delete
  Future<void> deleteItem(Item item);

  @Query('DELETE * FROM Item')
  Future<void> deleteAllItems();

  @Query('SELECT * FROM Item')
  Stream<List<Item>> getAllItems();

  @Query('SELECT * FROM Item WHERE itemListId = :itemListId')
  Stream<List<Item>> getItemListByItemListId(String itemListId);
}
