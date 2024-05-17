// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppController on AppControllerBase, Store {
  late final _$appVersionAtom =
      Atom(name: 'AppControllerBase.appVersion', context: context);

  @override
  String get appVersion {
    _$appVersionAtom.reportRead();
    return super.appVersion;
  }

  bool _appVersionIsInitialized = false;

  @override
  set appVersion(String value) {
    _$appVersionAtom.reportWrite(
        value, _appVersionIsInitialized ? super.appVersion : null, () {
      super.appVersion = value;
      _appVersionIsInitialized = true;
    });
  }

  late final _$showWelcomePageAtom =
      Atom(name: 'AppControllerBase.showWelcomePage', context: context);

  @override
  bool get showWelcomePage {
    _$showWelcomePageAtom.reportRead();
    return super.showWelcomePage;
  }

  @override
  set showWelcomePage(bool value) {
    _$showWelcomePageAtom.reportWrite(value, super.showWelcomePage, () {
      super.showWelcomePage = value;
    });
  }

  late final _$userAtom =
      Atom(name: 'AppControllerBase.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$canEnableBiometricsAtom =
      Atom(name: 'AppControllerBase.canEnableBiometrics', context: context);

  @override
  bool get canEnableBiometrics {
    _$canEnableBiometricsAtom.reportRead();
    return super.canEnableBiometrics;
  }

  @override
  set canEnableBiometrics(bool value) {
    _$canEnableBiometricsAtom.reportWrite(value, super.canEnableBiometrics, () {
      super.canEnableBiometrics = value;
    });
  }

  late final _$isBiometricsEnabledAtom =
      Atom(name: 'AppControllerBase.isBiometricsEnabled', context: context);

  @override
  bool get isBiometricsEnabled {
    _$isBiometricsEnabledAtom.reportRead();
    return super.isBiometricsEnabled;
  }

  @override
  set isBiometricsEnabled(bool value) {
    _$isBiometricsEnabledAtom.reportWrite(value, super.isBiometricsEnabled, () {
      super.isBiometricsEnabled = value;
    });
  }

  late final _$shouldRequestAuthAtom =
      Atom(name: 'AppControllerBase.shouldRequestAuth', context: context);

  @override
  bool get shouldRequestAuth {
    _$shouldRequestAuthAtom.reportRead();
    return super.shouldRequestAuth;
  }

  @override
  set shouldRequestAuth(bool value) {
    _$shouldRequestAuthAtom.reportWrite(value, super.shouldRequestAuth, () {
      super.shouldRequestAuth = value;
    });
  }

  late final _$isRequestAuthOverlayShowingAtom = Atom(
      name: 'AppControllerBase.isRequestAuthOverlayShowing', context: context);

  @override
  bool get isRequestAuthOverlayShowing {
    _$isRequestAuthOverlayShowingAtom.reportRead();
    return super.isRequestAuthOverlayShowing;
  }

  @override
  set isRequestAuthOverlayShowing(bool value) {
    _$isRequestAuthOverlayShowingAtom
        .reportWrite(value, super.isRequestAuthOverlayShowing, () {
      super.isRequestAuthOverlayShowing = value;
    });
  }

  late final _$disableAuthOverlayAtom =
      Atom(name: 'AppControllerBase.disableAuthOverlay', context: context);

  @override
  bool get disableAuthOverlay {
    _$disableAuthOverlayAtom.reportRead();
    return super.disableAuthOverlay;
  }

  @override
  set disableAuthOverlay(bool value) {
    _$disableAuthOverlayAtom.reportWrite(value, super.disableAuthOverlay, () {
      super.disableAuthOverlay = value;
    });
  }

  late final _$disableBlurOverlayAtom =
      Atom(name: 'AppControllerBase.disableBlurOverlay', context: context);

  @override
  bool get disableBlurOverlay {
    _$disableBlurOverlayAtom.reportRead();
    return super.disableBlurOverlay;
  }

  @override
  set disableBlurOverlay(bool value) {
    _$disableBlurOverlayAtom.reportWrite(value, super.disableBlurOverlay, () {
      super.disableBlurOverlay = value;
    });
  }

  late final _$isBlurOverlayShowingAtom =
      Atom(name: 'AppControllerBase.isBlurOverlayShowing', context: context);

  @override
  bool get isBlurOverlayShowing {
    _$isBlurOverlayShowingAtom.reportRead();
    return super.isBlurOverlayShowing;
  }

  @override
  set isBlurOverlayShowing(bool value) {
    _$isBlurOverlayShowingAtom.reportWrite(value, super.isBlurOverlayShowing,
        () {
      super.isBlurOverlayShowing = value;
    });
  }

  late final _$themeAtom =
      Atom(name: 'AppControllerBase.theme', context: context);

  @override
  ThemeEnum get theme {
    _$themeAtom.reportRead();
    return super.theme;
  }

  @override
  set theme(ThemeEnum value) {
    _$themeAtom.reportWrite(value, super.theme, () {
      super.theme = value;
    });
  }

  late final _$languageAtom =
      Atom(name: 'AppControllerBase.language', context: context);

  @override
  LanguageEnum get language {
    _$languageAtom.reportRead();
    return super.language;
  }

  @override
  set language(LanguageEnum value) {
    _$languageAtom.reportWrite(value, super.language, () {
      super.language = value;
    });
  }

  late final _$initializeAsyncAction =
      AsyncAction('AppControllerBase.initialize', context: context);

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  late final _$biometricsSecurityCheckAsyncAction = AsyncAction(
      'AppControllerBase.biometricsSecurityCheck',
      context: context);

  @override
  Future<void> biometricsSecurityCheck() {
    return _$biometricsSecurityCheckAsyncAction
        .run(() => super.biometricsSecurityCheck());
  }

  late final _$changeUserNameAsyncAction =
      AsyncAction('AppControllerBase.changeUserName', context: context);

  @override
  Future<void> changeUserName(String name) {
    return _$changeUserNameAsyncAction.run(() => super.changeUserName(name));
  }

  late final _$changeUserPasswordAsyncAction =
      AsyncAction('AppControllerBase.changeUserPassword', context: context);

  @override
  Future<void> changeUserPassword(String currentPassword, String newPassword,
      String newPasswordConfirmation) {
    return _$changeUserPasswordAsyncAction.run(() => super.changeUserPassword(
        currentPassword, newPassword, newPasswordConfirmation));
  }

  late final _$changeUserDataAsyncAction =
      AsyncAction('AppControllerBase.changeUserData', context: context);

  @override
  Future<void> changeUserData(UserDataModel userDataModel) {
    return _$changeUserDataAsyncAction
        .run(() => super.changeUserData(userDataModel));
  }

  late final _$logoutAsyncAction =
      AsyncAction('AppControllerBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$deleteMyAccountAsyncAction =
      AsyncAction('AppControllerBase.deleteMyAccount', context: context);

  @override
  Future<void> deleteMyAccount(String currentPassword) {
    return _$deleteMyAccountAsyncAction
        .run(() => super.deleteMyAccount(currentPassword));
  }

  late final _$changeIsBiometricsEnabledAsyncAction = AsyncAction(
      'AppControllerBase.changeIsBiometricsEnabled',
      context: context);

  @override
  Future<void> changeIsBiometricsEnabled(bool value, {bool force = false}) {
    return _$changeIsBiometricsEnabledAsyncAction
        .run(() => super.changeIsBiometricsEnabled(value, force: force));
  }

  late final _$AppControllerBaseActionController =
      ActionController(name: 'AppControllerBase', context: context);

  @override
  void disableWelcomePage() {
    final _$actionInfo = _$AppControllerBaseActionController.startAction(
        name: 'AppControllerBase.disableWelcomePage');
    try {
      return super.disableWelcomePage();
    } finally {
      _$AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void login(UserModel user) {
    final _$actionInfo = _$AppControllerBaseActionController.startAction(
        name: 'AppControllerBase.login');
    try {
      return super.login(user);
    } finally {
      _$AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTheme(ThemeEnum? theme) {
    final _$actionInfo = _$AppControllerBaseActionController.startAction(
        name: 'AppControllerBase.changeTheme');
    try {
      return super.changeTheme(theme);
    } finally {
      _$AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLanguage(LanguageEnum? language) {
    final _$actionInfo = _$AppControllerBaseActionController.startAction(
        name: 'AppControllerBase.changeLanguage');
    try {
      return super.changeLanguage(language);
    } finally {
      _$AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
appVersion: ${appVersion},
showWelcomePage: ${showWelcomePage},
user: ${user},
canEnableBiometrics: ${canEnableBiometrics},
isBiometricsEnabled: ${isBiometricsEnabled},
shouldRequestAuth: ${shouldRequestAuth},
isRequestAuthOverlayShowing: ${isRequestAuthOverlayShowing},
disableAuthOverlay: ${disableAuthOverlay},
disableBlurOverlay: ${disableBlurOverlay},
isBlurOverlayShowing: ${isBlurOverlayShowing},
theme: ${theme},
language: ${language}
    ''';
  }
}
