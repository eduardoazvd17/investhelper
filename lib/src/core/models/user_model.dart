class UserModel {
  final String id;
  final String name;
  final String email;

  String get shortName => name.split(' ').first;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });
}
