import 'package:investhelper/src/features/investments/models/category_model.dart';

class InvestmentModel {
  final String id;
  final String name;
  final CategoryModel category;
  final int custodialPosition;
  final double amountInvested;
  final double averagePrice;

  InvestmentModel({
    required this.id,
    required this.name,
    required this.category,
    required this.custodialPosition,
    required this.amountInvested,
    required this.averagePrice,
  });
}
