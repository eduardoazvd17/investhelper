// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../enums/category_enum.dart';
import '../enums/operation_type.dart';

class OperationModel {
  final String id;
  final String userId;
  final String investmentId;
  final OperationTypeEnum type;
  final DateTime date;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final int lastCustodialPosition;
  final double lastAveragePrice;
  final CategoryEnum category;
  final double cryptoQuantity;
  final double lastCryptoPosition;
  final double lastAmountInvested;

  double get value {
    final double value;
    if (category.hasQuotas) {
      value = quantity * unitPrice;
    } else {
      value = totalPrice;
    }
    return value <= 0 ? 0 : value;
  }

  double get profit {
    if (type == OperationTypeEnum.sale) {
      if (category.hasQuotas && lastAveragePrice > 0) {
        return (unitPrice - lastAveragePrice) * quantity;
      }

      if (category.isCrypto && lastAveragePrice > 0) {
        final double difference = cryptoQuantity * lastAveragePrice;
        return totalPrice - difference;
      }
    }

    return 0.0;
  }

  double get averagePriceVariation {
    if (type == OperationTypeEnum.purchase && category.hasQuotas) {
      final double previousTotal = lastAveragePrice * lastCustodialPosition;
      final double operationTotal = unitPrice * quantity;
      final int custodialPosition = lastCustodialPosition + quantity;
      final double newAveragePrice =
          (previousTotal + operationTotal) / custodialPosition;
      return newAveragePrice - lastAveragePrice;
    }
    return 0.0;
  }

  OperationModel({
    required this.id,
    required this.userId,
    required this.investmentId,
    required this.type,
    required this.date,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.lastCustodialPosition,
    required this.lastAveragePrice,
    required this.category,
    required this.cryptoQuantity,
    required this.lastCryptoPosition,
    required this.lastAmountInvested,
  });

  OperationModel copyWith({
    OperationTypeEnum? type,
    DateTime? date,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    int? lastCustodialPosition,
    double? lastAveragePrice,
    double? cryptoQuantity,
    double? lastCryptoPosition,
    double? lastAmountInvested,
  }) {
    return OperationModel(
      id: id,
      userId: userId,
      investmentId: investmentId,
      type: type ?? this.type,
      date: date ?? this.date,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      lastCustodialPosition:
          lastCustodialPosition ?? this.lastCustodialPosition,
      lastAveragePrice: lastAveragePrice ?? this.lastAveragePrice,
      category: category,
      cryptoQuantity: cryptoQuantity ?? this.cryptoQuantity,
      lastCryptoPosition: lastCryptoPosition ?? this.lastCryptoPosition,
      lastAmountInvested: lastAmountInvested ?? this.lastAmountInvested,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'investmentId': investmentId,
      'type': type.index,
      'date': date.millisecondsSinceEpoch,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'lastCustodialPosition': lastCustodialPosition,
      'lastAveragePrice': lastAveragePrice,
      'category': category.index,
      'cryptoQuantity': cryptoQuantity,
      'lastCryptoPosition': lastCryptoPosition,
      'lastAmountInvested': lastAmountInvested,
    };
  }

  factory OperationModel.fromMap(Map<String, dynamic> map) {
    return OperationModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      investmentId: map['investmentId'] as String,
      type: OperationTypeEnum.values[map['type'] as int],
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      quantity: map['quantity'] as int,
      unitPrice: map['unitPrice'] as double,
      totalPrice: map['totalPrice'] as double,
      lastCustodialPosition: map['lastCustodialPosition'] as int,
      lastAveragePrice: map['lastAveragePrice'] as double,
      category: CategoryEnum.values[map['category'] as int],
      cryptoQuantity: map['cryptoQuantity'] as double,
      lastCryptoPosition: map['lastCryptoPosition'] as double,
      lastAmountInvested: map['lastAmountInvested'] as double,
    );
  }
}
