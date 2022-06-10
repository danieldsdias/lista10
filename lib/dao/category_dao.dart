import 'dart:core';
import 'package:floor/floor.dart';

import '../models/list_category.dart';

@dao
abstract class ListCategoryDao {
  @insert
  Future<void> insertData(ListCategory data);

  @update
  Future<void> updateData(ListCategory data);

  @delete
  Future<void> deleteData(ListCategory data);

  @Query('DELETE * FROM ListCategory')
  Future<void> deleteAllCategories();

  @Query('SELECT * FROM ListCategory')
  Stream<List<ListCategory>> getAllCategories();

  @Query('Delete FROM ListCategory WHERE id = :id')
  Future<void> deleteById(String id);
}
