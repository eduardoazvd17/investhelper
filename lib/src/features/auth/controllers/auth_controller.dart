import '../../../core/controllers/app_controller.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/models/user_model.dart';
import '../models/login_user_model.dart';
import '../models/register_user_model.dart';
import '../services/auth_service.dart';
import 'package:mobx/mobx.dart';

part 'auth_controller.g.dart';

class AuthController = AuthControllerBase with _$AuthController;

abstract class AuthControllerBase with Store {
  final AppController _appController;
  final AuthService _service;
  AuthControllerBase({
    required AppController appController,
    required AuthService service,
  })  : _appController = appController,
        _service = service;

  Future<void> makeLogin(LoginUserModel loginModel) async {
    try {
      final UserModel user = await _service.makeLogin(loginModel);
      _appController.login(user);
    } on AppException catch (_) {
      rethrow;
    }
  }

  Future<void> makeRegister(RegisterUserModel registerModel) async {
    try {
      final UserModel user = await _service.makeRegister(registerModel);
      _appController.login(user);
    } on AppException catch (_) {
      rethrow;
    }
  }

  Future<void> sendRecoveryEmail(String email) async {
    try {
      await _service.sendRecoveryEmail(email);
    } on AppException catch (_) {
      rethrow;
    }
  }
}
