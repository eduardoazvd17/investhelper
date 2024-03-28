import 'package:investhelper/src/features/auth/services/auth_service.dart';
import 'package:mobx/mobx.dart';

part 'auth_controller.g.dart';

class AuthController = AuthControllerBase with _$AuthController;

abstract class AuthControllerBase with Store {
  final AuthService _service;
  AuthControllerBase({
    required AuthService service,
  }) : _service = service;
}
