import 'package:floor/floor.dart';

@entity
class ItemList {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? title;
  final String? listCategoryId;

  const ItemList({this.id, this.title, this.listCategoryId});
}
