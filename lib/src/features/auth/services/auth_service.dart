import 'package:firebase_auth/firebase_auth.dart';
import 'package:investhelper/src/core/models/user_model.dart';
import 'package:investhelper/src/core/exceptions/app_exception.dart';
import 'package:investhelper/src/features/auth/models/login_user_model.dart';
import 'package:investhelper/src/features/auth/models/register_user_model.dart';

class AuthService {
  FirebaseAuth get _auth => FirebaseAuth.instance;

  Future<UserModel> makeLogin(LoginUserModel loginModel) async {
    try {
      if (loginModel.isEmpty) {
        throw AppException(AppExceptionType.emptyFields);
      }

      if (!loginModel.email.contains('@')) {
        throw AppException(AppExceptionType.invalidEmail);
      }

      await _auth.signInWithEmailAndPassword(
        email: loginModel.email,
        password: loginModel.password,
      );

      return UserModel(
        id: _auth.currentUser!.uid,
        name: _auth.currentUser!.displayName!,
        email: _auth.currentUser!.email!,
      );
    } on AppException catch (_) {
      rethrow;
    } on FirebaseAuthException catch (_) {
      throw AppException(AppExceptionType.incorrectUserOrPassword);
    } catch (_) {
      throw AppException();
    }
  }

  Future<UserModel> makeRegister(RegisterUserModel registerModel) async {
    try {
      if (registerModel.isEmpty) {
        throw AppException(AppExceptionType.emptyFields);
      }

      if (!registerModel.email.contains('@')) {
        throw AppException(AppExceptionType.invalidEmail);
      }

      if (registerModel.password.length < 8) {
        throw AppException(AppExceptionType.invalidPassword);
      }

      if (registerModel.password != registerModel.passwordConfirmation) {
        throw AppException(AppExceptionType.passwordsDontMatch);
      }

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: registerModel.email,
        password: registerModel.password,
      );
      await userCredential.user!.updateDisplayName(registerModel.name);

      return UserModel(
        id: _auth.currentUser!.uid,
        name: _auth.currentUser!.displayName!,
        email: _auth.currentUser!.email!,
      );
    } on AppException catch (_) {
      rethrow;
    } on FirebaseAuthException catch (_) {
      switch (_.code) {
        case 'email-already-in-use':
          throw AppException(AppExceptionType.userAlreadyExists);
        case 'invalid-email':
          throw AppException(AppExceptionType.invalidEmail);
        case 'weak-password':
          throw AppException(AppExceptionType.invalidPassword);
        default:
          throw AppException();
      }
    } catch (_) {
      throw AppException();
    }
  }

  Future<void> sendRecoveryEmail(String email) async {
    try {
      if (email.isEmpty) {
        throw AppException(AppExceptionType.emptyFields);
      }

      if (!email.contains('@')) {
        throw AppException(AppExceptionType.invalidEmail);
      }

      await _auth.sendPasswordResetEmail(email: email);
    } on AppException catch (_) {
      rethrow;
    } on FirebaseAuthException catch (_) {
      throw AppException(AppExceptionType.invalidRecoveryEmail);
    } catch (_) {
      throw AppException();
    }
  }
}
