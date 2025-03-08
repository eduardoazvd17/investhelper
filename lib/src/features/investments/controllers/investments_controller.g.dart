// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investments_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InvestmentsController on InvestmentsControllerBase, Store {
  Computed<UserModel?>? _$userComputed;

  @override
  UserModel? get user =>
      (_$userComputed ??= Computed<UserModel?>(() => super.user,
              name: 'InvestmentsControllerBase.user'))
          .value;
  Computed<double>? _$totalInvestmentsComputed;

  @override
  double get totalInvestments => (_$totalInvestmentsComputed ??=
          Computed<double>(() => super.totalInvestments,
              name: 'InvestmentsControllerBase.totalInvestments'))
      .value;
  Computed<bool>? _$canAddMoreInvestmentsComputed;

  @override
  bool get canAddMoreInvestments => (_$canAddMoreInvestmentsComputed ??=
          Computed<bool>(() => super.canAddMoreInvestments,
              name: 'InvestmentsControllerBase.canAddMoreInvestments'))
      .value;
  Computed<double>? _$thisMonthPurchasesTotalComputed;

  @override
  double get thisMonthPurchasesTotal => (_$thisMonthPurchasesTotalComputed ??=
          Computed<double>(() => super.thisMonthPurchasesTotal,
              name: 'InvestmentsControllerBase.thisMonthPurchasesTotal'))
      .value;
  Computed<double>? _$thisMonthSalesTotalComputed;

  @override
  double get thisMonthSalesTotal => (_$thisMonthSalesTotalComputed ??=
          Computed<double>(() => super.thisMonthSalesTotal,
              name: 'InvestmentsControllerBase.thisMonthSalesTotal'))
      .value;
  Computed<double>? _$thisMonthProfitTotalComputed;

  @override
  double get thisMonthProfitTotal => (_$thisMonthProfitTotalComputed ??=
          Computed<double>(() => super.thisMonthProfitTotal,
              name: 'InvestmentsControllerBase.thisMonthProfitTotal'))
      .value;

  late final _$dailyTipAtom =
      Atom(name: 'InvestmentsControllerBase.dailyTip', context: context);

  @override
  DailyTipDTO? get dailyTip {
    _$dailyTipAtom.reportRead();
    return super.dailyTip;
  }

  @override
  set dailyTip(DailyTipDTO? value) {
    _$dailyTipAtom.reportWrite(value, super.dailyTip, () {
      super.dailyTip = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'InvestmentsControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loadUserDataErrorAtom = Atom(
      name: 'InvestmentsControllerBase.loadUserDataError', context: context);

  @override
  AppExceptionType? get loadUserDataError {
    _$loadUserDataErrorAtom.reportRead();
    return super.loadUserDataError;
  }

  @override
  set loadUserDataError(AppExceptionType? value) {
    _$loadUserDataErrorAtom.reportWrite(value, super.loadUserDataError, () {
      super.loadUserDataError = value;
    });
  }

  late final _$hideValuesAtom =
      Atom(name: 'InvestmentsControllerBase.hideValues', context: context);

  @override
  bool get hideValues {
    _$hideValuesAtom.reportRead();
    return super.hideValues;
  }

  @override
  set hideValues(bool value) {
    _$hideValuesAtom.reportWrite(value, super.hideValues, () {
      super.hideValues = value;
    });
  }

  late final _$goalsAtom =
      Atom(name: 'InvestmentsControllerBase.goals', context: context);

  @override
  ObservableList<GoalModel> get goals {
    _$goalsAtom.reportRead();
    return super.goals;
  }

  @override
  set goals(ObservableList<GoalModel> value) {
    _$goalsAtom.reportWrite(value, super.goals, () {
      super.goals = value;
    });
  }

  late final _$investmentsAtom =
      Atom(name: 'InvestmentsControllerBase.investments', context: context);

  @override
  ObservableList<InvestmentModel> get investments {
    _$investmentsAtom.reportRead();
    return super.investments;
  }

  @override
  set investments(ObservableList<InvestmentModel> value) {
    _$investmentsAtom.reportWrite(value, super.investments, () {
      super.investments = value;
    });
  }

  late final _$allOperationsAtom =
      Atom(name: 'InvestmentsControllerBase.allOperations', context: context);

  @override
  ObservableList<OperationModel>? get allOperations {
    _$allOperationsAtom.reportRead();
    return super.allOperations;
  }

  @override
  set allOperations(ObservableList<OperationModel>? value) {
    _$allOperationsAtom.reportWrite(value, super.allOperations, () {
      super.allOperations = value;
    });
  }

  late final _$filteredOperationsAtom = Atom(
      name: 'InvestmentsControllerBase.filteredOperations', context: context);

  @override
  ObservableList<OperationModel> get filteredOperations {
    _$filteredOperationsAtom.reportRead();
    return super.filteredOperations;
  }

  @override
  set filteredOperations(ObservableList<OperationModel> value) {
    _$filteredOperationsAtom.reportWrite(value, super.filteredOperations, () {
      super.filteredOperations = value;
    });
  }

  late final _$investmentIdFilterAtom = Atom(
      name: 'InvestmentsControllerBase.investmentIdFilter', context: context);

  @override
  String? get investmentIdFilter {
    _$investmentIdFilterAtom.reportRead();
    return super.investmentIdFilter;
  }

  @override
  set investmentIdFilter(String? value) {
    _$investmentIdFilterAtom.reportWrite(value, super.investmentIdFilter, () {
      super.investmentIdFilter = value;
    });
  }

  late final _$operationTypeFilterAtom = Atom(
      name: 'InvestmentsControllerBase.operationTypeFilter', context: context);

  @override
  OperationTypeEnum? get operationTypeFilter {
    _$operationTypeFilterAtom.reportRead();
    return super.operationTypeFilter;
  }

  @override
  set operationTypeFilter(OperationTypeEnum? value) {
    _$operationTypeFilterAtom.reportWrite(value, super.operationTypeFilter, () {
      super.operationTypeFilter = value;
    });
  }

  late final _$startDateFilterAtom =
      Atom(name: 'InvestmentsControllerBase.startDateFilter', context: context);

  @override
  DateTime? get startDateFilter {
    _$startDateFilterAtom.reportRead();
    return super.startDateFilter;
  }

  @override
  set startDateFilter(DateTime? value) {
    _$startDateFilterAtom.reportWrite(value, super.startDateFilter, () {
      super.startDateFilter = value;
    });
  }

  late final _$endDateFilterAtom =
      Atom(name: 'InvestmentsControllerBase.endDateFilter', context: context);

  @override
  DateTime? get endDateFilter {
    _$endDateFilterAtom.reportRead();
    return super.endDateFilter;
  }

  @override
  set endDateFilter(DateTime? value) {
    _$endDateFilterAtom.reportWrite(value, super.endDateFilter, () {
      super.endDateFilter = value;
    });
  }

  late final _$descendingFilterAtom = Atom(
      name: 'InvestmentsControllerBase.descendingFilter', context: context);

  @override
  bool get descendingFilter {
    _$descendingFilterAtom.reportRead();
    return super.descendingFilter;
  }

  @override
  set descendingFilter(bool value) {
    _$descendingFilterAtom.reportWrite(value, super.descendingFilter, () {
      super.descendingFilter = value;
    });
  }

  late final _$thisMonthOperationsAtom = Atom(
      name: 'InvestmentsControllerBase.thisMonthOperations', context: context);

  @override
  ObservableList<OperationModel> get thisMonthOperations {
    _$thisMonthOperationsAtom.reportRead();
    return super.thisMonthOperations;
  }

  @override
  set thisMonthOperations(ObservableList<OperationModel> value) {
    _$thisMonthOperationsAtom.reportWrite(value, super.thisMonthOperations, () {
      super.thisMonthOperations = value;
    });
  }

  late final _$loadUserDataAsyncAction =
      AsyncAction('InvestmentsControllerBase.loadUserData', context: context);

  @override
  Future<void> loadUserData() {
    return _$loadUserDataAsyncAction.run(() => super.loadUserData());
  }

  late final _$addNewGoalAsyncAction =
      AsyncAction('InvestmentsControllerBase.addNewGoal', context: context);

  @override
  Future<void> addNewGoal(CreateGoalModel createGoalModel) {
    return _$addNewGoalAsyncAction.run(() => super.addNewGoal(createGoalModel));
  }

  late final _$editGoalAsyncAction =
      AsyncAction('InvestmentsControllerBase.editGoal', context: context);

  @override
  Future<void> editGoal(GoalModel goalModel) {
    return _$editGoalAsyncAction.run(() => super.editGoal(goalModel));
  }

  late final _$deleteGoalAsyncAction =
      AsyncAction('InvestmentsControllerBase.deleteGoal', context: context);

  @override
  Future<void> deleteGoal(GoalModel goalModel) {
    return _$deleteGoalAsyncAction.run(() => super.deleteGoal(goalModel));
  }

  late final _$addNewInvestmentAsyncAction = AsyncAction(
      'InvestmentsControllerBase.addNewInvestment',
      context: context);

  @override
  Future<void> addNewInvestment(CreateInvestmentModel createInvestmentModel) {
    return _$addNewInvestmentAsyncAction
        .run(() => super.addNewInvestment(createInvestmentModel));
  }

  late final _$editInvestmentAsyncAction =
      AsyncAction('InvestmentsControllerBase.editInvestment', context: context);

  @override
  Future<void> editInvestment(InvestmentModel investmentModel) {
    return _$editInvestmentAsyncAction
        .run(() => super.editInvestment(investmentModel));
  }

  late final _$deleteInvestmentAsyncAction = AsyncAction(
      'InvestmentsControllerBase.deleteInvestment',
      context: context);

  @override
  Future<void> deleteInvestment(InvestmentModel investmentModel) {
    return _$deleteInvestmentAsyncAction
        .run(() => super.deleteInvestment(investmentModel));
  }

  late final _$onChangeOperationsFiltersAsyncAction = AsyncAction(
      'InvestmentsControllerBase.onChangeOperationsFilters',
      context: context);

  @override
  Future<void> onChangeOperationsFilters() {
    return _$onChangeOperationsFiltersAsyncAction
        .run(() => super.onChangeOperationsFilters());
  }

  late final _$addNewOperationAsyncAction = AsyncAction(
      'InvestmentsControllerBase.addNewOperation',
      context: context);

  @override
  Future<void> addNewOperation(CreateOperationModel createOperationModel,
      InvestmentModel investmentModel) {
    return _$addNewOperationAsyncAction.run(
        () => super.addNewOperation(createOperationModel, investmentModel));
  }

  late final _$deleteOperationAsyncAction = AsyncAction(
      'InvestmentsControllerBase.deleteOperation',
      context: context);

  @override
  Future<void> deleteOperation(
      OperationModel operationModel, InvestmentModel investmentModel) {
    return _$deleteOperationAsyncAction
        .run(() => super.deleteOperation(operationModel, investmentModel));
  }

  late final _$loadThisMonthOperationsAsyncAction = AsyncAction(
      'InvestmentsControllerBase.loadThisMonthOperations',
      context: context);

  @override
  Future<void> loadThisMonthOperations() {
    return _$loadThisMonthOperationsAsyncAction
        .run(() => super.loadThisMonthOperations());
  }

  late final _$InvestmentsControllerBaseActionController =
      ActionController(name: 'InvestmentsControllerBase', context: context);

  @override
  void toggleHideValues() {
    final _$actionInfo = _$InvestmentsControllerBaseActionController
        .startAction(name: 'InvestmentsControllerBase.toggleHideValues');
    try {
      return super.toggleHideValues();
    } finally {
      _$InvestmentsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetOperationsFilters() {
    final _$actionInfo = _$InvestmentsControllerBaseActionController
        .startAction(name: 'InvestmentsControllerBase.resetOperationsFilters');
    try {
      return super.resetOperationsFilters();
    } finally {
      _$InvestmentsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dailyTip: ${dailyTip},
isLoading: ${isLoading},
loadUserDataError: ${loadUserDataError},
hideValues: ${hideValues},
goals: ${goals},
investments: ${investments},
allOperations: ${allOperations},
filteredOperations: ${filteredOperations},
investmentIdFilter: ${investmentIdFilter},
operationTypeFilter: ${operationTypeFilter},
startDateFilter: ${startDateFilter},
endDateFilter: ${endDateFilter},
descendingFilter: ${descendingFilter},
thisMonthOperations: ${thisMonthOperations},
user: ${user},
totalInvestments: ${totalInvestments},
canAddMoreInvestments: ${canAddMoreInvestments},
thisMonthPurchasesTotal: ${thisMonthPurchasesTotal},
thisMonthSalesTotal: ${thisMonthSalesTotal},
thisMonthProfitTotal: ${thisMonthProfitTotal}
    ''';
  }
}
