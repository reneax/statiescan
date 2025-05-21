import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/create/enums/expiry_time.dart';
import 'package:statiescan/src/screens/create/widgets/add_store_dialog.dart';
import 'package:statiescan/src/screens/create/widgets/amount_input_field.dart';
import 'package:statiescan/src/screens/create/widgets/barcode_display.dart';
import 'package:statiescan/src/screens/create/widgets/expiry_time_dropdown.dart';
import 'package:statiescan/src/screens/create/widgets/store_dropdown.dart';
import 'package:statiescan/src/utils/amount_formatter.dart';
import 'package:statiescan/src/utils/snackbar_creator.dart';
import 'package:statiescan/src/widgets/default_screen_scaffold.dart';

class CreateReceiptScreen extends StatefulWidget {
  final String barcode;
  final int? amountInCents;

  const CreateReceiptScreen({
    super.key,
    required this.barcode,
    required this.amountInCents,
  });

  @override
  State<CreateReceiptScreen> createState() => _CreateReceiptScreenState();
}

class _CreateReceiptScreenState extends State<CreateReceiptScreen> {
  final _database = AppDatabase();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _amountFocusNode = FocusNode();
  final TextEditingController _amountController = TextEditingController();
  Store? _selectedStore;
  ExpiryTime? _selectedExpiryTime;
  List<Store> _stores = [];

  @override
  void initState() {
    super.initState();
    _handleAmountField();
    _initializeSavedState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _handleStoreChanged(Store? store) {
    setState(() {
      _selectedStore = store;
      if (_selectedStore != null) {
        _selectedExpiryTime =
            ExpiryTime.values
                .where((e) => e.id == _selectedStore!.lastExpiryTimeId)
                .firstOrNull;
      }
    });
  }

  void _handleTimeChanged(ExpiryTime? expireTime) {
    setState(() {
      _selectedExpiryTime = expireTime;
    });
  }

  void _handleAmountField() {
    if (widget.amountInCents != null) {
      _amountController.text = AmountFormatter.amountToString(
        widget.amountInCents!,
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _amountFocusNode.requestFocus();
      });
    }
  }

  Future<void> _initializeSavedState() async {
    final stores = await _loadStores();
    final (store, expiryTime) = await _loadLastOptions(stores);

    setState(() {
      _stores = stores;
      _selectedStore = store;
      _selectedExpiryTime = expiryTime;
    });
  }

  void _handleAddStore() async {
    final newStoreName = await showDialog<String>(
      context: context,
      builder: (context) => const AddStoreDialog(),
    );

    if (newStoreName == null || newStoreName.isEmpty) return;

    int newStoreId = await _database
        .into(_database.stores)
        .insert(StoresCompanion.insert(name: newStoreName));

    final stores = await _loadStores();

    setState(() {
      _stores = stores;
      _selectedStore = stores.firstWhere((s) => s.id == newStoreId);
    });
  }

  void _saveReceipt() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    int formattedAmount =
        AmountFormatter.stringToAmount(_amountController.text)!;

    AppSettings.lastChosenStoreId.set(_selectedStore!.id);

    DateTime? expiryDate =
        _selectedExpiryTime!.days != null
            ? DateTime.now().add(Duration(days: _selectedExpiryTime!.days!))
            : null;

    await _database
        .into(_database.receipts)
        .insert(
          ReceiptsCompanion.insert(
            code: widget.barcode,
            expiresAt: drift.Value(expiryDate),
            amountInCents: formattedAmount,
            storeId: _selectedStore!.id,
          ),
        );

    await (_database.update(_database.stores)
      ..where((tbl) => tbl.id.equals(_selectedStore!.id))).write(
      StoresCompanion(lastExpiryTimeId: drift.Value(_selectedExpiryTime!.id)),
    );

    if (mounted) {
      SnackbarCreator.show(
        context,
        message: "De bon is succesvol opgeslagen.",
        status: SnackbarStatus.success,
      );

      context.go("/receipts");
    }
  }

  Future<List<Store>> _loadStores() {
    return _database.select(_database.stores).get();
  }

  Future<(Store?, ExpiryTime?)> _loadLastOptions(List<Store> stores) async {
    int? lastStoreId = AppSettings.lastChosenStoreId.get();

    Store? store;
    ExpiryTime? expiryTime;

    if (lastStoreId != null) {
      store = stores.where((s) => s.id == lastStoreId).firstOrNull;
    }

    if (store != null && store.lastExpiryTimeId != null) {
      expiryTime =
          ExpiryTime.values
              .where((e) => e.id == store!.lastExpiryTimeId)
              .firstOrNull;
    }

    return (store, expiryTime);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      appBar: AppBar(title: const Text("Bon toevoegen")),
      showNavigation: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BarcodeDisplay(barcode: widget.barcode),
                AmountInputField(
                  editingController: _amountController,
                  focusNode: _amountFocusNode,
                ),
                StoreDropdown(
                  selectedStore: _selectedStore,
                  stores: _stores,
                  onStoreAdd: _handleAddStore,
                  onStoreChanged: _handleStoreChanged,
                ),
                ExpiryTimeDropdown(
                  selectedExpiryTime: _selectedExpiryTime,
                  onTimeChanged: _handleTimeChanged,
                ),
                FilledButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Bon opslaan"),
                  onPressed: _saveReceipt,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
