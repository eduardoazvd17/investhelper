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
      final batch = _firestore.batch();
      batch.delete(
        _firestore.collection('investments').doc(investmentModel.id),
      );
      await _firestore
          .collection('operations')
          .where('investmentId', isEqualTo: investmentModel.id)
          .get()
          .then((query) => query.docs.map((e) => batch.delete(e.reference)));
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
        query = query.where(
          'date',
          isGreaterThanOrEqualTo: startDate?.millisecondsSinceEpoch,
          isLessThanOrEqualTo: endDate?.millisecondsSinceEpoch,
        );
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
      query.orderBy('date', descending: descending);

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
      final DocumentReference<Map<String, dynamic>> reference =
          _firestore.collection('operations').doc();
      await reference.set(createOperationModel.toMap());

      final int lastCustodialPosition;
      final double lastAveragePrice;
      if (investmentModel.category.needPositionAndAveragePrice &&
          createOperationModel.type == OperationTypeEnum.sale) {
        final List<OperationModel> afterPurchases = await loadOperations(
          investmentModel.userId,
          investmentId: investmentModel.id,
          startDate: createOperationModel.date,
          operationType: OperationTypeEnum.purchase,
          limit: 1,
        );

        if (afterPurchases.isNotEmpty) {
          final List<OperationModel> beforePurchases = await loadOperations(
            investmentModel.userId,
            investmentId: investmentModel.id,
            endDate: createOperationModel.date,
            operationType: OperationTypeEnum.purchase,
            limit: 1,
            descending: true,
          );

          if (beforePurchases.isNotEmpty) {
            final double purchaseLastAveragePrice =
                beforePurchases.first.lastAveragePrice;
            if (purchaseLastAveragePrice == 0) {
              lastCustodialPosition = beforePurchases.first.quantity;
              lastAveragePrice = beforePurchases.first.unitPrice;
            } else {
              final int custodialPosition = beforePurchases.first.quantity +
                  createOperationModel.quantity;
              final double averagePrice = ((beforePurchases.first.quantity *
                          beforePurchases.first.unitPrice) +
                      (createOperationModel.quantity *
                          createOperationModel.unitPrice)) /
                  custodialPosition;
              lastCustodialPosition = custodialPosition;
              lastAveragePrice = averagePrice;
            }
          } else {
            lastCustodialPosition = createOperationModel.lastCustodialPosition;
            lastAveragePrice = createOperationModel.lastAveragePrice;
          }
        } else {
          lastCustodialPosition = createOperationModel.lastCustodialPosition;
          lastAveragePrice = createOperationModel.lastAveragePrice;
        }
      } else {
        lastCustodialPosition = createOperationModel.lastCustodialPosition;
        lastAveragePrice = createOperationModel.lastAveragePrice;
      }

      final OperationModel operationModel = OperationModel(
        id: reference.id,
        userId: createOperationModel.userId,
        investmentId: createOperationModel.investmentId,
        type: createOperationModel.type,
        date: createOperationModel.date,
        quantity: createOperationModel.quantity,
        unitPrice: createOperationModel.unitPrice,
        totalPrice: createOperationModel.totalPrice,
        lastCustodialPosition: lastCustodialPosition,
        lastAveragePrice: lastAveragePrice,
      );

      final InvestmentModel newInvestment = _updateInvestmentValues(
        operationModel,
        investmentModel,
        false,
      );
      await editInvestment(newInvestment);

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
      await _firestore.collection('operations').doc(operationModel.id).delete();

      final InvestmentModel newInvestment = _updateInvestmentValues(
        operationModel,
        investmentModel,
        true,
      );
      await editInvestment(newInvestment);

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

  InvestmentModel _updateInvestmentValues(
    OperationModel operationModel,
    InvestmentModel investmentModel,
    bool isRemoving,
  ) {
    if (investmentModel.category.needPositionAndAveragePrice) {
      switch (operationModel.type) {
        case OperationTypeEnum.purchase:
          if (isRemoving) {
            final int custodialPosition =
                investmentModel.custodialPosition - operationModel.quantity;
            final double averagePrice = ((investmentModel.custodialPosition *
                        investmentModel.averagePrice) -
                    (operationModel.quantity * operationModel.unitPrice)) /
                custodialPosition;
            final bool isEmpty = custodialPosition <= 0 || averagePrice <= 0;
            return investmentModel.copyWith(
              custodialPosition: isEmpty ? 0 : custodialPosition,
              averagePrice: isEmpty ? 0 : averagePrice,
            );
          } else {
            final int custodialPosition =
                investmentModel.custodialPosition + operationModel.quantity;
            final double averagePrice = ((investmentModel.custodialPosition *
                        investmentModel.averagePrice) +
                    (operationModel.quantity * operationModel.unitPrice)) /
                custodialPosition;

            final bool isEmpty = custodialPosition <= 0 || averagePrice <= 0;
            return investmentModel.copyWith(
              custodialPosition: isEmpty ? 0 : custodialPosition,
              averagePrice: isEmpty ? 0 : averagePrice,
            );
          }
        case OperationTypeEnum.sale:
          if (isRemoving) {
            final int custodialPosition =
                investmentModel.custodialPosition + operationModel.quantity;
            final bool isEmpty =
                custodialPosition <= 0 || investmentModel.averagePrice <= 0;
            return investmentModel.copyWith(
              custodialPosition: isEmpty ? 0 : custodialPosition,
              averagePrice: isEmpty ? 0 : investmentModel.averagePrice,
            );
          } else {
            final int custodialPosition =
                investmentModel.custodialPosition - operationModel.quantity;
            final bool isEmpty =
                custodialPosition <= 0 || investmentModel.averagePrice <= 0;
            return investmentModel.copyWith(
              custodialPosition: isEmpty ? 0 : custodialPosition,
              averagePrice: isEmpty ? 0 : investmentModel.averagePrice,
            );
          }
      }
    } else {
      switch (operationModel.type) {
        case OperationTypeEnum.purchase:
          if (isRemoving) {
            final double amountInvested =
                investmentModel.amountInvested - operationModel.totalPrice;
            return investmentModel.copyWith(
              amountInvested: amountInvested <= 0 ? 0 : amountInvested,
            );
          } else {
            final double amountInvested =
                investmentModel.amountInvested + operationModel.totalPrice;
            return investmentModel.copyWith(
              amountInvested: amountInvested <= 0 ? 0 : amountInvested,
            );
          }
        case OperationTypeEnum.sale:
          if (isRemoving) {
            final double amountInvested =
                investmentModel.amountInvested + operationModel.totalPrice;
            return investmentModel.copyWith(
              amountInvested: amountInvested <= 0 ? 0 : amountInvested,
            );
          } else {
            final double amountInvested =
                investmentModel.amountInvested - operationModel.totalPrice;
            return investmentModel.copyWith(
              amountInvested: amountInvested <= 0 ? 0 : amountInvested,
            );
          }
      }
    }
  }
}
