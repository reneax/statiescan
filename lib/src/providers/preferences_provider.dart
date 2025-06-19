import 'package:flutter/material.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';

class PreferencesProvider with ChangeNotifier {
  String? _locale;

  String? get locale => _locale;

  Locale? get localeObject {
    final currentLocale = _locale;

    if (currentLocale == null || currentLocale == "system") {
      return null;
    }

    return Locale(currentLocale);
  }

  String? _theme;

  String? get theme => _theme;

  PreferencesProvider() {
    final language = AppSettings.selectedLanguage.get();
    final theme = AppSettings.selectedTheme.get();

    _locale = language;
    _theme = theme;
  }

  void setLocale(String locale) {
    AppSettings.selectedLanguage.set(locale);
    _locale = locale;
    notifyListeners();
  }

  void setTheme(String theme) {
    AppSettings.selectedLanguage.set(theme);
    _theme = theme;
    notifyListeners();
  }
}
