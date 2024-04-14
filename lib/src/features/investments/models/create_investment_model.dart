// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../enums/category_enum.dart';

class CreateInvestmentModel {
  final String userId;
  final String name;
  final CategoryEnum category;
  final int custodialPosition;
  final double averagePrice;
  final double amountInvested;
  final DateTime creationDate;
  final DateTime? lastOperationDate;

  CreateInvestmentModel({
    required this.userId,
    required this.name,
    required this.category,
    required this.custodialPosition,
    required this.averagePrice,
    required this.amountInvested,
    required this.creationDate,
    required this.lastOperationDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'category': category.index,
      'custodialPosition': custodialPosition,
      'averagePrice': averagePrice,
      'amountInvested': amountInvested,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'lastOperationDate': lastOperationDate?.millisecondsSinceEpoch,
    };
  }
}
