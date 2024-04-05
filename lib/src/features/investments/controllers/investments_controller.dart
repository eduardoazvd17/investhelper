import 'package:investhelper/src/core/exceptions/app_exception.dart';
import 'package:investhelper/src/core/models/user_model.dart';
import 'package:investhelper/src/features/investments/enums/operation_type.dart';
import 'package:investhelper/src/features/investments/models/create_goal_model.dart';
import 'package:investhelper/src/features/investments/models/daily_tip_dto.dart';
import 'package:mobx/mobx.dart';

import '../../../core/controllers/app_controller.dart';
import '../models/goal_model.dart';
import '../models/investment_model.dart';
import '../models/operation_model.dart';
import '../services/investments_service.dart';
part 'investments_controller.g.dart';

class InvestmentsController = InvestmentsControllerBase
    with _$InvestmentsController;

abstract class InvestmentsControllerBase with Store {
  final AppController _appController;
  final InvestmentsService _service;
  InvestmentsControllerBase({
    required AppController appController,
    required InvestmentsService service,
  })  : _appController = appController,
        _service = service {
    loadUserData();
  }

  @observable
  bool isLoading = true;

  @action
  Future<void> loadUserData() async {
    hideValues = await _service.loadHideValues();
    dailyTip = await _service.loadDailyTip();

    if (user != null) {
      goals.addAll(await _service.loadGoals(user!.id));
      //investments
      //thisMonthOperations
    }

    isLoading = false;
  }

  @computed
  UserModel? get user => _appController.user;

  @computed
  bool get shouldRequestAuth => _appController.shouldRequestAuth;

  @observable
  bool hideValues = true;

  @action
  void toggleHideValues() {
    hideValues = !hideValues;
    _service.saveHideValues(hideValues);
  }

  @observable
  DailyTipDTO? dailyTip;

  @observable
  ObservableList<GoalModel> goals = ObservableList<GoalModel>();

  @action
  Future<bool> addNewGoal(CreateGoalModel createGoalModel) async {
    try {
      final GoalModel newGoal = await _service.addNewGoal(createGoalModel);
      goals.add(newGoal);
      goals.sort((a, b) => b.creationDate.compareTo(a.creationDate));
      return true;
    } on AppException catch (_) {
      rethrow;
    }
  }

  Future<bool> deleteGoal(GoalModel goalModel) async {
    try {
      goals.remove(goalModel);
      return await _service.deleteGoal(goalModel);
    } catch (_) {
      return false;
    }
  }

  @observable
  ObservableList<InvestmentModel> investments =
      ObservableList<InvestmentModel>();

  @computed
  double get totalInvestments {
    if (investments.isNotEmpty) {
      return investments.map((e) {
        return e.amountInvested;
      }).reduce((a, b) => a + b);
    }
    return 0.0;
  }

  @observable
  ObservableList<OperationModel> thisMonthOperations =
      ObservableList<OperationModel>();

  @computed
  double get thisMonthPurchasesTotal {
    if (thisMonthOperations.isNotEmpty) {
      final operations = thisMonthOperations.where((e) {
        return e.type == OperationTypeEnum.purchase;
      });

      return operations.isEmpty
          ? 0.0
          : operations.map((e) {
              return (e.quantity * e.unitPrice);
            }).reduce((a, b) => a + b);
    }
    return 0.0;
  }

  @computed
  double get thisMonthSalesTotal {
    if (thisMonthOperations.isNotEmpty) {
      final operations = thisMonthOperations.where((e) {
        return e.type == OperationTypeEnum.sale;
      });

      return operations.isEmpty
          ? 0.0
          : operations.map((e) {
              return (e.quantity * e.unitPrice);
            }).reduce((a, b) => a + b);
    }
    return 0.0;
  }
}
