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
  final DateTime? subscriptionStartDate;
  final DateTime? subscriptionEndDate;

  UserDataModel({
    required this.registerDate,
    this.subscription = SubscriptionEnum.freeWithAds,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
  });

  UserDataModel copyWith({
    required SubscriptionEnum? subscription,
    required DateTime? subscriptionStartDate,
    required DateTime? subscriptionEndDate,
  }) {
    return UserDataModel(
      registerDate: registerDate,
      subscription: subscription ?? this.subscription,
      subscriptionStartDate:
          subscriptionStartDate ?? this.subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'registerDate': registerDate.millisecondsSinceEpoch,
      'subscription': subscription.index,
      'subscriptionStartDate': subscriptionStartDate?.millisecondsSinceEpoch,
      'subscriptionEndDate': subscriptionEndDate?.millisecondsSinceEpoch,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      registerDate:
          DateTime.fromMillisecondsSinceEpoch(map['registerDate'] as int),
      subscription: SubscriptionEnum.values[map['subscription'] as int],
      subscriptionStartDate: map['subscriptionStartDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['subscriptionStartDate'] as int)
          : null,
      subscriptionEndDate: map['subscriptionEndDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['subscriptionEndDate'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
