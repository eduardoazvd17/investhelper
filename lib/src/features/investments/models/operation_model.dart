// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';
import '../enums/operation_type.dart';

class OperationModel {
  final String id;
  final String userId;
  final String investmentId;
  final OperationTypeEnum type;
  final DateTime date;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final double lastAveragePrice;

  double get value => max(quantity * unitPrice, totalPrice);

  double get profit {
    if (type == OperationTypeEnum.sale && lastAveragePrice > 0) {
      return (unitPrice - lastAveragePrice) * quantity;
    }
    return 0.0;
  }

  OperationModel({
    required this.id,
    required this.userId,
    required this.investmentId,
    required this.type,
    required this.date,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.lastAveragePrice,
  });

  OperationModel copyWith({
    OperationTypeEnum? type,
    DateTime? date,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    double? lastAveragePrice,
  }) {
    return OperationModel(
      id: id,
      userId: userId,
      investmentId: investmentId,
      type: type ?? this.type,
      date: date ?? this.date,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      lastAveragePrice: lastAveragePrice ?? this.lastAveragePrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'investmentId': investmentId,
      'type': type.index,
      'date': date.millisecondsSinceEpoch,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'lastAveragePrice': lastAveragePrice,
    };
  }

  factory OperationModel.fromMap(Map<String, dynamic> map) {
    return OperationModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      investmentId: map['investmentId'] as String,
      type: OperationTypeEnum.values[map['type'] as int],
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      quantity: map['quantity'] as int,
      unitPrice: map['unitPrice'] as double,
      totalPrice: map['totalPrice'] as double,
      lastAveragePrice: map['lastAveragePrice'] as double,
    );
  }
}
