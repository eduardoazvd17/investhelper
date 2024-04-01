import 'package:investhelper/src/core/models/user_model.dart';
import 'package:investhelper/src/features/investments/enums/operation_type.dart';
import 'package:mobx/mobx.dart';

import '../../../core/controllers/app_controller.dart';
import '../models/category_model.dart';
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

  Future<void> loadUserData() async {
    if (user != null) {
      //
    }
  }

  @computed
  UserModel? get user => _appController.user;

  @observable
  List<InvestmentModel> investments = [];

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
  List<CategoryModel> categories = [];

  @observable
  List<GoalModel> goals = [];

  @observable
  List<OperationModel> thisMonthOperations = [];

  @computed
  double get thisMonthPurchasesTotal {
    if (thisMonthOperations.isNotEmpty) {
      return thisMonthOperations.where((e) {
        return e.type == OperationTypeEnum.purchase;
      }).map((e) {
        return (e.quantity * e.unitPrice);
      }).reduce((a, b) => a + b);
    }
    return 0.0;
  }

  @computed
  double get thisMonthSalesTotal {
    if (thisMonthOperations.isNotEmpty) {
      return thisMonthOperations.where((e) {
        return e.type == OperationTypeEnum.sale;
      }).map((e) {
        return (e.quantity * e.unitPrice);
      }).reduce((a, b) => a + b);
    }
    return 0.0;
  }

  @observable
  List<OperationModel> operations = [];
}
