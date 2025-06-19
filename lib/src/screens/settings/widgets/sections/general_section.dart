import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/settings/widgets/settings_section.dart';
import 'package:vibration/vibration.dart';

class GeneralSection extends StatefulWidget {
  const GeneralSection({super.key});

  @override
  State<GeneralSection> createState() => _GeneralSectionState();
}

class _GeneralSectionState extends State<GeneralSection> {
  void _toggleVibration(bool enabled) {
    setState(() {
      AppSettings.vibrationEnabled.set(enabled);
    });

    if (enabled) {
      Vibration.vibrate(duration: 100);
    }
  }

  void _toggleGoToNext(bool enabled) {
    setState(() {
      AppSettings.goToNextWhenDeleted.set(enabled);
    });
  }

  void _toggleDeleteOnExpiry(bool disabled) {
    setState(() {
      AppSettings.deleteOnExpiry.set(disabled);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: AppLocalizations.of(context)!.generalSection,
      children: [
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.vibrationOption),
          secondary: const Icon(Icons.vibration),
          value: AppSettings.vibrationEnabled.get(),
          onChanged: _toggleVibration,
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.nextAfterDeleteOption),
          subtitle: Text(
            AppLocalizations.of(context)!.nextAfterDeleteDescription,
          ),
          secondary: const Icon(Icons.double_arrow),
          value: AppSettings.goToNextWhenDeleted.get(),
          onChanged: _toggleGoToNext,
        ),
        SwitchListTile(
          title: Text(
            AppLocalizations.of(context)!.deleteExpiredReceiptsOption,
          ),
          subtitle: Text(
            AppLocalizations.of(context)!.deleteExpiredReceiptsDescription,
          ),
          secondary: const Icon(Icons.auto_delete),
          value: AppSettings.deleteOnExpiry.get(),
          onChanged: _toggleDeleteOnExpiry,
        ),
      ],
    );
  }
}
