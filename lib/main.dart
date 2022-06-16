import 'package:flutter/material.dart';

import 'infra/lista10_database.dart';
import 'screens/category_lists_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/list_details_screen.dart';
import 'controllers/db_controller.dart';

AppDatabase? database;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBController.openDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista 10',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.amber),
      ),
      initialRoute: CategoriesScreen.routeName,
      routes: {
        CategoriesScreen.routeName: (ctx) => const CategoriesScreen(),
        CategoryListsScreen.routeName: (ctx) => const CategoryListsScreen(),
        ListDetailsScreen.routeName: (ctx) => const ListDetailsScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
