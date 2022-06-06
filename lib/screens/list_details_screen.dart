import 'package:flutter/material.dart';
import 'package:lista10/main.dart';

import '../infra/fake_data.dart';

class ListDetailsScreen extends StatefulWidget {
  ListDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/list-details';

  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final itemListId = routeArgs['itemListId'];
    final listTitle = routeArgs['title'] as String;
    final itemList =
        DUMMY_ITEMS.where((item) => item.itemListId == itemListId).toList();

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
                trailing: MediaQuery.of(context).size.width > 360
                    ? TextButton.icon(
                        icon: Icon(Icons.delete),
                        label: Text('Delete'),
                        style: TextButton.styleFrom(
                            primary: Theme.of(context).errorColor),
                        onPressed: () {},
                      )
                    : IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () {},
                      ),
              )
              //Text(categoryLists[index].title),
              );
        },
        itemCount: itemList.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
