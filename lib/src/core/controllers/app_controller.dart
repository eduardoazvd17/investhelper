import 'package:credentials_manager/credentials_manager.dart';
import 'package:investhelper/src/core/enums/language_enum.dart';
import 'package:mobx/mobx.dart';

import '../enums/theme_enum.dart';
import '../models/user_model.dart';
import '../services/app_service.dart';
part 'app_controller.g.dart';

class AppController = AppControllerBase with _$AppController;

abstract class AppControllerBase with Store {
  late final CredentialsManager _credentialsManager;
  final AppService _service;
  AppControllerBase({required AppService service}) : _service = service;

  @action
  Future<void> initialize() async {
    _credentialsManager = CredentialsManager(
      storageKey: await _service.getAppID(),
    );
    showWelcomePage = await _service.loadShowWelcomePage();
    canEnableBiometrics = await _credentialsManager.canCheckBiometrics();
    isBiometricsEnabled =
        canEnableBiometrics && await _service.loadIsBiometricsEnabled();
    shouldRequestAuth = isBiometricsEnabled;
    isRequestAuthOverlayShowing = false;
    theme = await _service.loadTheme();
    language = await _service.loadLanguage();
    user = await _service.getCurrentUser();
    appVersion = await _service.getAppVersion();
  }

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
  void login(UserModel user) => this.user = user;

  @action
  Future<void> logout() async {
    await _service.logout();
    await changeIsBiometricsEnabled(false, force: true);
    user = null;
  }

  @observable
  bool canEnableBiometrics = false;

  @observable
  bool isBiometricsEnabled = false;

  @observable
  bool shouldRequestAuth = false;

  @observable
  bool isRequestAuthOverlayShowing = false;

  Future<bool> requestAuth() async {
    return await _credentialsManager.requestAuth();
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

  @observable
  late String appVersion;
}
