import 'package:statiescan/src/repositories/settings/models/setting_type.dart';
import 'package:statiescan/src/repositories/settings/settings_repository.dart';

class Setting<T> {
  final String key;
  final SettingType type;
  final T defaultValue;

  const Setting({
    required this.key,
    required this.type,
    required this.defaultValue,
  });

  T get() => SettingsRepository.get(this);

  Future<void> set(T value) async => await SettingsRepository.set(this, value);
}
