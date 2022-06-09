import 'package:flutter/material.dart';

import '../models/item.dart';
import '../controllers/db_controller.dart';
import '../widgets/new_item.dart';

class ListDetailsScreen extends StatefulWidget {
  ListDetailsScreen({Key? key}) : super(key: key);

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
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
    listId = routeArgs['itemListId'] as String;
    final listTitle = routeArgs['title'] as String;

    return StreamBuilder<List<Item>>(
        stream: DBController.getDB()!.itemDao.getItemListByItemListId(listId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: (Text('${snapshot.error}')));
          } else if (snapshot.hasData) {
            var itemList = snapshot.data as List<Item>;
            return Scaffold(
              appBar: AppBar(
                title: Text(listTitle),
              ),
              body: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
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
                              child: Text(itemList[index].id.toString()),
                            ),
                          ),
                        ),
                        title: Text(itemList[index].title as String),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
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
