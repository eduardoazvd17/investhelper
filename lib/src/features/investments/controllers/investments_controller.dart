import 'package:investhelper/src/core/models/user_model.dart';
import 'package:mobx/mobx.dart';

import '../../../core/controllers/app_controller.dart';
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
        _service = service;

  @computed
  UserModel? get user => _appController.user;
}
