import 'package:flutter/material.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/settings/widgets/settings_section.dart';

class ScannerSection extends StatefulWidget {
  const ScannerSection({super.key});

  @override
  State<ScannerSection> createState() => _ScannerSectionState();
}

class _ScannerSectionState extends State<ScannerSection> {
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
          title: const Text("Automatisch bedrag invullen"),
          subtitle: const Text(
            "Vult automatisch het bonbedrag in wanneer mogelijk. Dit vereist meer rekenkracht.",
          ),
          secondary: const Icon(Icons.price_check),
          value: AppSettings.automaticAmountDetection.get(),
          onChanged: _toggleAutomaticAmountDetection,
        ),
      ],
    );
  }
}
