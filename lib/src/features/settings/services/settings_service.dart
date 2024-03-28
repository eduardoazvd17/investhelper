import 'package:shared_preferences/shared_preferences.dart';

import '../enums/language_enum.dart';
import '../enums/theme_enum.dart';

class SettingsService {
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
}
