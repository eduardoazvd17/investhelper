// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:investhelper/src/features/investments/enums/category_enum.dart';

class InvestmentModel {
  final String id;
  final String userId;
  final String name;
  final CategoryEnum category;
  final int custodialPosition;
  final double averagePrice;
  final DateTime creationDate;

  double get amountInvested => custodialPosition * averagePrice;
  bool get hasData => custodialPosition > 0;

  InvestmentModel({
    required this.id,
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

  factory InvestmentModel.fromMap(Map<String, dynamic> map) {
    return InvestmentModel(
      id: map['id'] as String,
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

  factory InvestmentModel.fromJson(String source) =>
      InvestmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  InvestmentModel copyWith({
    String? name,
    CategoryEnum? category,
  }) {
    return InvestmentModel(
      id: id,
      userId: userId,
      name: name ?? this.name,
      category: category ?? this.category,
      custodialPosition: custodialPosition,
      averagePrice: averagePrice,
      creationDate: creationDate,
    );
  }
}
