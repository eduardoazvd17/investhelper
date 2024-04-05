import 'package:investhelper/src/features/investments/enums/category_enum.dart';

class InvestmentModel {
  final String id;
  final String userId;
  final String name;
  final CategoryEnum category;
  final int custodialPosition;
  final double amountInvested;
  final double averagePrice;

  bool get hasData => custodialPosition > 0;

  InvestmentModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.category,
    required this.custodialPosition,
    required this.amountInvested,
    required this.averagePrice,
  });
}
