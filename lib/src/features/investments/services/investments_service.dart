import 'package:shared_preferences/shared_preferences.dart';

class InvestmentsService {
  Future<void> saveHideValues(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('AppHideValues', value);
  }

  Future<bool> loadHideValues() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('AppHideValues') ?? true;
  }
}
