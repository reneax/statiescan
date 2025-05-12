import 'package:flutter/material.dart';
import 'package:statiescan/src/widgets/app_navigation_bar.dart';
import 'package:statiescan/src/widgets/floating_add_button.dart';

class DefaultScreenScaffold extends StatelessWidget {
  final bool showAppBar;
  final bool showAddButton;
  final bool showNavigation;
  final Widget child;

  const DefaultScreenScaffold({
    super.key,
    this.showAppBar = true,
    this.showAddButton = true,
    this.showNavigation = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar(title: const Text("Statiescan")) : null,
      floatingActionButton:
          showNavigation && showAddButton ? const FloatingAddButton() : null,
      floatingActionButtonLocation:
          showNavigation ? FloatingActionButtonLocation.centerDocked : null,
      bottomNavigationBar: showNavigation ? const AppNavigationBar() : null,
      body: child,
    );
  }
}
