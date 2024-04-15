import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/controllers/app_controller.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/models/user_model.dart';
import '../enums/operation_type.dart';
import '../models/create_goal_model.dart';
import '../models/create_investment_model.dart';
import '../models/create_operation_model.dart';
import '../models/daily_tip_dto.dart';
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
      investments.addAll(await _service.loadInvestments(user!.id));
      final now = DateTime.now();
      thisMonthOperations.addAll(
        await _service.loadOperations(
          user!.id,
          startDate: DateTime(now.year, now.month, 1),
          endDate: DateTime(
            now.year,
            now.month,
            DateUtils.getDaysInMonth(now.year, now.month),
            23,
            59,
            59,
          ),
          descending: true,
        ),
      );
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
  Future<void> addNewGoal(CreateGoalModel createGoalModel) async {
    try {
      final GoalModel newGoal = await _service.addNewGoal(createGoalModel);
      goals.add(newGoal);
      goals.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    } on AppException catch (_) {
      rethrow;
    }
  }

  @action
  Future<void> editGoal(GoalModel goalModel) async {
    try {
      await _service.editGoal(goalModel);
      goals.removeWhere((e) => e.id == goalModel.id);
      goals.add(goalModel);
      goals.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    } on AppException catch (_) {
      rethrow;
    }
  }

  @action
  Future<void> deleteGoal(GoalModel goalModel) async {
    try {
      await _service.deleteGoal(goalModel);
      goals.remove(goalModel);
    } on AppException catch (_) {
      rethrow;
    }
  }

  @observable
  ObservableList<InvestmentModel> investments =
      ObservableList<InvestmentModel>();

  @action
  Future<void> addNewInvestment(
    CreateInvestmentModel createInvestmentModel,
  ) async {
    try {
      final InvestmentModel newInvestment =
          await _service.addNewInvestment(createInvestmentModel);
      investments.add(newInvestment);
      investments.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    } on AppException catch (_) {
      rethrow;
    }
  }

  @action
  Future<void> editInvestment(InvestmentModel investmentModel) async {
    try {
      await _service.editInvestment(investmentModel);
      investments.removeWhere((e) => e.id == investmentModel.id);
      investments.add(investmentModel);
      investments.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    } on AppException catch (_) {
      rethrow;
    }
  }

  @action
  Future<void> deleteInvestment(InvestmentModel investmentModel) async {
    try {
      await _service.deleteInvestment(investmentModel);
      investments.remove(investmentModel);

      filteredOperations.removeWhere(
        (e) => e.investmentId == investmentModel.id,
      );
      thisMonthOperations.removeWhere(
        (e) => e.investmentId == investmentModel.id,
      );
    } on AppException catch (_) {
      rethrow;
    }
  }

  @computed
  double get totalInvestments {
    if (investments.isNotEmpty) {
      return investments.map((e) {
        return e.value;
      }).reduce((a, b) => a + b);
    }
    return 0.0;
  }

  //TODO: CRIAR MECANISMO DE FILTRO.
  @observable
  ObservableList<OperationModel> filteredOperations =
      ObservableList<OperationModel>();

  @observable
  ObservableList<OperationModel> thisMonthOperations =
      ObservableList<OperationModel>();

  @action
  Future<void> addNewOperation(
    CreateOperationModel createOperationModel,
    InvestmentModel investmentModel,
  ) async {
    try {
      final (
        OperationModel newOperation,
        InvestmentModel newInvestment,
      ) = await _service.addNewOperation(
        createOperationModel,
        investmentModel,
      );

      investments.removeWhere((e) => e.id == newInvestment.id);
      investments.add(newInvestment);
      investments.sort((a, b) => b.creationDate.compareTo(a.creationDate));

      //TODO: ADICIONAR NA filteredOperations SE A DATA DE HOJE ESTIVER NOS FILTROS.

      thisMonthOperations.add(newOperation);
      thisMonthOperations.sort((a, b) => b.date.compareTo(a.date));
    } on AppException catch (_) {
      rethrow;
    }
  }

  @action
  Future<void> deleteOperation(
    OperationModel operationModel,
    InvestmentModel investmentModel,
  ) async {
    try {
      final InvestmentModel newInvestment =
          await _service.deleteOperation(operationModel, investmentModel);

      investments.removeWhere((e) => e.id == newInvestment.id);
      investments.add(newInvestment);
      investments.sort((a, b) => b.creationDate.compareTo(a.creationDate));

      filteredOperations.remove(operationModel);
      thisMonthOperations.remove(operationModel);
    } on AppException catch (_) {
      rethrow;
    }
  }

  @computed
  double get thisMonthPurchasesTotal {
    if (thisMonthOperations.isNotEmpty) {
      final operations = thisMonthOperations.where((e) {
        return e.type == OperationTypeEnum.purchase;
      });

      return operations.isEmpty
          ? 0.0
          : operations.map((e) => e.value).reduce((a, b) => a + b);
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
          : operations.map((e) => e.value).reduce((a, b) => a + b);
    }
    return 0.0;
  }

  @computed
  double get thisMonthProfitTotal {
    if (thisMonthOperations.isNotEmpty) {
      return thisMonthOperations.isEmpty
          ? 0.0
          : thisMonthOperations.map((e) => e.profit).reduce((a, b) => a + b);
    }
    return 0.0;
  }
}
