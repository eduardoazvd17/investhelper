// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:investhelper/src/features/investments/enums/category_enum.dart';

class InvestmentModel {
  final String id;
  final String userId;
  final String name;
  final CategoryEnum category;
  final int custodialPosition;
  final double averagePrice;
  final double amountInvested;
  final DateTime creationDate;

  bool get hasData {
    return (custodialPosition > 0 && averagePrice > 0) || amountInvested > 0;
  }

  bool get isEmpty {
    return custodialPosition == 0 && averagePrice == 0 && amountInvested == 0;
  }

  InvestmentModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.category,
    required this.custodialPosition,
    required this.averagePrice,
    required this.amountInvested,
    required this.creationDate,
  });

  InvestmentModel copyWith({
    String? name,
    int? custodialPosition,
    double? averagePrice,
    double? amountInvested,
  }) {
    return InvestmentModel(
      id: id,
      userId: userId,
      name: name ?? this.name,
      category: category,
      custodialPosition: custodialPosition ?? this.custodialPosition,
      averagePrice: averagePrice ?? this.averagePrice,
      amountInvested: amountInvested ?? this.amountInvested,
      creationDate: creationDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'category': category.index,
      'custodialPosition': custodialPosition,
      'averagePrice': averagePrice,
      'amountInvested': amountInvested,
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
      amountInvested: map['amountInvested'] as double,
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int),
    );
  }
}
