import 'package:flutter/material.dart';
import 'package:lista10_package/lista10_package.dart';

import '../models/list_category.dart';
import '../screens/user_screen.dart';
import '../widgets/category_item_widget.dart';
import '../controllers/db_controller.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/categories';

  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Color color = Colors.blue;

  void _addNewCategory(String title, Color pickedColor) {
    final newCategory = ListCategory(
      title: title,
      type: CategoryType.personal.name,
      color: pickedColor.value,
    );

    setState(() {
      DBController.getDB()!.listCategoryDao.insertData(newCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias de listas'),
        actions: <Widget>[
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(UserScreen.routeName),
              icon: const Icon(Icons.person))
        ],
      ),
      body: StreamBuilder<Object>(
          stream: DBController.getDB()!.listCategoryDao.getAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: (Text('${snapshot.error}')));
            } else if (snapshot.hasData) {
              var listCategoryList = snapshot.data as List<ListCategory>;
              return GridView(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: listCategoryList
                    .map((catData) => CategoryItemWidget(catData.id.toString(),
                        catData.title!, Color(catData.color!)))
                    .toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        key: Key('AddCategoriesButton'),
        child: const Icon(Icons.add),
        onPressed: () =>
            NewItemWidget.startAddNewItem(context, _addNewCategory, color),
      ),
    );
  }
}
