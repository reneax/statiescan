import 'package:statiescan/src/repositories/settings/models/setting.dart';
import 'package:statiescan/src/repositories/settings/models/setting_type.dart';
import 'package:statiescan/src/utils/shared_prefs.dart';

class SettingsRepository {
  static T get<T>(Setting<T> setting) {
    dynamic value;

    switch (setting.type) {
      case SettingType.bool:
        value = SharedPrefs.getBool(setting.key);
        break;
      case SettingType.int:
        value = SharedPrefs.getInt(setting.key);
        break;
      case SettingType.double:
        value = SharedPrefs.getDouble(setting.key);
        break;
      case SettingType.string:
        value = SharedPrefs.getString(setting.key);
        break;
    }

    return value ?? setting.defaultValue;
  }

  static Future<void> set<T>(Setting<T> setting, T value) async {
    switch (setting.type) {
      case SettingType.bool:
        await SharedPrefs.setBool(setting.key, value as bool);
        break;
      case SettingType.int:
        await SharedPrefs.setInt(setting.key, value as int);
        break;
      case SettingType.double:
        await SharedPrefs.setDouble(setting.key, value as double);
        break;
      case SettingType.string:
        await SharedPrefs.setString(setting.key, value as String);
        break;
    }
  }
}
