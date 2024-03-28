import 'package:credentials_manager/credentials_manager.dart';

class AuthService {
  final CredentialsManager _credentialsManager;
  AuthService({
    required CredentialsManager credentialsManager,
  }) : _credentialsManager = credentialsManager;
}
