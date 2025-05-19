import 'package:flutter/material.dart';

class AddStoreDialog extends StatefulWidget {
  const AddStoreDialog({super.key});

  @override
  State<AddStoreDialog> createState() => _AddStoreDialogState();
}

class _AddStoreDialogState extends State<AddStoreDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  void _onSave() {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      setState(() {
        _errorText = 'Winkelnaam mag niet leeg zijn.';
      });
    } else {
      Navigator.of(context).pop(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nieuwe winkel toevoegen"),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: "Winkelnaam",
          errorText: _errorText,
        ),
        autofocus: true,
        onSubmitted: (_) => _onSave(),
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
