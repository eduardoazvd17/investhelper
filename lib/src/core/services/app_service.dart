import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppService {
  static Future<bool> didShowWelcomePage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('DidShowWelcomePage') ?? true;
  }

  static Future<void> neverShowWelcomePage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('DidShowWelcomePage', false);
  }

  static Future<String> getAppID() async {
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
}
