import 'package:flutter/material.dart';

class AddStoreDialog extends StatefulWidget {
  const AddStoreDialog({super.key});

  @override
  State<AddStoreDialog> createState() => _AddStoreDialogState();
}

class _AddStoreDialogState extends State<AddStoreDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final name = _controller.text.trim();
      Navigator.of(context).pop(name);
    }
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
              return 'Winkelnaam mag niet leeg zijn.';
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
