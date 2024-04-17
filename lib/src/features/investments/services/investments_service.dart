import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/exceptions/app_exception.dart';
import '../enums/category_enum.dart';
import '../enums/operation_type.dart';
import '../models/create_goal_model.dart';
import '../models/create_investment_model.dart';
import '../models/create_operation_model.dart';
import '../models/daily_tip_dto.dart';
import '../models/goal_model.dart';
import '../models/investment_model.dart';
import '../models/operation_model.dart';

class InvestmentsService {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  Future<void> saveHideValues(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('AppHideValues', value);
  }

  Future<bool> loadHideValues() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('AppHideValues') ?? true;
  }

  Future<List<GoalModel>> loadGoals(String userId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> query = await _firestore
          .collection('goals')
          .where('userId', isEqualTo: userId)
          .get();

      final goals = query.docs.map((doc) {
        final Map<String, dynamic> data = doc.data()..['id'] = doc.id;
        return GoalModel.fromMap(data);
      }).toList();
      goals.sort((a, b) => b.creationDate.compareTo(a.creationDate));
      return goals;
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<GoalModel> addNewGoal(CreateGoalModel createGoalModel) async {
    try {
      if (createGoalModel.description.isEmpty) {
        throw AppException(AppExceptionType.emptyFields);
      }

      final DocumentReference<Map<String, dynamic>> reference =
          _firestore.collection('goals').doc();
      await reference.set(createGoalModel.toMap());

      return GoalModel(
        id: reference.id,
        userId: createGoalModel.userId,
        description: createGoalModel.description,
        creationDate: createGoalModel.creationDate,
      );
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<GoalModel> editGoal(GoalModel goalModel) async {
    try {
      if (goalModel.description.isEmpty) {
        throw AppException(AppExceptionType.emptyFields);
      }

      final DocumentReference<Map<String, dynamic>> reference =
          _firestore.collection('goals').doc(goalModel.id);
      await reference.set(goalModel.toMap());
      return goalModel;
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<bool> deleteGoal(GoalModel goalModel) async {
    try {
      await _firestore.collection('goals').doc(goalModel.id).delete();
      return true;
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<List<InvestmentModel>> loadInvestments(String userId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> query = await _firestore
          .collection('investments')
          .where('userId', isEqualTo: userId)
          .get();

      final investments = query.docs.map((doc) {
        final Map<String, dynamic> data = doc.data()..['id'] = doc.id;
        return InvestmentModel.fromMap(data);
      }).toList();
      investments.sort((a, b) => b.creationDate.compareTo(a.creationDate));
      return investments;
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<InvestmentModel> addNewInvestment(
    CreateInvestmentModel createInvestmentModel,
  ) async {
    try {
      if (createInvestmentModel.name.isEmpty) {
        throw AppException(AppExceptionType.emptyFields);
      }

      if (createInvestmentModel.custodialPosition != 0 ||
          createInvestmentModel.averagePrice != 0 ||
          createInvestmentModel.amountInvested != 0 ||
          createInvestmentModel.cryptoPosition != 0) {
        if ((createInvestmentModel.category.hasQuotas &&
                (createInvestmentModel.custodialPosition <= 0 ||
                    createInvestmentModel.averagePrice <= 0)) ||
            (!createInvestmentModel.category.hasQuotas &&
                createInvestmentModel.amountInvested <= 0) ||
            (createInvestmentModel.category.isCrypto &&
                createInvestmentModel.cryptoPosition <= 0)) {
          throw AppException(AppExceptionType.invalidValue);
        }
      }

      final DocumentReference<Map<String, dynamic>> reference =
          _firestore.collection('investments').doc();
      await reference.set(createInvestmentModel.toMap());

      return InvestmentModel(
        id: reference.id,
        userId: createInvestmentModel.userId,
        name: createInvestmentModel.name,
        category: createInvestmentModel.category,
        custodialPosition: createInvestmentModel.custodialPosition,
        averagePrice: createInvestmentModel.averagePrice,
        amountInvested: createInvestmentModel.amountInvested,
        creationDate: createInvestmentModel.creationDate,
        lastOperationDate: createInvestmentModel.lastOperationDate,
        cryptoPosition: createInvestmentModel.cryptoPosition,
      );
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<InvestmentModel> editInvestment(InvestmentModel investment) async {
    try {
      if (investment.name.isEmpty) {
        throw AppException(AppExceptionType.emptyFields);
      }

      final DocumentReference<Map<String, dynamic>> reference =
          _firestore.collection('investments').doc(investment.id);
      await reference.set(investment.toMap());
      return investment;
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<bool> deleteInvestment(InvestmentModel investmentModel) async {
    try {
      final WriteBatch batch = _firestore.batch();

      final investmentReference =
          _firestore.collection('investments').doc(investmentModel.id);
      batch.delete(investmentReference);

      final operations = await _firestore
          .collection('operations')
          .where('investmentId', isEqualTo: investmentModel.id)
          .get();
      for (final operation in operations.docs) {
        batch.delete(operation.reference);
      }

      await batch.commit();
      return true;
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<List<OperationModel>> loadOperations(
    String userId, {
    DateTime? startDate,
    DateTime? endDate,
    OperationTypeEnum? operationType,
    String? investmentId,
    int? limit,
    bool descending = false,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore
          .collection('operations')
          .where('userId', isEqualTo: userId);

      if (startDate != null || endDate != null) {
        query = query
            .where(
              'date',
              isGreaterThanOrEqualTo: startDate?.millisecondsSinceEpoch,
              isLessThanOrEqualTo: endDate?.millisecondsSinceEpoch,
            )
            .orderBy('date', descending: descending);
      }
      if (investmentId != null) {
        query = query.where('investmentId', isEqualTo: investmentId);
      }
      if (operationType != null) {
        query = query.where('type', isEqualTo: operationType.index);
      }
      if (limit != null) {
        query = query.limit(limit);
      }

      final QuerySnapshot<Map<String, dynamic>> queryResult = await query.get();
      final operations = queryResult.docs.map((doc) {
        final Map<String, dynamic> data = doc.data()..['id'] = doc.id;
        return OperationModel.fromMap(data);
      }).toList();
      return operations;
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<(OperationModel, InvestmentModel)> addNewOperation(
    CreateOperationModel createOperationModel,
    InvestmentModel investmentModel,
  ) async {
    try {
      if ((createOperationModel.category.hasQuotas &&
              (createOperationModel.quantity <= 0 ||
                  createOperationModel.unitPrice <= 0)) ||
          (!createOperationModel.category.hasQuotas &&
              createOperationModel.totalPrice <= 0) ||
          (createOperationModel.category.isCrypto &&
              createOperationModel.cryptoQuantity == 0)) {
        throw AppException(AppExceptionType.invalidValue);
      }

      final DocumentReference<Map<String, dynamic>> reference =
          _firestore.collection('operations').doc();
      await reference.set(createOperationModel.toMap());

      final OperationModel operationModel = OperationModel(
        id: reference.id,
        userId: createOperationModel.userId,
        investmentId: createOperationModel.investmentId,
        type: createOperationModel.type,
        date: createOperationModel.date,
        quantity: createOperationModel.quantity,
        unitPrice: createOperationModel.unitPrice,
        totalPrice: createOperationModel.totalPrice,
        lastCustodialPosition: investmentModel.custodialPosition,
        lastAveragePrice: investmentModel.averagePrice,
        category: investmentModel.category,
        cryptoQuantity: createOperationModel.cryptoQuantity,
        lastCryptoPosition: investmentModel.cryptoPosition,
        lastAmountInvested: investmentModel.amountInvested,
      );

      final InvestmentModel newInvestment = await editInvestment(
        _updateInvestmentWithOperationValues(
          operationModel,
          investmentModel,
          false,
        ).copyWith(lastOperationDate: operationModel.date),
      );
      return (operationModel, newInvestment);
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<InvestmentModel> deleteOperation(
    OperationModel operationModel,
    InvestmentModel investmentModel,
  ) async {
    try {
      if (operationModel.date.isBefore(investmentModel.lastOperationDate!)) {
        throw AppException(AppExceptionType.generic);
      }

      await _firestore.collection('operations').doc(operationModel.id).delete();

      final List<OperationModel> beforeOperations = await loadOperations(
        investmentModel.userId,
        investmentId: investmentModel.id,
        endDate: operationModel.date,
        limit: 1,
        descending: true,
      );

      final DateTime? lastOperationDate =
          beforeOperations.isEmpty ? null : beforeOperations.first.date;

      final InvestmentModel newInvestment = await editInvestment(
        _updateInvestmentWithOperationValues(
          operationModel,
          investmentModel,
          true,
        ).copyWith(lastOperationDate: lastOperationDate),
      );

      return newInvestment;
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<DailyTipDTO> loadDailyTip() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> document =
          await _firestore.collection('dailyTips').doc('value').get();
      final Map<String, dynamic> data = document.data()!;

      final englishTips = List<Map<String, dynamic>>.from(
        jsonDecode(data['english']),
      );
      final portugueseTips = List<Map<String, dynamic>>.from(
        jsonDecode(data['portuguese']),
      );

      final int maxLength = min(englishTips.length, portugueseTips.length);
      final int index = Random().nextInt(maxLength);

      return DailyTipDTO(
        englishTitle: englishTips[index]['title']!,
        englishMessage: englishTips[index]['message']!,
        portugueseTitle: portugueseTips[index]['title']!,
        portugueseMessage: portugueseTips[index]['message']!,
      );
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  InvestmentModel _updateInvestmentWithOperationValues(
    OperationModel operationModel,
    InvestmentModel investmentModel,
    bool isRemoving,
  ) {
    if (investmentModel.category.hasQuotas) {
      switch (operationModel.type) {
        case OperationTypeEnum.purchase:
          final int custodialPosition = isRemoving
              ? (investmentModel.custodialPosition - operationModel.quantity)
              : (investmentModel.custodialPosition + operationModel.quantity);

          final double investmentTotalValue =
              investmentModel.custodialPosition * investmentModel.averagePrice;
          final double operationTotalValue =
              operationModel.quantity * operationModel.unitPrice;
          final double averagePrice = (isRemoving
                  ? (investmentTotalValue - operationTotalValue)
                  : (investmentTotalValue + operationTotalValue)) /
              custodialPosition;

          final bool isEmpty = custodialPosition <= 0 || averagePrice <= 0;
          return investmentModel.copyWith(
            custodialPosition: isEmpty ? 0 : custodialPosition,
            averagePrice: isEmpty ? 0 : averagePrice,
          );
        case OperationTypeEnum.sale:
          final int custodialPosition = isRemoving
              ? (investmentModel.custodialPosition + operationModel.quantity)
              : (investmentModel.custodialPosition - operationModel.quantity);

          final bool isEmpty =
              custodialPosition <= 0 || investmentModel.averagePrice <= 0;
          return investmentModel.copyWith(
            custodialPosition: isEmpty ? 0 : custodialPosition,
            averagePrice: isEmpty ? 0 : investmentModel.averagePrice,
          );
      }
    } else if (operationModel.category.isCrypto) {
      switch (operationModel.type) {
        case OperationTypeEnum.purchase:
          final double cryptoPosition = isRemoving
              ? (investmentModel.cryptoPosition - operationModel.cryptoQuantity)
              : (investmentModel.cryptoPosition +
                  operationModel.cryptoQuantity);

          final double amountInvested = isRemoving
              ? (investmentModel.amountInvested - operationModel.totalPrice)
              : (investmentModel.amountInvested + operationModel.totalPrice);

          final double averagePrice = (amountInvested / cryptoPosition);

          final bool isEmpty =
              amountInvested <= 0 || cryptoPosition <= 0 || averagePrice <= 0;
          return investmentModel.copyWith(
            cryptoPosition: isEmpty ? 0 : cryptoPosition,
            amountInvested: isEmpty ? 0 : amountInvested,
            averagePrice: isEmpty ? 0 : averagePrice,
          );
        case OperationTypeEnum.sale:
          final double cryptoPosition = isRemoving
              ? (investmentModel.cryptoPosition + operationModel.cryptoQuantity)
              : (investmentModel.cryptoPosition -
                  operationModel.cryptoQuantity);

          final double amountInvested = isRemoving
              ? (investmentModel.amountInvested + operationModel.totalPrice)
              : (investmentModel.amountInvested - operationModel.totalPrice);

          final double averagePrice = (amountInvested / cryptoPosition);
          final bool isEmpty =
              amountInvested <= 0 || cryptoPosition <= 0 || averagePrice <= 0;
          return investmentModel.copyWith(
            cryptoPosition: isEmpty ? 0 : cryptoPosition,
            amountInvested: isEmpty ? 0 : amountInvested,
            averagePrice: isEmpty ? 0 : averagePrice,
          );
      }
    } else {
      switch (operationModel.type) {
        case OperationTypeEnum.purchase:
          final double amountInvested = isRemoving
              ? (investmentModel.amountInvested - operationModel.totalPrice)
              : (investmentModel.amountInvested + operationModel.totalPrice);

          return investmentModel.copyWith(
            amountInvested: amountInvested <= 0 ? 0 : amountInvested,
          );
        case OperationTypeEnum.sale:
          final double amountInvested = isRemoving
              ? (investmentModel.amountInvested + operationModel.totalPrice)
              : (investmentModel.amountInvested - operationModel.totalPrice);

          return investmentModel.copyWith(
            amountInvested: amountInvested <= 0 ? 0 : amountInvested,
          );
      }
    }
  }
}
