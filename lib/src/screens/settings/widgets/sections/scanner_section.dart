import 'package:flutter/material.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/settings/widgets/settings_section.dart';
import 'package:vibration/vibration.dart';

class ScannerSection extends StatefulWidget {
  const ScannerSection({super.key});

  @override
  State<ScannerSection> createState() => _ScannerSectionState();
}

class _ScannerSectionState extends State<ScannerSection> {
  @override
  void initState() {
    super.initState();
  }

  void _toggleVibration(bool enabled) {
    setState(() {
      AppSettings.vibrationEnabled.set(enabled);
    });

    if (enabled) {
      Vibration.vibrate(duration: 100);
    }
  }

  void _toggleAutomaticAmountDetection(bool enabled) {
    setState(() {
      AppSettings.automaticAmountDetection.set(enabled);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: "Scanner",
      children: [
        SwitchListTile(
          title: const Text("Trillen bij scannen"),
          secondary: const Icon(Icons.vibration),
          value: AppSettings.vibrationEnabled.get(),
          onChanged: _toggleVibration,
        ),
        SwitchListTile(
          title: const Text("Automatisch bedrag invullen"),
          subtitle: const Text(
            "Vult automatisch het bonbedrag in. (Vereist meer rekenkracht)",
          ),
          secondary: const Icon(Icons.price_check),
          value: AppSettings.automaticAmountDetection.get(),
          onChanged: _toggleAutomaticAmountDetection,
        ),
      ],
    );
  }
}
