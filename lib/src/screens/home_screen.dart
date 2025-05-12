import 'package:flutter/material.dart';
import 'package:statiescan/src/widgets/app_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Statiescan")),
      bottomNavigationBar: AppNavigationBar(),
      body: Placeholder(),
    );
  }
}
