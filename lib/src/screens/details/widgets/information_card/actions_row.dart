import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';

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
          label: Text(AppLocalizations.of(context)!.share),
        ),
      ],
    );
  }
}
