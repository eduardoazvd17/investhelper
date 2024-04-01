import 'package:investhelper/src/features/investments/models/category_model.dart';

class CreateInvestmentModel {
  final String name;
  final CategoryModel category;
  final int custodialPosition;
  final double amountInvested;
  final double averagePrice;

  CreateInvestmentModel({
    required this.name,
    required this.category,
    required this.custodialPosition,
    required this.amountInvested,
    required this.averagePrice,
  });
}
