import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../enums/language_enum.dart';
import '../enums/theme_enum.dart';
import '../exceptions/app_exception.dart';
import '../models/user_model.dart';

class AppService {
  FirebaseAuth get _auth => FirebaseAuth.instance;

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
        );
      }
    } catch (_) {}
    return null;
  }

  Future<void> logout() async => await _auth.signOut();

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
}
