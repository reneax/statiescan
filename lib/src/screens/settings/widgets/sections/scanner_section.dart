import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
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
      title: AppLocalizations.of(context)!.scannerSection,
      children: [
        SwitchListTile(
          title: Text(
            AppLocalizations.of(context)!.automaticAmountDetectionOption,
          ),
          subtitle: Text(
            AppLocalizations.of(context)!.automaticAmountDetectionDescription,
          ),
          secondary: const Icon(Icons.price_check),
          value: AppSettings.automaticAmountDetection.get(),
          onChanged: _toggleAutomaticAmountDetection,
        ),
      ],
    );
  }
}
