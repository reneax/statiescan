import 'package:flutter/material.dart';
import 'package:statiescan/src/widgets/app_navigation_bar.dart';
import 'package:statiescan/src/widgets/floating_add_button.dart';

class DefaultScreenScaffold extends StatelessWidget {
  final bool showAddButton;
  final bool showNavigation;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final AppBar? appBar;
  final Widget child;

  const DefaultScreenScaffold({
    super.key,
    this.showAddButton = true,
    this.showNavigation = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.appBar,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton:
          showNavigation && showAddButton
              ? const FloatingAddButton()
              : floatingActionButton,
      floatingActionButtonLocation:
          showNavigation
              ? FloatingActionButtonLocation.centerDocked
              : floatingActionButtonLocation,
      bottomNavigationBar: showNavigation ? const AppNavigationBar() : null,
      body: child,
    );
  }
}
