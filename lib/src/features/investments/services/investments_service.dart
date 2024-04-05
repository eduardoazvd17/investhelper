import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:investhelper/src/features/investments/models/create_goal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/exceptions/app_exception.dart';
import '../models/daily_tip_dto.dart';
import '../models/goal_model.dart';

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
    } catch (_) {
      throw AppException(AppExceptionType.connectionError);
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
    } catch (_) {
      throw AppException(AppExceptionType.connectionError);
    }
  }

  Future<bool> deleteGoal(GoalModel goalModel) async {
    try {
      await _firestore.collection('goals').doc(goalModel.id).delete();
      return true;
    } on AppException catch (_) {
      rethrow;
    } catch (_) {
      throw AppException(AppExceptionType.connectionError);
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
    } catch (_) {
      throw AppException(AppExceptionType.connectionError);
    }
  }
}
