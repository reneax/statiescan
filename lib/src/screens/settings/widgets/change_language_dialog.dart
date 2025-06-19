import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';

class ChangeLanguageDialog extends StatelessWidget {
  final String? selectedLanguage;

  const ChangeLanguageDialog({super.key, required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.languageTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.systemLanguage),
            selected: selectedLanguage == "system",
            onTap: () {
              Navigator.of(context).pop("system");
            },
          ),
          ...AppLocalizations.supportedLocales.map((locale) {
            return ListTile(
              title: Text(
                LocaleNames.of(context)!.nameOf(locale.languageCode) ??
                    locale.languageCode,
              ),
              selected: locale.languageCode == selectedLanguage,
              onTap: () {
                Navigator.of(context).pop(locale.languageCode);
              },
            );
          }),
        ],
      ),
    );
  }
}
