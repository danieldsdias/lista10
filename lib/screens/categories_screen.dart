import 'package:flutter/material.dart';
import 'package:lista10/models/list_category.dart';

import '../infra/fake_data.dart';
import '../widgets/category_item.dart';
import '../controllers/db_controller.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/';

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
        onPressed: () {},
      ),
    );
  }
}
