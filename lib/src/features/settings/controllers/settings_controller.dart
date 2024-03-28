import 'package:investhelper/src/features/settings/enums/language_enum.dart';
import 'package:investhelper/src/features/settings/services/settings_service.dart';
import 'package:mobx/mobx.dart';

import '../enums/theme_enum.dart';
part 'settings_controller.g.dart';

class SettingsController = SettingsControllerBase with _$SettingsController;

abstract class SettingsControllerBase with Store {
  final SettingsService _service;
  SettingsControllerBase({
    required SettingsService service,
  }) : _service = service {
    isBiometricsEnabled = false;
    theme = ThemeEnum.system;
    language = LanguageEnum.system;
  }

  @action
  Future<void> loadSettings() async {
    isBiometricsEnabled = await _service.loadIsBiometricsEnabled();
    theme = await _service.loadTheme();
    language = await _service.loadLanguage();
  }

  @observable
  late bool isBiometricsEnabled;

  void changeIsBiometricsEnabled(bool value) async {
    isBiometricsEnabled = value;
    _service.saveIsBiometricsEnabled(value);
  }

  @observable
  late ThemeEnum theme;

  @action
  void changeTheme(ThemeEnum? theme) {
    if (theme != null && theme != this.theme) {
      this.theme = theme;
      _service.saveTheme(theme);
    }
  }

  @observable
  late LanguageEnum language;

  @action
  void changeLanguage(LanguageEnum? language) {
    if (language != null && language != this.language) {
      this.language = language;
      _service.saveLanguage(language);
    }
  }
}
