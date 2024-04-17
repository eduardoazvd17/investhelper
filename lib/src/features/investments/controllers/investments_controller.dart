import 'package:mobx/mobx.dart';

import '../../../core/controllers/app_controller.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/models/user_model.dart';
import '../../../core/utils/date_time_utils.dart';
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
      thisMonthOperations.addAll(
        await _service.loadOperations(
          user!.id,
          startDate: DateTimeUtils.currentMonthFirstDay,
          endDate: DateTime.now(),
          descending: true,
        ),
      );
      filteredOperations.addAll(thisMonthOperations);
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

      allOperations?.removeWhere(
        (e) => e.investmentId == investmentModel.id,
      );
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

  @observable
  ObservableList<OperationModel>? allOperations;

  @observable
  ObservableList<OperationModel> filteredOperations =
      ObservableList<OperationModel>();

  @observable
  String? investmentIdFilter;

  @observable
  OperationTypeEnum? operationTypeFilter;

  @observable
  DateTime? startDateFilter = DateTimeUtils.currentMonthFirstDay;

  @observable
  DateTime? endDateFilter = DateTime.now();

  @observable
  bool descendingFilter = true;

  @action
  Future<void> onChangeOperationsFilters() async {
    try {
      final List<OperationModel> operations;
      final bool hasDate = startDateFilter != null && endDateFilter != null;

      if (allOperations != null) {
        operations = List<OperationModel>.from(allOperations!);
      } else if (hasDate &&
          !startDateFilter!.isBefore(DateTimeUtils.currentMonthFirstDay) &&
          DateTimeUtils.isSameMonth(DateTime.now(), endDateFilter!)) {
        operations = List<OperationModel>.from(thisMonthOperations);
      } else {
        operations = await _service.loadOperations(
          user!.id,
          startDate: startDateFilter,
          endDate: endDateFilter,
          operationType: operationTypeFilter,
          investmentId: investmentIdFilter,
          limit: null,
          descending: descendingFilter,
        );
        if (!hasDate &&
            operationTypeFilter == null &&
            investmentIdFilter == null) {
          allOperations = ObservableList.of(operations);
        }
      }

      _filterAndSortOperations(operations);
      filteredOperations.clear();
      filteredOperations.addAll(operations);
    } on AppException catch (_) {
      rethrow;
    }
  }

  @action
  void resetOperationsFilters() {
    investmentIdFilter = null;
    operationTypeFilter = null;
    startDateFilter = DateTimeUtils.currentMonthFirstDay;
    endDateFilter = DateTime.now();
    descendingFilter = true;
  }

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

      allOperations?.add(newOperation);

      filteredOperations.add(newOperation);
      _filterAndSortOperations(filteredOperations);

      if (DateTimeUtils.isSameMonth(DateTime.now(), newOperation.date)) {
        thisMonthOperations.add(newOperation);
        _filterAndSortOperations(thisMonthOperations, sortOnly: true);
      }
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

      allOperations?.remove(operationModel);
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

  void _filterAndSortOperations(
    List<OperationModel> operations, {
    bool sortOnly = false,
  }) {
    if (!sortOnly && startDateFilter != null && endDateFilter != null) {
      operations.removeWhere(
        (e) {
          final now = DateTime.now();
          final DateTime endDate = DateTimeUtils.isSameDay(now, endDateFilter!)
              ? now
              : DateTimeUtils.withLastSecondOfDay(endDateFilter!);
          return e.date.isBefore(DateTimeUtils.removeTime(startDateFilter!)) ||
              e.date.isAfter(endDate);
        },
      );
    }

    if (!sortOnly && investmentIdFilter != null) {
      operations.removeWhere((e) => e.investmentId != investmentIdFilter);
    }

    if (!sortOnly && operationTypeFilter != null) {
      operations.removeWhere((e) => e.type != operationTypeFilter);
    }

    operations.sort((a, b) {
      if (descendingFilter) {
        return b.date.compareTo(a.date);
      } else {
        return a.date.compareTo(b.date);
      }
    });
  }
}
