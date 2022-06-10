import 'package:floor/floor.dart';

enum CategoryType {
  market,
  house,
  personal,
  work,
}

@entity
class ListCategory {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? title;
  final int? color;
  final String? type;

  const ListCategory({
    this.id,
    this.title,
    this.type,
    this.color,
  });
}
