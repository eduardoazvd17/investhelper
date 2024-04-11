// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';
import 'package:investhelper/src/features/investments/enums/operation_type.dart';

class OperationModel {
  final String id;
  final String userId;
  final String investmentId;
  final OperationTypeEnum type;
  final DateTime date;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  double get value => max(quantity * unitPrice, totalPrice);

  OperationModel({
    required this.id,
    required this.userId,
    required this.investmentId,
    required this.type,
    required this.date,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  OperationModel copyWith({
    OperationTypeEnum? type,
    DateTime? date,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
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
    );
  }
}
