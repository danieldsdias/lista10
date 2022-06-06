import 'package:flutter/material.dart';

import 'screens/category_lists_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/list_details_screen.dart';

void main() => runApp(MyApp());

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
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        CategoryListsScreen.routeName: (ctx) => CategoryListsScreen(),
        ListDetailsScreen.routeName: (ctx) => ListDetailsScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
