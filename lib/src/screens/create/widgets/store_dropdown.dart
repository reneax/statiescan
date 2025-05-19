import 'package:flutter/material.dart';
import 'package:statiescan/src/database/app_database.dart';

class StoreDropdown extends StatelessWidget {
  final List<Store> stores;
  final ValueChanged<Store?> onStoreChanged;
  final Store? selectedStore;

  const StoreDropdown({
    super.key,
    required this.stores,
    required this.onStoreChanged,
    required this.selectedStore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<Store>(
          items:
              stores
                  .map(
                    (store) =>
                        DropdownMenuItem(value: store, child: Text(store.name)),
                  )
                  .toList(),
          onChanged: onStoreChanged,
          value: selectedStore,
          decoration: const InputDecoration(
            labelText: "Winkel",
            border: OutlineInputBorder(),
          ),
          validator: (value) => value == null ? 'Selecteer een winkel' : null,
        ),
      ],
    );
  }
}
