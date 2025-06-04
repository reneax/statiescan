import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statiescan/src/providers/ui_state.dart';
import 'package:statiescan/src/widgets/app_navigation_bar.dart';
import 'package:statiescan/src/widgets/floating_add_button.dart';

class DefaultScreenScaffold extends StatelessWidget {
  final Widget child;

  const DefaultScreenScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final uiState = context.watch<UIState>();

    return Scaffold(
      floatingActionButton:
          uiState.floatingActionButton ?? const FloatingAddButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const AppNavigationBar(),
      body: child,
    );
  }
}
