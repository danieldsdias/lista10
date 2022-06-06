import 'package:flutter/material.dart';

enum CategoryType {
  market,
  house,
  personal,
  work,
}

class ListCategory {
  final String id;
  final String title;
  final Color color;
  final CategoryType type;

  const ListCategory({
    @required this.id,
    @required this.title,
    this.type = CategoryType.personal,
    this.color = Colors.orange,
  });
}
