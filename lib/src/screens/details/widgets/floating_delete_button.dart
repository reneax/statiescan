import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/utils/snackbar_creator.dart';

class FloatingDeleteButton extends StatelessWidget {
  final VoidCallback onDeletePress;

  const FloatingDeleteButton({super.key, required this.onDeletePress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onDeletePress,
      child: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        onPressed:
            () => SnackbarCreator.show(
              context,
              status: SnackbarStatus.info,
              message: AppLocalizations.of(context)!.deleteHintSuggestion,
            ),
        child: const Icon(Icons.delete),
      ),
    );
  }
}
