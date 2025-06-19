import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/providers/preferences_provider.dart';
import 'package:statiescan/src/screens/settings/widgets/change_language_dialog.dart';
import 'package:statiescan/src/screens/settings/widgets/change_theme_dialog.dart';
import 'package:statiescan/src/screens/settings/widgets/settings_section.dart';

class PreferencesSection extends StatefulWidget {
  const PreferencesSection({super.key});

  @override
  State<PreferencesSection> createState() => _PreferencesSectionState();
}

class _PreferencesSectionState extends State<PreferencesSection> {
  Future<void> _showLanguageDialog() async {
    final preferencesProvider = context.read<PreferencesProvider>();
    final String selectedLocale = await showDialog(
      context: context,
      builder:
          (context) => ChangeLanguageDialog(
            selectedLanguage: preferencesProvider.locale,
          ),
    );

    preferencesProvider.setLocale(selectedLocale);
  }

  Future<void> _showThemeDialog() async {
    final preferencesProvider = context.read<PreferencesProvider>();
    final String? selectedTheme = await showDialog(
      context: context,
      builder:
          (context) => ChangeThemeDialog(
            selectedTheme: preferencesProvider.theme ?? "system",
          ),
    );

    if (selectedTheme != null) {
      preferencesProvider.setTheme(selectedTheme);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: AppLocalizations.of(context)!.preferencesSection,
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.languageOption),
          leading: Icon(Icons.language),
          onTap: () => _showLanguageDialog(),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.themeOption),
          leading: Icon(Icons.dark_mode),
          onTap: () => _showThemeDialog(),
        ),
      ],
    );
  }
}
