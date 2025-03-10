import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../enums/subscription_enum.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final UserDataModel data;

  String get shortName => name.split(' ').first;

  const UserModel({
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

  @override
  List<Object?> get props =>
      [id, name, email, data.registerDate, data.subscription, data.purchaseIds];
}

class UserDataModel {
  final DateTime registerDate;
  final SubscriptionEnum subscription;
  final List<String> purchaseIds;

  UserDataModel({
    required this.registerDate,
    this.subscription = SubscriptionEnum.free,
    this.purchaseIds = const [],
  });

  UserDataModel copyWith({
    SubscriptionEnum? subscription,
    List<String>? purchaseIds,
  }) {
    return UserDataModel(
      registerDate: registerDate,
      subscription: subscription ?? this.subscription,
      purchaseIds: purchaseIds ?? this.purchaseIds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'registerDate': registerDate.millisecondsSinceEpoch,
      'subscription': subscription.index,
      'purchaseIds': purchaseIds,
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
      purchaseIds: List<String>.from(map['purchaseIds'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
