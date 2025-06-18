// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get addNewStore => 'Add new store';

  @override
  String get storeName => 'Store name';

  @override
  String get errorEmptyStore => 'Enter a store name';

  @override
  String get errorTooLongName => 'This name is too long.';

  @override
  String get errorStoreExists => 'This store already exists.';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get amount => 'Amount';

  @override
  String get errorAmountInvalid => 'Enter a valid amount';

  @override
  String get expiryTime => 'Expiration time';

  @override
  String get errorExpiryTimeEmpty => 'Select an expiration time';

  @override
  String get createStoreFirst => 'Create a store first';

  @override
  String get store => 'Store';

  @override
  String get errorStoreEmpty => 'Select a store';

  @override
  String get saveReceiptSuccess => 'Receipt saved successfully.';

  @override
  String get addReceipt => 'Add receipt';

  @override
  String get noExpiration => 'None';

  @override
  String get oneWeek => '1 week';

  @override
  String get oneMonth => '1 month';

  @override
  String get threeMonths => '3 months';

  @override
  String get sixMonths => '6 months';

  @override
  String get oneYear => '1 year';

  @override
  String get saveReceipt => 'Save receipt';

  @override
  String get share => 'Share';

  @override
  String get noExpiryDate => 'No expiration date';

  @override
  String expiresOnDate(String date) {
    return 'Expires on $date';
  }

  @override
  String expiredOnDate(String date) {
    return 'Expired on $date';
  }

  @override
  String get deleteHintSuggestion => 'Hold to delete the receipt.';

  @override
  String amountDescription(String amount) {
    return 'The amount is €$amount';
  }

  @override
  String get receiptFileName => 'deposit';

  @override
  String shareMessage(String amount, String storeName) {
    return 'Deposit receipt of €$amount redeemable at $storeName. Sent from the Statiescan app.';
  }

  @override
  String get dontForgetDeleteAfterShare =>
      'Don\'t forget to delete the receipt after sharing.';

  @override
  String get receiptDeleteSuccess => 'Receipt deleted successfully.';

  @override
  String get receiptDetailsTitle => 'View receipt';

  @override
  String get nextButton => 'Next';

  @override
  String get continueButton => 'Continue';

  @override
  String get slideOneTitle => 'Scan with app';

  @override
  String get slideOneDescription =>
      'Easily scan deposit receipts with your phone.';

  @override
  String get slideTwoTitle => 'Find receipts';

  @override
  String get slideTwoDescription => 'Quickly find your saved receipts.';

  @override
  String get slideThreeTitle => 'Receipt expiration alert';

  @override
  String get slideThreeDescription =>
      'Get notifications before your receipt expires.';

  @override
  String get slideFourTitle => 'Share with people';

  @override
  String get slideFourDescription => 'Easily share your receipts with others.';

  @override
  String get noReceiptsFound => 'No receipts found';

  @override
  String get addNewReceiptHint =>
      'Add a new receipt using the plus icon below.';

  @override
  String get filterStore => 'Filter by store';

  @override
  String get allStores => 'All stores';

  @override
  String get receiptsTitle => 'Receipts';

  @override
  String get processingReceipt => 'Processing...';

  @override
  String get scanReceiptTitle => 'Scan receipt';

  @override
  String get aboutSection => 'About';

  @override
  String get statisticsOption => 'Statistics';

  @override
  String get reviewUsOption => 'Rate us';

  @override
  String get reviewUsDescription => 'Give the app a rating';

  @override
  String get githubOption => 'Github';

  @override
  String get githubDescription => 'View the app’s source code';

  @override
  String get generalSection => 'General';

  @override
  String get vibrationOption => 'Vibrate on actions';

  @override
  String get nextAfterDeleteOption => 'Next receipt after deletion';

  @override
  String get nextAfterDeleteDescription =>
      'Go to the next store receipt after deletion.';

  @override
  String get deleteExpiredReceiptsOption => 'Delete expired receipts';

  @override
  String get deleteExpiredReceiptsDescription =>
      'Automatically delete receipts once they expire.';

  @override
  String get errorNotificationPermissionDenied =>
      'Could not get permission. Enable notification permissions in app settings.';

  @override
  String get notificationSection => 'Notifications';

  @override
  String get notificationsEnabledOption => 'Receive notifications';

  @override
  String get daysBeforeExpiryOption =>
      'Days before receipt expiry notification';

  @override
  String get daysBeforeExpiryDescription =>
      'Set how many days in advance you want to be notified about a receipt expiration.';

  @override
  String get scannerSection => 'Scanner';

  @override
  String get automaticAmountDetectionOption => 'Auto-fill amount';

  @override
  String get automaticAmountDetectionDescription =>
      'Automatically fills the receipt amount when possible. Requires more processing power.';

  @override
  String get daysBeforeNotificationTitle => 'Days before notification';

  @override
  String notificationDays(int day) {
    String _temp0 = intl.Intl.pluralLogic(
      day,
      locale: localeName,
      other: '$day days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get statisticsTitle => 'Statistics';

  @override
  String get loadingStatistics => 'Loading data...';

  @override
  String storeCount(int count) {
    return 'Number of stores: $count';
  }

  @override
  String redeemableReceipts(int count) {
    return 'Redeemable receipts: $count';
  }

  @override
  String redeemedReceipts(int count) {
    return 'Redeemed receipts: $count';
  }

  @override
  String availableAmount(String amount) {
    return 'Available amount: €$amount';
  }

  @override
  String redeemedAmount(String amount) {
    return 'Redeemed amount: €$amount';
  }

  @override
  String averageAmountPerReceipt(String amount) {
    return 'Average per receipt: €$amount';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get receiptExpiringSoon => 'Receipt expiring soon';

  @override
  String get receiptExpiringChannel => 'Receipt nearly expired';

  @override
  String get receiptExpiringChannelDescription =>
      'Notifications for receipts nearing expiration.';

  @override
  String receiptExpiresIn(String storeName, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '1 day',
    );
    return 'A receipt from $storeName expires in $_temp0.';
  }

  @override
  String get receiptExpired => 'Receipt expired';

  @override
  String receiptExpiresOn(String storeName) {
    return 'A receipt from $storeName expired today.';
  }

  @override
  String get receiptExpiredChannel => 'Receipt expired';

  @override
  String get receiptExpiredChannelDescription =>
      'Notifications for receipts that are about to expire.';

  @override
  String get receiptsTab => 'Receipts';

  @override
  String get settingsTab => 'Settings';
}
