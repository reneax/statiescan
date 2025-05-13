import 'package:flutter/material.dart';
import 'package:statiescan/src/widgets/default_screen_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      appBar: AppBar(title: Text("Bonnen")),
      child: Container(),
    );
  }
}
