import 'package:flutter/material.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';

class StoreDropdown extends StatelessWidget {
  final bool isLoading;
  final List<Store> stores;
  final ValueChanged<Store?> onStoreChanged;
  final VoidCallback onStoreAdd;
  final Store? selectedStore;

  const StoreDropdown({
    super.key,
    required this.stores,
    required this.onStoreChanged,
    required this.onStoreAdd,
    required this.selectedStore,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8,
      children: [
        Expanded(
          child: DropdownButtonFormField<Store>(
            items:
                stores
                    .map(
                      (store) => DropdownMenuItem(
                        value: store,
                        child: Text(store.name),
                      ),
                    )
                    .toList(),
            onChanged: onStoreChanged,
            value: selectedStore,
            disabledHint:
                !isLoading
                    ? Text(AppLocalizations.of(context)!.createStoreFirst)
                    : null,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.store,
              border: OutlineInputBorder(),
            ),
            validator:
                (value) =>
                    value == null
                        ? AppLocalizations.of(context)!.errorEmptyStore
                        : null,
          ),
        ),
        IconButton.filled(icon: const Icon(Icons.add), onPressed: onStoreAdd),
      ],
    );
  }
}
