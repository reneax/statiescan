import 'package:flutter/material.dart';
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
      title: "Algemeen",
      children: [
        SwitchListTile(
          title: const Text("Trillen bij acties"),
          secondary: const Icon(Icons.vibration),
          value: AppSettings.vibrationEnabled.get(),
          onChanged: _toggleVibration,
        ),
        SwitchListTile(
          title: const Text("Volgende bon na verwijderen"),
          subtitle: const Text(
            "Ga na het verwijderen naar de volgende bon van de supermarkt.",
          ),
          secondary: const Icon(Icons.double_arrow),
          value: AppSettings.goToNextWhenDeleted.get(),
          onChanged: _toggleGoToNext,
        ),
        SwitchListTile(
          title: const Text("Verlopen bonnen verwijderen"),
          subtitle: const Text(
            "Bon automatisch verwijderen als deze verloopt.",
          ),
          secondary: const Icon(Icons.auto_delete),
          value: AppSettings.deleteOnExpiry.get(),
          onChanged: _toggleDeleteOnExpiry,
        ),
      ],
    );
  }
}
