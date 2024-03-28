// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsController on SettingsControllerBase, Store {
  late final _$isBiometricsEnabledAtom = Atom(
      name: 'SettingsControllerBase.isBiometricsEnabled', context: context);

  @override
  bool get isBiometricsEnabled {
    _$isBiometricsEnabledAtom.reportRead();
    return super.isBiometricsEnabled;
  }

  bool _isBiometricsEnabledIsInitialized = false;

  @override
  set isBiometricsEnabled(bool value) {
    _$isBiometricsEnabledAtom.reportWrite(value,
        _isBiometricsEnabledIsInitialized ? super.isBiometricsEnabled : null,
        () {
      super.isBiometricsEnabled = value;
      _isBiometricsEnabledIsInitialized = true;
    });
  }

  late final _$themeAtom =
      Atom(name: 'SettingsControllerBase.theme', context: context);

  @override
  ThemeEnum get theme {
    _$themeAtom.reportRead();
    return super.theme;
  }

  bool _themeIsInitialized = false;

  @override
  set theme(ThemeEnum value) {
    _$themeAtom.reportWrite(value, _themeIsInitialized ? super.theme : null,
        () {
      super.theme = value;
      _themeIsInitialized = true;
    });
  }

  late final _$languageAtom =
      Atom(name: 'SettingsControllerBase.language', context: context);

  @override
  LanguageEnum get language {
    _$languageAtom.reportRead();
    return super.language;
  }

  bool _languageIsInitialized = false;

  @override
  set language(LanguageEnum value) {
    _$languageAtom
        .reportWrite(value, _languageIsInitialized ? super.language : null, () {
      super.language = value;
      _languageIsInitialized = true;
    });
  }

  late final _$loadSettingsAsyncAction =
      AsyncAction('SettingsControllerBase.loadSettings', context: context);

  @override
  Future<void> loadSettings() {
    return _$loadSettingsAsyncAction.run(() => super.loadSettings());
  }

  late final _$SettingsControllerBaseActionController =
      ActionController(name: 'SettingsControllerBase', context: context);

  @override
  void changeTheme(ThemeEnum? theme) {
    final _$actionInfo = _$SettingsControllerBaseActionController.startAction(
        name: 'SettingsControllerBase.changeTheme');
    try {
      return super.changeTheme(theme);
    } finally {
      _$SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLanguage(LanguageEnum? language) {
    final _$actionInfo = _$SettingsControllerBaseActionController.startAction(
        name: 'SettingsControllerBase.changeLanguage');
    try {
      return super.changeLanguage(language);
    } finally {
      _$SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isBiometricsEnabled: ${isBiometricsEnabled},
theme: ${theme},
language: ${language}
    ''';
  }
}
