import 'package:flutter/material.dart';

class ActionsRow extends StatelessWidget {
  final VoidCallback onShareButtonPress;

  const ActionsRow({super.key, required this.onShareButtonPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilledButton.icon(
          onPressed: onShareButtonPress,
          icon: const Icon(Icons.share),
          label: const Text("Delen"),
        ),
      ],
    );
  }
}
