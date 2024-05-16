import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../features/auth/services/auth_service.dart';
import '../enums/language_enum.dart';
import '../enums/theme_enum.dart';
import '../exceptions/app_exception.dart';
import '../models/user_model.dart';

class AppService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;
  FlutterSecureStorage get _secureStorage => const FlutterSecureStorage();

  Future<String> getAppID() async {
    final prefs = await SharedPreferences.getInstance();
    final String? appID = prefs.getString('AppID');
    if (appID == null) {
      final String newAppID = const Uuid().v1();
      prefs.setString('AppID', newAppID);
      return newAppID;
    } else {
      return appID;
    }
  }

  Future<String> getAppVersion() async {
    return (await PackageInfo.fromPlatform()).version;
  }

  Future<bool> loadShowWelcomePage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('AppShowWelcomePage') ?? true;
  }

  Future<void> disableWelcomePage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('AppShowWelcomePage', false);
  }

  Future<void> saveIsBiometricsEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('AppBiometrics', value);
  }

  Future<bool> loadIsBiometricsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('AppBiometrics') ?? false;
  }

  Future<void> saveLanguage(LanguageEnum language) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('AppLanguage', language.index);
  }

  Future<LanguageEnum> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final int? index = prefs.getInt('AppLanguage');
    if (index == null) return LanguageEnum.system;
    return LanguageEnum.values[index];
  }

  Future<void> saveTheme(ThemeEnum theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('AppTheme', theme.index);
  }

  Future<ThemeEnum> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final int? index = prefs.getInt('AppTheme');
    if (index == null) return ThemeEnum.system;
    return ThemeEnum.values[index];
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      if (_auth.currentUser != null) {
        return UserModel(
          id: _auth.currentUser!.uid,
          name: _auth.currentUser!.displayName!,
          email: _auth.currentUser!.email!,
          data: await AuthService().getUserData(_auth.currentUser!.uid),
        );
      }
    } catch (_) {}
    return null;
  }

  Future<void> logout() async {
    try {
      final String userId = _auth.currentUser!.uid;
      await _auth.signOut();
      await _secureStorage.delete(key: userId);
    } catch (_) {}
  }

  Future<void> deleteMyAccount() async {
    try {
      final String id = _auth.currentUser!.uid;
      final String email = _auth.currentUser!.email!;
      final String password =
          (await _secureStorage.read(key: _auth.currentUser!.uid))!;
      await _auth.currentUser?.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: email,
          password: password,
        ),
      );

      final WriteBatch batch = _firestore.batch();
      final goals = await _firestore
          .collection('goals')
          .where('userId', isEqualTo: id)
          .get();
      for (final goal in goals.docs) {
        batch.delete(goal.reference);
      }

      final investments = await _firestore
          .collection('investments')
          .where('userId', isEqualTo: id)
          .get();
      for (final investment in investments.docs) {
        batch.delete(investment.reference);
      }

      final operations = await _firestore
          .collection('operations')
          .where('userId', isEqualTo: id)
          .get();
      for (final operation in operations.docs) {
        batch.delete(operation.reference);
      }

      batch.delete(_firestore.collection('users').doc(id));
      await batch.commit();
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<UserModel> changeUserName(UserModel userModel) async {
    try {
      if (userModel.name.isEmpty) {
        throw AppException(AppExceptionType.emptyFields);
      }

      await _auth.currentUser!.updateDisplayName(userModel.name);
      return userModel;
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<void> changeUserPassword(
    String currentPassword,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    try {
      final String password =
          (await _secureStorage.read(key: _auth.currentUser!.uid))!;

      if (currentPassword != password) {
        throw AppException(AppExceptionType.incorrectPassword);
      }

      if (newPassword.length < 8) {
        throw AppException(AppExceptionType.invalidPassword);
      }

      if (newPassword != newPasswordConfirmation) {
        throw AppException(AppExceptionType.passwordsDontMatch);
      }

      await _auth.currentUser?.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: _auth.currentUser!.email!,
          password: password,
        ),
      );
      await _auth.currentUser!.updatePassword(newPassword);
      await _secureStorage.write(
        key: _auth.currentUser!.uid,
        value: newPassword,
      );
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }

  Future<UserModel> changeUserData(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.data.toMap());

      return userModel;
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(AppExceptionType.connectionError, error.toString());
    }
  }
}
