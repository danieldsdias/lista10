import 'package:flutter/material.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:lista10/models/list_category.dart';

import '../infra/fake_data.dart';
import 'list_details_screen.dart';
import '../models/item_list.dart';
import '../models/screen_arguments.dart';
import '../controllers/db_controller.dart';
import '../widgets/new_item.dart';

class CategoryListsScreen extends StatefulWidget {
  CategoryListsScreen({Key? key}) : super(key: key);

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

  void _startAddNewItem(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () => {},
          behavior: HitTestBehavior.opaque,
          child: NewItem(_addNewItem),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    listCategoryId = args.id!;
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
                    onTap: () => Navigator.of(context)
                        .pushNamed(ListDetailsScreen.routeName, arguments: {
                      'itemListId': categoryLists[index].id.toString(),
                      'title': categoryLists[index].title,
                    }),
                    splashColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(_borderRadius),
                    child: Card(
                        margin: EdgeInsets.symmetric(
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
                              icon: Icon(Icons.delete),
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
                child: Icon(Icons.add),
                onPressed: () => _startAddNewItem(context),
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
