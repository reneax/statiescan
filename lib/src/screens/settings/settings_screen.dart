import 'package:flutter/material.dart';
import 'package:statiescan/src/widgets/default_screen_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      appBar: AppBar(title: Text("Instellingen")),
      child: Container(),
    );
  }
}
