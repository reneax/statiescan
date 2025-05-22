import 'package:flutter/material.dart';
import 'package:statiescan/src/database/app_database.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
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
                !isLoading ? const Text('Maak eerst een winkel aan') : null,
            decoration: const InputDecoration(
              labelText: "Winkel",
              border: OutlineInputBorder(),
            ),
            validator: (value) => value == null ? 'Selecteer een winkel' : null,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2),
          child: IconButton(icon: const Icon(Icons.add), onPressed: onStoreAdd),
        ),
      ],
    );
  }
}
