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
      ],
    );
  }
}
