import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:statiescan/src/utils/shared_prefs.dart';

class ContinueButton extends StatefulWidget {
  final bool shouldShow;

  const ContinueButton({super.key, required this.shouldShow});

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  void _goToMainPage() {
    SharedPrefs.setBool("introShown", true);
    context.go("/receipts");
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child:
          widget.shouldShow
              ? ElevatedButton(
                key: ValueKey('visible'),
                onPressed: _goToMainPage,
                child: Text("Doorgaan"),
              )
              : SizedBox(height: 48),
    );
  }
}
