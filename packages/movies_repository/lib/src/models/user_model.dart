class UserModel {
  final String id;
  final String name;

  const UserModel({
    required this.id,
    required this.name,
  });

  static UserModel fromMap({required Map map}) => UserModel(
        id: map['id'],
        name: map['name'],
      );

  static const empty = UserModel(id: 'guest', name: 'guest');
}
