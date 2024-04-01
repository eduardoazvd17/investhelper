import 'package:mobx/mobx.dart';

class CreateOperationModel {
  final OperationType type;
  final DateTime date;
  final int quantity;
  final int unitPrice;
  final String? annotation;

  CreateOperationModel({
    required this.type,
    required this.date,
    required this.quantity,
    required this.unitPrice,
    this.annotation,
  });
}
