import 'package:flutter/material.dart';
import 'package:statiescan/src/database/app_database.dart';

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
      title: const Text("Nieuwe winkel toevoegen"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(labelText: "Winkelnaam"),
          autofocus: true,
          onFieldSubmitted: (_) => _onSave(),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Voer een winkelnaam in';
            }

            if (value.length >= 15) {
              return 'Deze naam is te lang.';
            }

            if (widget.existingStores
                .map((store) => store.name)
                .contains(value)) {
              return 'Deze winkel bestaat al.';
            }

            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Annuleren"),
        ),
        FilledButton(onPressed: _onSave, child: const Text("Opslaan")),
      ],
    );
  }
}
