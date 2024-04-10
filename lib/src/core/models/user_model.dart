// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  UserModel copyWith({
    String? name,
    String? email,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
