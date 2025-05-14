import 'package:flutter/material.dart';
import 'package:statiescan/src/screens/settings/widgets/settings_section.dart';

class ScannerSection extends StatelessWidget {
  const ScannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: "Scanner",
      children: [
        const ListTile(
          title: Text("Work in progress"),
          leading: Icon(Icons.question_mark),
        ),
      ],
    );
  }
}
