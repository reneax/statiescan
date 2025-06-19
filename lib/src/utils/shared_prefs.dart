import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _sharedPrefs;

  static Future<void> initialize() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  static bool? getBool(String key) => _sharedPrefs.getBool(key);

  static Future<bool> setBool(String key, bool value) =>
      _sharedPrefs.setBool(key, value);

  static int? getInt(String key) => _sharedPrefs.getInt(key);

  static Future<bool> setInt(String key, int value) =>
      _sharedPrefs.setInt(key, value);

  static double? getDouble(String key) => _sharedPrefs.getDouble(key);

  static Future<bool> setDouble(String key, double value) =>
      _sharedPrefs.setDouble(key, value);

  static String? getString(String key) => _sharedPrefs.getString(key);

  static Future<bool> setString(String key, String value) =>
      _sharedPrefs.setString(key, value);

  static Future<bool> remove(String key) => _sharedPrefs.remove(key);

  static Future<bool> clear() => _sharedPrefs.clear();
}
