import 'package:flutter/material.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/screens/receipts/widgets/receipt_tile.dart';
import 'package:statiescan/src/screens/receipts/widgets/stores_dropdown.dart';
import 'package:statiescan/src/widgets/default_screen_scaffold.dart';

class ReceiptsScreen extends StatefulWidget {
  const ReceiptsScreen({super.key});

  @override
  State<ReceiptsScreen> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  final _database = AppDatabase();
  List<Receipt> _allReceipts = [];
  List<Store> _stores = [];
  int? _selectedStoreId;

  @override
  void initState() {
    super.initState();
    _loadReceiptsAndStores();
  }

  void _handleStorePicked(int? value) {
    setState(() {
      _selectedStoreId = value;
    });
  }

  Future<void> _loadReceiptsAndStores() async {
    final receipts = await _database.select(_database.receipts).get();
    final stores = await _database.select(_database.stores).get();

    setState(() {
      _allReceipts = receipts;
      _stores = stores;
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
          StoresDropdown(
            stores: _stores,
            selectedStoreId: _selectedStoreId,
            onStoreChosen: _handleStorePicked,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredReceipts.length,
              itemBuilder: (context, index) {
                final receipt = _filteredReceipts[index];
                return ReceiptTile(receipt: receipt);
              },
            ),
          ),
        ],
      ),
    );
  }
}
