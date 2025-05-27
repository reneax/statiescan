import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/screens/receipts/widgets/receipt_tile/receipt_tile.dart';
import 'package:statiescan/src/screens/receipts/widgets/store_header.dart';
import 'package:statiescan/src/screens/receipts/widgets/stores_dropdown.dart';
import 'package:statiescan/src/widgets/default_screen_scaffold.dart';

class ReceiptsScreen extends StatefulWidget {
  const ReceiptsScreen({super.key});

  @override
  State<ReceiptsScreen> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  final _database = AppDatabase();
  int? _selectedStoreId;

  void _handleStorePicked(int? value) {
    setState(() {
      _selectedStoreId = value;
    });
  }

  Stream<Map<Store, List<Receipt>>> watchStoresWithReceipts() {
    final query = _database.select(_database.stores).join([
      drift.leftOuterJoin(
        _database.receipts,
        _database.receipts.storeId.equalsExp(_database.stores.id),
      ),
    ]);

    return query.watch().map((rows) {
      final Map<Store, List<Receipt>> map = {};

      for (final row in rows) {
        final store = row.readTable(_database.stores);
        final receipt = row.readTableOrNull(_database.receipts);

        map.putIfAbsent(store, () => []);

        if (receipt != null) {
          map[store]!.add(receipt);
        }
      }

      return map;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultScreenScaffold(
      appBar: AppBar(title: const Text("Bonnen")),
      child: StreamBuilder<Map<Store, List<Receipt>>>(
        stream: watchStoresWithReceipts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final stores = snapshot.data!.keys.toList();
          final filteredStores = Map<Store, List<Receipt>>.from(snapshot.data!)
            ..removeWhere(
              (store, receipts) =>
                  _selectedStoreId != null
                      ? store.id != _selectedStoreId
                      : receipts.isEmpty,
            );

          if (filteredStores.isEmpty) {
            return Center(
              child: Column(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Geen bonnen gevonden.",
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    "Voeg een nieuwe bon toe met het plusicoon onderaan.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );

          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: StoresDropdown(
                  stores: stores,
                  selectedStoreId: _selectedStoreId,
                  onStoreChosen: _handleStorePicked,
                ),
              ),
              ...filteredStores.entries.map(
                (entry) => SliverStickyHeader(
                  header: StoreHeader(title: entry.key.name),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: entry.value.length,
                      (context, index) =>
                          ReceiptTile(receipt: entry.value[index]),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          );
        },
      ),
    );
  }
}
