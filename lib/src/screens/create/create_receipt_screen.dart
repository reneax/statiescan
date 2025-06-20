import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/create/enums/expiry_time.dart';
import 'package:statiescan/src/screens/create/widgets/add_store_dialog.dart';
import 'package:statiescan/src/screens/create/widgets/amount_input_field.dart';
import 'package:statiescan/src/screens/create/widgets/expiry_time_dropdown.dart';
import 'package:statiescan/src/screens/create/widgets/store_dropdown.dart';
import 'package:statiescan/src/services/notification_service.dart';
import 'package:statiescan/src/utils/amount_formatter.dart';
import 'package:statiescan/src/utils/convert_utils.dart';
import 'package:statiescan/src/utils/snackbar_creator.dart';
import 'package:statiescan/src/widgets/barcode_display.dart';

class CreateReceiptScreen extends StatefulWidget {
  final String barcode;
  final int? amountInCents;
  final int typeId;

  const CreateReceiptScreen({
    super.key,
    required this.barcode,
    required this.amountInCents,
    required this.typeId,
  });

  @override
  State<CreateReceiptScreen> createState() => _CreateReceiptScreenState();
}

class _CreateReceiptScreenState extends State<CreateReceiptScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _amountFocusNode = FocusNode();
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = true;
  Store? _selectedStore;
  ExpiryTime? _selectedExpiryTime;
  List<Store> _stores = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isLoading = true;
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

      if (store != null) {
        _selectedExpiryTime =
            ExpiryTime.values
                .where((e) => e.id == store.lastExpiryTimeId)
                .firstOrNull;
      }
    });
  }

  void _handleTimeChanged(ExpiryTime? expiryTime) {
    setState(() {
      _selectedExpiryTime = expiryTime;
    });
  }

  void _handleAmountField() {
    final amountInCents = widget.amountInCents;

    if (amountInCents != null) {
      _amountController.text = AmountFormatter.amountToString(amountInCents);
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
      _isLoading = false;
    });
  }

  void _handleAddStore() async {
    final database = context.read<AppDatabase>();

    final newStoreName = await showDialog<String>(
      context: context,
      builder: (context) => AddStoreDialog(existingStores: _stores),
    );

    if (newStoreName == null || newStoreName.isEmpty) return;

    int newStoreId = await database
        .into(database.stores)
        .insert(StoresCompanion.insert(name: newStoreName));

    final stores = await _loadStores();

    setState(() {
      _stores = stores;
      _selectedStore = stores.firstWhere((s) => s.id == newStoreId);
      _selectedExpiryTime = null;
    });
  }

  void _saveReceipt() async {
    final currentFormState = _formKey.currentState;

    if (currentFormState == null || !currentFormState.validate()) {
      return;
    }

    final currentStore = _selectedStore;
    final currentExpiryTime = _selectedExpiryTime;

    if (currentStore == null || currentExpiryTime == null) return;

    int formattedAmount =
        AmountFormatter.stringToAmount(_amountController.text)!;

    AppSettings.lastChosenStoreId.set(currentStore.id);

    DateTime? expiryDate = currentExpiryTime.getExpiryDate(DateTime.now());

    expiryDate = expiryDate?.add(Duration(days: 1));

    final database = context.read<AppDatabase>();

    final insertedReceipt = await database
        .into(database.receipts)
        .insertReturning(
          ReceiptsCompanion.insert(
            code: widget.barcode,
            typeId: drift.Value(widget.typeId),
            expiresAt: drift.Value(expiryDate),
            amountInCents: formattedAmount,
            storeId: currentStore.id,
            createdAt: drift.Value(DateTime.now()),
          ),
        );

    if (currentExpiryTime.id != currentStore.lastExpiryTimeId) {
      await (database.update(database.stores)
        ..where((tbl) => tbl.id.equals(currentStore.id))).write(
        StoresCompanion(lastExpiryTimeId: drift.Value(currentExpiryTime.id)),
      );
    }

    if (AppSettings.notificationsEnabled.get() && mounted) {
      final notificationService = context.read<NotificationService>();
      final notificationsAllowed =
          await notificationService.isNotificationsAllowed();

      if (notificationsAllowed && mounted) {
        await notificationService.scheduleReceiptExpiryNotification(
          context,
          insertedReceipt,
          currentStore,
        );
      }
    }

    if (mounted) {
      SnackbarCreator.show(
        context,
        duration: Duration(seconds: 2),
        message: AppLocalizations.of(context)!.saveReceiptSuccess,
        status: SnackbarStatus.success,
      );

      context.go("/receipts");
    }
  }

  Future<List<Store>> _loadStores() {
    final database = context.read<AppDatabase>();

    return database.select(database.stores).get();
  }

  Future<(Store?, ExpiryTime?)> _loadLastOptions(List<Store> stores) async {
    int? lastStoreId = AppSettings.lastChosenStoreId.get();

    Store? store;
    ExpiryTime? expiryTime;

    if (lastStoreId != null) {
      store = stores.where((s) => s.id == lastStoreId).firstOrNull;
    }

    final expiryTimeId = store?.lastExpiryTimeId;

    if (expiryTimeId != null) {
      expiryTime =
          ExpiryTime.values.where((e) => e.id == expiryTimeId).firstOrNull;
    }

    return (store, expiryTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.addReceipt)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BarcodeDisplay(
                  barcode: widget.barcode,
                  type: ConvertUtils.getBarcodeType(widget.typeId),
                ),
                AmountInputField(
                  editingController: _amountController,
                  focusNode: _amountFocusNode,
                ),
                StoreDropdown(
                  isLoading: _isLoading,
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
                  label: Text(AppLocalizations.of(context)!.saveReceipt),
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
