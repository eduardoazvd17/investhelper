import 'package:investhelper/src/features/investments/enums/category_enum.dart';

class CreateInvestmentModel {
  final String name;
  final CategoryEnum category;
  final int? custodialPosition;
  final double? amountInvested;
  final double? averagePrice;

  CreateInvestmentModel({
    required this.name,
    required this.category,
    this.custodialPosition,
    this.amountInvested,
    this.averagePrice,
  });
}
