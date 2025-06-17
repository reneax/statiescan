import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:provider/provider.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/receipts/widgets/no_receipts_hint.dart';
import 'package:statiescan/src/screens/receipts/widgets/receipt_tile/receipt_tile.dart';
import 'package:statiescan/src/screens/receipts/widgets/store_header.dart';
import 'package:statiescan/src/screens/receipts/widgets/stores_dropdown.dart';
import 'package:statiescan/src/utils/amount_formatter.dart';
import 'package:statiescan/src/widgets/screen_wrapper.dart';

class ReceiptsScreen extends StatefulWidget {
  const ReceiptsScreen({super.key});

  @override
  State<ReceiptsScreen> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  int? _selectedStoreId;

  @override
  void initState() {
    super.initState();
    _deleteExpiredReceipts();
  }

  void _handleStorePicked(int? value) {
    setState(() {
      _selectedStoreId = value;
    });
  }

  Future<void> _deleteExpiredReceipts() async {
    if (!AppSettings.deleteOnExpiry.get()) {
      return;
    }

    final database = context.read<AppDatabase>();

    final now = DateTime.now();

    final expiredReceipts =
        await (database.select(database.receipts)..where(
          (r) => r.deletedAt.isNull() & r.expiresAt.isSmallerThanValue(now),
        )).get();

    if (expiredReceipts.isEmpty) return;

    final idsToDelete = expiredReceipts.map((r) => r.id).toList();

    await (database.update(database.receipts)..where(
      (r) => r.id.isIn(idsToDelete),
    )).write(ReceiptsCompanion(deletedAt: drift.Value(DateTime.now())));
  }

  Stream<Map<Store, List<Receipt>>> watchStoresWithReceipts() {
    final database = context.read<AppDatabase>();

    final query = database.select(database.stores).join([
      drift.leftOuterJoin(
        database.receipts,
        database.receipts.storeId.equalsExp(database.stores.id) &
            database.receipts.deletedAt.isNull(),
      ),
    ]);

    return query.watch().map((rows) {
      final Map<Store, List<Receipt>> storeToReceipts = {};

      for (final row in rows) {
        final store = row.readTable(database.stores);
        final receipt = row.readTableOrNull(database.receipts);

        storeToReceipts.putIfAbsent(store, () => []);

        if (receipt != null) {
          storeToReceipts[store]!.add(receipt);
        }
      }

      return storeToReceipts;
    });
  }

  String _getTotalAmountFromReceipts(List<Receipt> receipts) {
    int amountInCents = receipts
        .map((receipt) => receipt.amountInCents)
        .fold(0, (sum, amount) => sum + amount);

    return "€${AmountFormatter.amountToString(amountInCents)}";
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: AppBar(title: Text("Bonnen")),
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
            return NoReceiptsHint();
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
                  header: StoreHeader(
                    title: entry.key.name,
                    amount: _getTotalAmountFromReceipts(entry.value),
                  ),
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
