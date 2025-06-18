import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/screens/settings/widgets/sections/about_section.dart';
import 'package:statiescan/src/screens/settings/widgets/sections/general_section.dart';
import 'package:statiescan/src/screens/settings/widgets/sections/notification_section.dart';
import 'package:statiescan/src/screens/settings/widgets/sections/scanner_section.dart';
import 'package:statiescan/src/widgets/screen_wrapper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settingsTitle)),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              GeneralSection(),
              ScannerSection(),
              NotificationSection(),
              AboutSection(),
            ]),
          ),
        ],
      ),
    );
  }
}
