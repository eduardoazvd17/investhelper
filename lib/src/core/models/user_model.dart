import 'dart:convert';

import '../enums/subscription_enum.dart';

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
  final SubscriptionEnum subscription;

  UserDataModel({
    required this.registerDate,
    this.subscription = SubscriptionEnum.free,
  });

  UserDataModel copyWith({
    required SubscriptionEnum? subscription,
  }) {
    return UserDataModel(
      registerDate: registerDate,
      subscription: subscription ?? this.subscription,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'registerDate': registerDate.millisecondsSinceEpoch,
      'subscription': subscription.index,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      registerDate: DateTime.fromMillisecondsSinceEpoch(
        int.parse(map['registerDate'].toStringAsFixed(0)),
      ),
      subscription: SubscriptionEnum.values[int.parse(
        map['subscription'].toStringAsFixed(0),
      )],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
