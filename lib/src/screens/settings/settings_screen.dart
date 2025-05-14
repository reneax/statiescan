import 'package:flutter/material.dart';
import 'package:statiescan/src/screens/settings/widgets/sections/scanner_section.dart';
import 'package:statiescan/src/screens/settings/widgets/sections/about_section.dart';
import 'package:statiescan/src/widgets/default_screen_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Instellingen"),
            floating: true,
            snap: true,
            forceElevated: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ScannerSection(),
              AboutSection(),
            ]),
          ),
        ],
      ),
    );
  }
}
