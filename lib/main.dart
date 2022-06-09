import 'package:flutter/material.dart';

import 'infra/lista10_database.dart';
import 'screens/category_lists_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/list_details_screen.dart';
import 'controllers/db_controller.dart';

late AppDatabase? database = null;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBController.openDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista 10',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
      ),
      initialRoute: CategoriesScreen.routeName,
      routes: {
        CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
        CategoryListsScreen.routeName: (ctx) => CategoryListsScreen(),
        ListDetailsScreen.routeName: (ctx) => ListDetailsScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
