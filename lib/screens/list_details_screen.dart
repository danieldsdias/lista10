import 'package:flutter/material.dart';
import 'package:lista10_package/lista10_package.dart';

import '../models/screen_arguments.dart';
import '../models/item.dart';
import '../controllers/db_controller.dart';

class ListDetailsScreen extends StatefulWidget {
  const ListDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/list-details';

  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  late String listId;

  void _addNewItem(String title) {
    final newItem = Item(title: title, itemListId: listId);

    setState(() {
      DBController.getDB()!.itemDao.insertItem(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    listId = args.listId!;
    final listTitle = args.title!;
    final color = args.color!;

    return StreamBuilder<List<Item>>(
        stream: DBController.getDB()!.itemDao.getItemListByItemListId(listId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: (Text('${snapshot.error}')));
          } else if (snapshot.hasData) {
            var itemList = snapshot.data as List<Item>;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: color,
                title: Text(listTitle),
              ),
              body: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
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
                              child: Text(itemList[index].id.toString()),
                            ),
                          ),
                        ),
                        title: Text(itemList[index].title as String),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () async {
                            await DBController.getDB()!
                                .itemDao
                                .deleteById(itemList[index].id.toString());
                            setState(() {});
                          },
                        ),
                      )
                      //Text(categoryLists[index].title),
                      );
                },
                itemCount: itemList.length,
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
