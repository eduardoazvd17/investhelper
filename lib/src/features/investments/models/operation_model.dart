import 'package:investhelper/src/features/investments/enums/operation_type.dart';

class OperationModel {
  final String id;
  final OperationTypeEnum type;
  final DateTime date;
  final int quantity;
  final double unitPrice;
  final String? annotation;

  OperationModel({
    required this.id,
    required this.type,
    required this.date,
    required this.quantity,
    required this.unitPrice,
    this.annotation,
  });
}
