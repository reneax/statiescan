import 'package:flutter/material.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';

class StoresDropdown extends StatelessWidget {
  final List<Store> stores;
  final int? selectedStoreId;
  final ValueChanged<int?> onStoreChosen;

  const StoresDropdown({
    super.key,
    required this.stores,
    required this.selectedStoreId,
    required this.onStoreChosen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: DropdownButtonFormField<int>(
        value: selectedStoreId,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.filterStore,
          border: OutlineInputBorder(),
        ),
        items: [
          DropdownMenuItem<int>(
            value: null,
            child: Text(AppLocalizations.of(context)!.allStores),
          ),
          ...stores.map(
            (entry) =>
                DropdownMenuItem<int>(value: entry.id, child: Text(entry.name)),
          ),
        ],
        onChanged: onStoreChosen,
      ),
    );
  }
}
