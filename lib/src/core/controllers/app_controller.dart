import 'package:get_it/get_it.dart';
import 'package:investhelper/src/core/enums/language_enum.dart';
import 'package:mobx/mobx.dart';

import '../enums/theme_enum.dart';
import '../models/user_model.dart';
import '../services/app_service.dart';
part 'app_controller.g.dart';

class AppController = AppControllerBase with _$AppController;

extension AppControllerExtension on AppController {
  static get instance => GetIt.I.get<AppController>();
  static get I => instance;
}

abstract class AppControllerBase with Store {
  final AppService _service;
  AppControllerBase({
    required AppService service,
  }) : _service = service {
    showWelcomePage = true;
    isBiometricsEnabled = false;
    theme = ThemeEnum.system;
    language = LanguageEnum.system;
  }

  @action
  Future<void> initialize() async {
    showWelcomePage = await _service.loadShowWelcomePage();
    isBiometricsEnabled = await _service.loadIsBiometricsEnabled();
    theme = await _service.loadTheme();
    language = await _service.loadLanguage();
    user = await _service.getCurrentUser();
  }

  @observable
  late bool showWelcomePage;

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
    user = null;
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
