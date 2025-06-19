import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';

class ChangeThemeDialog extends StatelessWidget {
  final String selectedTheme;

  const ChangeThemeDialog({super.key, required this.selectedTheme});

  String localizedThemeName(BuildContext context, ThemeMode themeMode) {
    final localizations = AppLocalizations.of(context)!;
    switch (themeMode) {
      case ThemeMode.light:
        return localizations.lightTheme;
      case ThemeMode.dark:
        return localizations.darkTheme;
      case ThemeMode.system:
        return localizations.systemTheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.themeTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...ThemeMode.values.map((theme) {
            return ListTile(
              title: Text(localizedThemeName(context, theme)),
              selected: theme.name == selectedTheme,
              onTap: () {
                Navigator.of(context).pop(theme.name);
              },
            );
          }),
        ],
      ),
    );
  }
}
