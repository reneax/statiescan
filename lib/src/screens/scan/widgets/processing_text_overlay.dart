import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';

class ProcessingTextOverlay extends StatelessWidget {
  const ProcessingTextOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.fromBorderSide(
              BorderSide(color: Colors.blue, width: 2),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              AppLocalizations.of(context)!.processingReceipt,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
