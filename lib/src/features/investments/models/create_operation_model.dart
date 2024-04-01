import 'package:mobx/mobx.dart';

class CreateOperationModel {
  final String investmentId;
  final OperationType type;
  final DateTime date;
  final int quantity;
  final double unitPrice;
  final String? annotation;

  CreateOperationModel({
    required this.investmentId,
    required this.type,
    required this.date,
    required this.quantity,
    required this.unitPrice,
    this.annotation,
  });
}
