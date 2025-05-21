import 'package:statiescan/src/repositories/settings/models/setting.dart';
import 'package:statiescan/src/repositories/settings/models/setting_type.dart';

class AppSettings {
  static const Setting<bool> isIntroShown = Setting<bool>(
    key: 'isIntroShown',
    type: SettingType.bool,
    defaultValue: false,
  );

  static const Setting<bool> vibrationEnabled = Setting<bool>(
    key: 'vibrationEnabled',
    type: SettingType.bool,
    defaultValue: true,
  );

  static const Setting<bool> automaticAmountDetection = Setting<bool>(
    key: 'automaticAmountDetection',
    type: SettingType.bool,
    defaultValue: false,
  );

  static const Setting<int?> lastChosenStoreId = Setting<int?>(
    key: 'lastChosenStoreId',
    type: SettingType.int,
    defaultValue: null,
  );
}
