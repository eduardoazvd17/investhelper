import 'package:mobx/mobx.dart';

class OperationModel {
  final String id;
  final OperationType type;
  final DateTime date;
  final int quantity;
  final int unitPrice;
  final String annotation;

  OperationModel({
    required this.id,
    required this.type,
    required this.date,
    required this.quantity,
    required this.unitPrice,
    required this.annotation,
  });
}
