import 'package:shared_preferences/shared_preferences.dart';

import '../core/helper/prefs_keys.dart';

class SharedPreferencesService {
  const SharedPreferencesService._();

  static Future<void> setToken(String token) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(PrefsKeys.accessToken, token);
  }

  static Future<String?> getToken() async {
    final sp = await SharedPreferences.getInstance();
    String? token = sp.getString(PrefsKeys.accessToken);
    return token;
  }

  static Future<void> deleteToken() async {
    final sp = await SharedPreferences.getInstance();
    setWillSaveToken(false);
    sp.remove(PrefsKeys.accessToken);
  }

  static Future<bool> isAuth() async {
    final sp = await SharedPreferences.getInstance();
    return sp.containsKey(PrefsKeys.accessToken);
  }

  static Future<void> setWillSaveToken(bool value) async {
    final sp = await SharedPreferences.getInstance();
    sp.setBool(PrefsKeys.saveToken, value);
  }

  static Future<bool> getWillSaveToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(PrefsKeys.saveToken) ?? false;
  }

  static Future<bool> isFirstTimeOpeningApp() async {
    final sp = await SharedPreferences.getInstance();
    if (!sp.containsKey(PrefsKeys.showOnBorder)) {
      sp.setBool(PrefsKeys.showOnBorder, true);
      return true;
    } else {
      return sp.getBool(PrefsKeys.showOnBorder)!;
    }
  }

  static void setNotFirstTimeOpeningApp() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(PrefsKeys.showOnBorder, false);
  }
}
