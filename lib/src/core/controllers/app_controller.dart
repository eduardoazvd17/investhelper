import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';

import '../../features/investments/controllers/investments_controller.dart';
import '../enums/language_enum.dart';
import '../enums/theme_enum.dart';
import '../exceptions/app_exception.dart';
import '../models/user_model.dart';
import '../services/app_service.dart';

part 'app_controller.g.dart';

class AppController = AppControllerBase with _$AppController;

abstract class AppControllerBase with Store {
  late final LocalAuthentication _localAuth;
  final AppService _service;
  AppControllerBase({required AppService service}) : _service = service;

  @action
  Future<void> initialize() async {
    _localAuth = LocalAuthentication();
    showWelcomePage = await _service.loadShowWelcomePage();
    theme = await _service.loadTheme();
    language = await _service.loadLanguage();
    appVersion = await _service.getAppVersion();
    user = await _service.getCurrentUser();
    await biometricsSecurityCheck();
  }

  @action
  Future<void> biometricsSecurityCheck() async {
    if (kIsWeb) {
      canEnableBiometrics = false;
      isBiometricsEnabled = false;
      shouldRequestAuth = false;
      return;
    }

    canEnableBiometrics = await _localAuth.isDeviceSupported() &&
        await _localAuth.canCheckBiometrics;

    if (user != null &&
        !canEnableBiometrics &&
        await _service.loadIsBiometricsEnabled()) {
      await logout();
    }

    isBiometricsEnabled =
        canEnableBiometrics && await _service.loadIsBiometricsEnabled();
    shouldRequestAuth = isBiometricsEnabled;
  }

  @observable
  late String appVersion;

  @observable
  bool showWelcomePage = true;

  @action
  void disableWelcomePage() {
    showWelcomePage = false;
    _service.disableWelcomePage();
  }

  @observable
  UserModel? user;

  @action
  Future<void> changeUserName(String name) async {
    try {
      user = await _service.changeUserName(
        user!.copyWith(name: name),
      );
    } on AppException catch (_) {
      rethrow;
    }
  }

  @action
  Future<void> changeUserPassword(
    String currentPassword,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    try {
      await _service.changeUserPassword(
        currentPassword,
        newPassword,
        newPasswordConfirmation,
      );
    } on AppException catch (_) {
      rethrow;
    }
  }

  @action
  Future<void> changeUserData(UserDataModel userDataModel) async {
    try {
      user = await _service.changeUserName(
        user!.copyWith(data: userDataModel),
      );
    } on AppException catch (_) {
      rethrow;
    }
  }

  @action
  void login(UserModel user) {
    this.user = user;
    GetIt.I.get<InvestmentsController>().loadUserData();
  }

  @action
  Future<void> logout() async {
    await _service.logout();
    await changeIsBiometricsEnabled(false, force: true);
    user = null;
    GetIt.I.get<InvestmentsController>().loadUserData();
  }

  @action
  Future<void> deleteMyAccount(String currentPassword) async {
    await _service.deleteMyAccount(currentPassword);
    await changeIsBiometricsEnabled(false, force: true);
    user = null;
    GetIt.I.get<InvestmentsController>().loadUserData();
  }

  @observable
  bool canEnableBiometrics = false;

  @observable
  bool isBiometricsEnabled = false;

  @observable
  bool shouldRequestAuth = false;

  @observable
  bool isRequestAuthOverlayShowing = false;

  @observable
  bool disableAuthOverlay = false;

  @observable
  bool disableBlurOverlay = false;

  @observable
  bool isBlurOverlayShowing = false;

  @action
  Future<bool> requestAuth([String? message]) async {
    disableAuthOverlay = true;
    final bool result = await _localAuth.authenticate(
      localizedReason: message ?? 'Please authenticate to continue',
    );
    disableAuthOverlay = false;
    return result;
  }

  @action
  Future<void> changeIsBiometricsEnabled(
    bool value, {
    bool force = false,
  }) async {
    if (canEnableBiometrics) {
      if (!force) {
        final result = await requestAuth();
        if (!result) return;
      }

      isBiometricsEnabled = value;
      _service.saveIsBiometricsEnabled(value);
    }
  }

  @observable
  ThemeEnum theme = ThemeEnum.system;

  @action
  void changeTheme(ThemeEnum? theme) {
    if (theme != null && theme != this.theme) {
      this.theme = theme;
      _service.saveTheme(theme);
    }
  }

  @observable
  LanguageEnum language = LanguageEnum.system;

  @action
  void changeLanguage(LanguageEnum? language) {
    if (language != null && language != this.language) {
      this.language = language;
      _service.saveLanguage(language);
    }
  }
}
