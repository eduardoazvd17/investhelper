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
}
