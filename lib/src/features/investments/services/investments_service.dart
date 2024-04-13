import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:investhelper/src/features/investments/enums/category_enum.dart';
import 'package:investhelper/src/features/investments/enums/operation_type.dart';
import 'package:investhelper/src/features/investments/models/create_goal_model.dart';
import 'package:investhelper/src/features/investments/models/create_operation_model.dart';
import 'package:investhelper/src/features/investments/models/operation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/exceptions/app_exception.dart';
import '../models/create_investment_model.dart';
import '../models/daily_tip_dto.dart';
import '../models/goal_model.dart';
import '../models/investment_model.dart';

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
      await _firestore
          .collection('investments')
          .doc(investmentModel.id)
          .delete();
      return true;
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<List<OperationModel>> loadOperations(
    String userId, {
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> query = await _firestore
          .collection('operations')
          .where('userId', isEqualTo: userId)
          .where('date',
              isGreaterThanOrEqualTo: startDate.millisecondsSinceEpoch)
          .where('date', isLessThanOrEqualTo: endDate.millisecondsSinceEpoch)
          .get();

      final operations = query.docs.map((doc) {
        final Map<String, dynamic> data = doc.data()..['id'] = doc.id;
        return OperationModel.fromMap(data);
      }).toList();
      operations.sort((a, b) => b.date.compareTo(a.date));
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

      final OperationModel operationModel = OperationModel(
        id: reference.id,
        userId: createOperationModel.userId,
        investmentId: createOperationModel.investmentId,
        type: createOperationModel.type,
        date: createOperationModel.date,
        quantity: createOperationModel.quantity,
        unitPrice: createOperationModel.unitPrice,
        totalPrice: createOperationModel.totalPrice,
        lastAveragePrice: createOperationModel.lastAveragePrice,
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
    if (operationModel.type == OperationTypeEnum.purchase &&
        investmentModel.category.needPositionAndAveragePrice) {
      if (isRemoving) {
        final int custodialPosition =
            investmentModel.custodialPosition - operationModel.quantity;
        final double averagePrice = ((investmentModel.custodialPosition *
                    investmentModel.averagePrice) -
                (operationModel.quantity * operationModel.unitPrice)) /
            custodialPosition;

        return investmentModel.copyWith(
          custodialPosition: custodialPosition,
          averagePrice: averagePrice,
        );
      } else {
        final int custodialPosition =
            investmentModel.custodialPosition + operationModel.quantity;
        final double averagePrice = ((investmentModel.custodialPosition *
                    investmentModel.averagePrice) +
                (operationModel.quantity * operationModel.unitPrice)) /
            custodialPosition;

        return investmentModel.copyWith(
          custodialPosition: custodialPosition,
          averagePrice: averagePrice,
        );
      }
    } else {
      return investmentModel;
    }
  }
}
