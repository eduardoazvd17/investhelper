import 'package:investhelper/src/core/models/user_model.dart';
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

  @observable
  List<CategoryModel> categories = [];

  @observable
  List<GoalModel> goals = [];

  @observable
  List<OperationModel> thisMonthOperations = [];

  @observable
  List<OperationModel> operations = [];
}
