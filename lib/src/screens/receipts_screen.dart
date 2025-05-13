import 'package:flutter/material.dart';
import 'package:statiescan/src/widgets/default_screen_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      appBar: AppBar(title: Text("Bonnen")),
      child: Container(),
    );
  }
}
