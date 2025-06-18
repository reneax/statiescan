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

  static const Setting<bool> notificationsEnabled = Setting<bool>(
    key: 'notificationsEnabled',
    type: SettingType.bool,
    defaultValue: true,
  );

  static final notificationDaysBeforeExpiry = Setting<int>(
    key: 'notificationDaysBeforeExpiry',
    type: SettingType.int,
    defaultValue: 3,
  );

  static const Setting<bool> goToNextWhenDeleted = Setting<bool>(
    key: 'goToNextWhenDeleted',
    type: SettingType.bool,
    defaultValue: false,
  );

  static const Setting<bool> deleteOnExpiry = Setting<bool>(
    key: 'deleteOnExpiry',
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
