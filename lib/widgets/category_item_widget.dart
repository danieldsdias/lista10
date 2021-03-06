import 'package:flutter/material.dart';
import 'package:lista10/models/screen_arguments.dart';
import 'package:lista10/screens/category_lists_screen.dart';

class CategoryItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final double _borderRadius = 15;

  const CategoryItemWidget(this.id, this.title, this.color, {Key? key})
      : super(key: key);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryListsScreen.routeName,
        arguments: ScreenArguments(
          listCategoryId: id,
          title: title,
          color: color,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: Container(
        padding: EdgeInsets.all(_borderRadius),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(_borderRadius)),
        child: Text(title),
      ),
    );
  }
}
