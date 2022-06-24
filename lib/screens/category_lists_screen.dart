import 'package:flutter/material.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:lista10_package/lista10_package.dart';

import '../infra/fake_data.dart';
import 'list_details_screen.dart';
import '../models/item_list.dart';
import '../models/screen_arguments.dart';
import '../controllers/db_controller.dart';

class CategoryListsScreen extends StatefulWidget {
  const CategoryListsScreen({Key? key}) : super(key: key);

  static const routeName = '/category-lists';

  @override
  State<CategoryListsScreen> createState() => _CategoryListsScreenState();
}

class _CategoryListsScreenState extends State<CategoryListsScreen> {
  final itemLists = DUMMY_LISTS;
  final double _borderRadius = 15;
  late String listCategoryId;

  void _addNewItem(String title) {
    final newItem = ItemList(title: title, listCategoryId: listCategoryId);

    setState(() {
      DBController.getDB()!.itemListDao.insertData(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    listCategoryId = args.listCategoryId!;
    final String categoryTitle = args.title!;
    final color = args.color;

    return StreamBuilder<Object>(
        stream: DBController.getDB()!
            .itemListDao
            .getItemListByListCategoryId(listCategoryId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: (Text('${snapshot.error}')));
          } else if (snapshot.hasData) {
            var categoryLists = snapshot.data as List<ItemList>;
            return Scaffold(
              appBar: AppBar(
                title: Text(categoryTitle),
                backgroundColor: color,
              ),
              body: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      args.listId = categoryLists[index].id.toString();
                      args.title = categoryLists[index].title;

                      Navigator.of(context).pushNamed(
                          ListDetailsScreen.routeName,
                          arguments: args);
                    },
                    splashColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(_borderRadius),
                    child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 5,
                        ),
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: FittedBox(
                                child: Text(categoryLists[index].id.toString()),
                              ),
                            ),
                          ),
                          title: Text(categoryLists[index].title!),
                          trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () async {
                                if (await confirm(
                                  context,
                                  title: const Text('Confirmação'),
                                  content:
                                      const Text('Deseja excluir a lista?'),
                                  textOK: const Text('Sim'),
                                  textCancel: const Text('Não'),
                                )) {
                                  await DBController.getDB()!
                                      .itemListDao
                                      .deleteById(
                                          categoryLists[index].id.toString());
                                  setState(() {});
                                }
                              }),
                        )
                        //Text(categoryLists[index].title),
                        ),
                  );
                },
                itemCount: categoryLists.length,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () =>
                    NewItemWidget.startAddNewItem(context, _addNewItem),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
