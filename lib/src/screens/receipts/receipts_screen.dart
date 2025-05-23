import 'package:flutter/material.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/screens/receipts/widgets/receipt_tile.dart';
import 'package:statiescan/src/widgets/default_screen_scaffold.dart';

class ReceiptsScreen extends StatefulWidget {
  const ReceiptsScreen({super.key});

  @override
  State<ReceiptsScreen> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  final _database = AppDatabase();
  List<Receipt> _allReceipts = [];
  Map<int, String> _storeNames = {};
  int? _selectedStoreId;

  @override
  void initState() {
    super.initState();
    _loadReceiptsAndStores();
  }

  Future<void> _loadReceiptsAndStores() async {
    final receipts = await _database.select(_database.receipts).get();
    final stores = await _database.select(_database.stores).get();

    final storeMap = {for (var s in stores) s.id: s.name};

    setState(() {
      _allReceipts = receipts;
      _storeNames = storeMap;
    });
  }

  List<Receipt> get _filteredReceipts {
    if (_selectedStoreId == null) return _allReceipts;
    return _allReceipts.where((r) => r.storeId == _selectedStoreId).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      appBar: AppBar(title: const Text("Bonnen")),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: DropdownButtonFormField<int>(
              value: _selectedStoreId,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Filter op winkel',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem<int>(
                  value: null,
                  child: Text('Alle winkels'),
                ),
                ..._storeNames.entries.map((entry) => DropdownMenuItem<int>(
                  value: entry.key,
                  child: Text(entry.value),
                )),
              ],
              onChanged: (value) => setState(() => _selectedStoreId = value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredReceipts.length,
              itemBuilder: (context, index) {
                final receipt = _filteredReceipts[index];
                return ReceiptTile(
                  receipt: receipt,
                  storeName: _storeNames[receipt.storeId]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
