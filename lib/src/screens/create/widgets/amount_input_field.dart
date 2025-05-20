import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:statiescan/src/utils/amount_formatter.dart';

class AmountInputField extends StatelessWidget {
  final TextEditingController editingController;
  final FocusNode? focusNode;

  const AmountInputField({
    super.key,
    required this.editingController,
    this.focusNode,
  });

  bool _isValidInput(value) {
    return value != null && AmountFormatter.stringToAmount(value) != null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      focusNode: focusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*[,.]?\d{0,2}')),
      ],
      decoration: InputDecoration(
        labelText: "Bedrag",
        prefixIcon: const Icon(Icons.euro),
        border: const OutlineInputBorder(),
      ),
      validator:
          (value) => !_isValidInput(value) ? 'Voer een geldig bedrag in' : null,
    );
  }
}
