// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../enums/category_enum.dart';
import '../enums/operation_type.dart';

class CreateOperationModel {
  final String userId;
  final String investmentId;
  final OperationTypeEnum type;
  final DateTime date;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final int lastCustodialPosition;
  final double lastAveragePrice;
  final CategoryEnum category;
  final double cryptoQuantity;

  CreateOperationModel({
    required this.userId,
    required this.investmentId,
    required this.type,
    required this.date,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.lastCustodialPosition,
    required this.lastAveragePrice,
    required this.category,
    required this.cryptoQuantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'investmentId': investmentId,
      'type': type.index,
      'date': date.millisecondsSinceEpoch,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'lastCustodialPosition': lastCustodialPosition,
      'lastAveragePrice': lastAveragePrice,
      'category': category.index,
      'cryptoQuantity' : cryptoQuantity,
    };
  }
}
