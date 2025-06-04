import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statiescan/src/providers/ui_state_provider.dart';

class ScreenWrapper extends StatefulWidget {
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final bool hideNavigation;
  final bool hideActionButton;
  final Widget child;

  const ScreenWrapper({
    this.floatingActionButton,
    this.appBar,
    this.hideNavigation = false,
    this.hideActionButton = false,
    required this.child,
    super.key,
  });

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  void _updateUI() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uiState = context.read<UIStateProvider>();
      uiState.setState(widget.floatingActionButton);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          _updateUI();
        }
      },
      child: Scaffold(appBar: widget.appBar, body: widget.child),
    );
  }
}
