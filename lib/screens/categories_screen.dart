import 'package:flutter/material.dart';
import 'package:lista10/models/list_category.dart';

import '../widgets/category_item.dart';
import '../widgets/new_item.dart';
import '../controllers/db_controller.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/';

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

  void _startAddNewItem(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () => {},
          behavior: HitTestBehavior.opaque,
          child: NewItem(_addNewCategory, color),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias de listas'),
      ),
      body: StreamBuilder<Object>(
          stream: DBController.getDB()!.listCategoryDao.getAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: (Text('${snapshot.error}')));
            } else if (snapshot.hasData) {
              var listCategoryList = snapshot.data as List<ListCategory>;
              return GridView(
                padding: EdgeInsets.all(10),
                children: listCategoryList
                    .map((catData) => CategoryItem(catData.id.toString(),
                        catData.title!, Color(catData.color!)))
                    .toList(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewItem(context),
      ),
    );
  }
}
