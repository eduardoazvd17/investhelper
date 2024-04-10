// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:investhelper/src/features/investments/enums/category_enum.dart';

class CreateInvestmentModel {
  final String userId;
  final String name;
  final CategoryEnum category;
  final int custodialPosition;
  final double averagePrice;
  final DateTime creationDate;

  CreateInvestmentModel({
    required this.userId,
    required this.name,
    required this.category,
    required this.custodialPosition,
    required this.averagePrice,
    required this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'category': category.index,
      'custodialPosition': custodialPosition,
      'averagePrice': averagePrice,
      'creationDate': creationDate.millisecondsSinceEpoch,
    };
  }

  factory CreateInvestmentModel.fromMap(Map<String, dynamic> map) {
    return CreateInvestmentModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      category: CategoryEnum.values[map['category'] as int],
      custodialPosition: map['custodialPosition'] as int,
      averagePrice: map['averagePrice'] as double,
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateInvestmentModel.fromJson(String source) =>
      CreateInvestmentModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
