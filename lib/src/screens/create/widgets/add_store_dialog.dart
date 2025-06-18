import 'package:flutter/material.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';

class AddStoreDialog extends StatefulWidget {
  final List<Store> existingStores;

  const AddStoreDialog({super.key, required this.existingStores});

  @override
  State<AddStoreDialog> createState() => _AddStoreDialogState();
}

class _AddStoreDialogState extends State<AddStoreDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onSave() {
    final currentFormState = _formKey.currentState;

    if (currentFormState == null || !currentFormState.validate()) {
      return;
    }

    final name = _controller.text.trim();

    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addNewStore),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.storeName,
          ),
          autofocus: true,
          onFieldSubmitted: (_) => _onSave(),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return AppLocalizations.of(context)!.errorEmptyStore;
            }

            if (value.length >= 15) {
              return AppLocalizations.of(context)!.errorTooLongName;
            }

            if (widget.existingStores
                .map((store) => store.name)
                .contains(value)) {
              return AppLocalizations.of(context)!.errorStoreExists;
            }

            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        FilledButton(
          onPressed: _onSave,
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
