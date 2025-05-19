import 'package:flutter/material.dart';
import 'package:statiescan/src/screens/create/enums/expiry_time.dart';

class ExpiryTimeDropdown extends StatelessWidget {
  final ExpiryTime? selectedExpiryTime;
  final ValueChanged<ExpiryTime?> onTimeChanged;

  const ExpiryTimeDropdown({
    super.key,
    required this.selectedExpiryTime,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<ExpiryTime>(
          value: selectedExpiryTime,
          items:
              ExpiryTime.values
                  .map(
                    (expireTime) => DropdownMenuItem(
                      value: expireTime,
                      child: Text(expireTime.label),
                    ),
                  )
                  .toList(),
          onChanged: onTimeChanged,
          decoration: const InputDecoration(
            labelText: "Vervaltijd",
            border: OutlineInputBorder(),
          ),
          validator:
              (value) => value == null ? 'Selecteer een vervaltijd' : null,
        ),
      ],
    );
  }
}
