import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService._();

  static init() async {
    _sp = await SharedPreferences.getInstance();
  }

  static SharedPreferences? _sp;

  static SharedPreferences get sp => _sp!;
}
