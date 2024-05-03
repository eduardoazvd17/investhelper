import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String name;
  final String email;
  final UserDataModel data;

  String get shortName => name.split(' ').first;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.data,
  });

  UserModel copyWith({
    String? name,
    UserDataModel? data,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email,
      data: data ?? this.data,
    );
  }
}

class UserDataModel {
  final DateTime registerDate;
  final DateTime? subscriptionStart;
  final DateTime? subscriptionEnd;

  UserDataModel({
    required this.registerDate,
    this.subscriptionStart,
    this.subscriptionEnd,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'registerDate': registerDate.millisecondsSinceEpoch,
      'subscriptionStart': subscriptionStart?.millisecondsSinceEpoch,
      'subscriptionEnd': subscriptionEnd?.millisecondsSinceEpoch,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      registerDate:
          DateTime.fromMillisecondsSinceEpoch(map['registerDate'] as int),
      subscriptionStart: map['subscriptionStart'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['subscriptionStart'] as int)
          : null,
      subscriptionEnd: map['subscriptionEnd'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['subscriptionEnd'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserDataModel copyWith({
    required DateTime? subscriptionStart,
    required DateTime? subscriptionEnd,
  }) {
    return UserDataModel(
      registerDate: registerDate,
      subscriptionStart: subscriptionStart,
      subscriptionEnd: subscriptionEnd,
    );
  }
}
