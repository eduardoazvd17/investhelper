import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppService {
  static Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstRun = prefs.getString('AppID') == null;
    if (isFirstRun) {
      prefs.setString('AppID', const Uuid().v1());
    }
    return isFirstRun;
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
