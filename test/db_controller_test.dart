import 'package:test/test.dart';

import '../lib/controllers/db_controller.dart';
import '../lib/models/list_category.dart';

void main() {
  group('Tests', () {
    test('create database', () async {
      final Stream<List<ListCategory>> categories =
          await DBController.getDB()!.listCategoryDao.getAllCategories();
      print('test');
    });
  });
}
