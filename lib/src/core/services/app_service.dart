import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppService {
  static Future<bool> didShowWelcomePage() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstRun = prefs.getString('AppID') == null;
    if (isFirstRun) {
      prefs.setString('AppID', const Uuid().v1());
    }
    return isFirstRun;
  }
}
