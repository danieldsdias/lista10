class UserModel {
  String id;
  final String name;
  final String? avatar;

  UserModel({
    this.id = '',
    required this.name,
    this.avatar,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        avatar: json['avatar'],
      );
}
