import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _sharedPrefs;

  static Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  static bool? getBool(String key) => _sharedPrefs.getBool(key);

  static Future<bool> setBool(String key, bool value) =>
      _sharedPrefs.setBool(key, value);

  static String? getString(String key) => _sharedPrefs.getString(key);

  static Future<bool> setString(String key, String value) =>
      _sharedPrefs.setString(key, value);

  static Future<bool> remove(String key) => _sharedPrefs.remove(key);

  static Future<bool> clear() => _sharedPrefs.clear();
}
