import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
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
                      child: Text(expireTime.getLabel(context)),
                    ),
                  )
                  .toList(),
          onChanged: onTimeChanged,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.expiryTime,
            border: const OutlineInputBorder(),
          ),
          validator:
              (value) =>
                  value == null
                      ? AppLocalizations.of(context)!.errorExpiryTimeEmpty
                      : null,
        ),
      ],
    );
  }
}
