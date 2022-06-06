import 'package:flutter/material.dart';

import '../infra/fake_data.dart';
import 'list_details_screen.dart';

class CategoryListsScreen extends StatefulWidget {
  CategoryListsScreen({Key? key}) : super(key: key);

  static const routeName = '/category-lists';

  @override
  State<CategoryListsScreen> createState() => _CategoryListsScreenState();
}

class _CategoryListsScreenState extends State<CategoryListsScreen> {
  final itemLists = DUMMY_LISTS;
  final double _borderRadius = 15;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final listCategoryId = routeArgs['id'];
    final String categoryTitle = routeArgs['title'] as String;
    final categoryLists = DUMMY_LISTS
        .where((itemList) => itemList.listCategoryId == listCategoryId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.of(context)
                .pushNamed(ListDetailsScreen.routeName, arguments: {
              'itemListId': categoryLists[index].id,
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
                        child: Text(categoryLists[index].id),
                      ),
                    ),
                  ),
                  title: Text(categoryLists[index].title),
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
                ),
          );
        },
        itemCount: categoryLists.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
