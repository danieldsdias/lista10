import 'package:floor/floor.dart';
import 'package:lista10/infra/lista10_database.dart';
import '../infra/fake_data.dart';

class DBController {
  static bool needInit = false;
  static AppDatabase? mainBase;

  static Future<AppDatabase?> openDatabase() async {
    if (mainBase != null) {
      return mainBase;
    } else {
      final callback = Callback(onCreate: (database, version) {
        needInit = true;
      });

      mainBase = await $FloorAppDatabase
          .databaseBuilder('lista10_database.db')
          .addCallback(callback)
          .build();

      if (needInit) {
        for (var item in DUMMY_LISTS) {
          await mainBase!.itemListDao.insertData(item);
        }

        for (var item in DUMMY_ITEMS) {
          await mainBase!.itemDao.insertItem(item);
        }

        for (var item in DUMMY_CATEGORIES) {
          await mainBase!.listCategoryDao.insertData(item);
        }

        needInit = false;
      }

      return mainBase;
    }
  }

  static AppDatabase? getDB() {
    return mainBase;
  }
}
