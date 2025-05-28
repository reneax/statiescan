import 'package:flutter/material.dart';

class NoReceiptsHint extends StatelessWidget {
  const NoReceiptsHint({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Geen bonnen gevonden", style: theme.textTheme.titleMedium),
          Text(
            "Voeg een nieuwe bon toe met het plusicoon onderaan.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
