import 'package:floor/floor.dart';

@entity
class Item {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? title;
  final String? itemListId;

  const Item({this.id, this.title, this.itemListId});
}
