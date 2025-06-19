// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get addNewStore => 'Nieuwe winkel toevoegen';

  @override
  String get storeName => 'Winkelnaam';

  @override
  String get errorEmptyStore => 'Voer een winkelnaam in';

  @override
  String get errorTooLongName => 'Deze naam is te lang.';

  @override
  String get errorStoreExists => 'Deze winkel bestaat al.';

  @override
  String get cancel => 'Annuleren';

  @override
  String get close => 'Sluiten';

  @override
  String get save => 'Opslaan';

  @override
  String get amount => 'Bedrag';

  @override
  String get errorAmountInvalid => 'Voer een geldig bedrag in';

  @override
  String get expiryTime => 'Vervaltijd';

  @override
  String get errorExpiryTimeEmpty => 'Selecteer een vervaltijd';

  @override
  String get createStoreFirst => 'Maak eerst een winkel aan';

  @override
  String get store => 'Winkel';

  @override
  String get errorStoreEmpty => 'Selecteer een winkel';

  @override
  String get saveReceiptSuccess => 'De bon is succesvol opgeslagen.';

  @override
  String get addReceipt => 'Bon toevoegen';

  @override
  String get noExpiration => 'Geen';

  @override
  String get oneWeek => '1 week';

  @override
  String get oneMonth => '1 maand';

  @override
  String get threeMonths => '3 maanden';

  @override
  String get sixMonths => '6 maanden';

  @override
  String get oneYear => '1 jaar';

  @override
  String get saveReceipt => 'Bon opslaan';

  @override
  String get share => 'Delen';

  @override
  String get noExpiryDate => 'Geen verloopdatum';

  @override
  String expiresOnDate(String date) {
    return 'Verloopt op $date';
  }

  @override
  String expiredOnDate(String date) {
    return 'Verlopen op $date';
  }

  @override
  String get deleteHintSuggestion => 'Houd ingedrukt om te verwijderen.';

  @override
  String amountDescription(String amount) {
    return 'Het bedrag is €$amount';
  }

  @override
  String get receiptFileName => 'emballage';

  @override
  String shareMessage(String amount, String storeName) {
    return 'Emballage bon van €$amount die je kunt inleveren bij $storeName. Verstuurd vanaf de Statiescan app.';
  }

  @override
  String get dontForgetDeleteAfterShare =>
      'Vergeet de bon niet te verwijderen na het delen.';

  @override
  String get receiptDeleteSuccess => 'De bon is succesvol verwijderd.';

  @override
  String get receiptDetailsTitle => 'Bon weergeven';

  @override
  String get nextButton => 'Verder';

  @override
  String get continueButton => 'Doorgaan';

  @override
  String get slideOneTitle => 'Scannen met app';

  @override
  String get slideOneDescription =>
      'Scan statiegeld bonnen eenvoudig met je telefoon.';

  @override
  String get slideTwoTitle => 'Bonnetjes terugvinden';

  @override
  String get slideTwoDescription => 'Vind je opgeslagen bonnetjes snel terug.';

  @override
  String get slideThreeTitle => 'Bon vervalt melding';

  @override
  String get slideThreeDescription => 'Krijg meldingen voordat je bon vervalt.';

  @override
  String get slideFourTitle => 'Delen met mensen';

  @override
  String get slideFourDescription => 'Deel je bonnen gemakkelijk met anderen.';

  @override
  String get noReceiptsFound => 'Geen bonnen gevonden';

  @override
  String get addNewReceiptHint =>
      'Voeg een nieuwe bon toe met het plusicoon onderaan.';

  @override
  String get filterStore => 'Filter op winkel';

  @override
  String get allStores => 'Alle winkels';

  @override
  String get receiptsTitle => 'Bonnen';

  @override
  String get processingReceipt => 'Verwerken...';

  @override
  String get scanReceiptTitle => 'Bon scannen';

  @override
  String get aboutSection => 'Over';

  @override
  String get statisticsOption => 'Statistieken';

  @override
  String get reviewUsOption => 'Beoordeel ons';

  @override
  String get reviewUsDescription => 'Geef de app een beoordeling';

  @override
  String get githubOption => 'Github';

  @override
  String get githubDescription => 'Bekijk de broncode van de app';

  @override
  String get generalSection => 'Algemeen';

  @override
  String get vibrationOption => 'Trillen bij acties';

  @override
  String get nextAfterDeleteOption => 'Volgende bon na verwijderen';

  @override
  String get nextAfterDeleteDescription =>
      'Ga na het verwijderen naar de volgende bon van de supermarkt.';

  @override
  String get deleteExpiredReceiptsOption => 'Verlopen bonnen wissen';

  @override
  String get deleteExpiredReceiptsDescription =>
      'Bon automatisch verwijderen als deze verloopt.';

  @override
  String get errorNotificationPermissionDenied =>
      'Kon geen permissie verkrijgen. Geef de app notificatie permissies via instellingen.';

  @override
  String get notificationSection => 'Meldingen';

  @override
  String get notificationsEnabledOption => 'Meldingen ontvangen';

  @override
  String get daysBeforeExpiryOption => 'Aantal dagen voor bonverval melding';

  @override
  String get daysBeforeExpiryDescription =>
      'Stel in hoeveel dagen van tevoren je een melding wilt over het verlopen van je bon.';

  @override
  String get scannerSection => 'Scanner';

  @override
  String get automaticAmountDetectionOption => 'Automatisch bedrag invullen';

  @override
  String get automaticAmountDetectionDescription =>
      'Vult automatisch het bonbedrag in wanneer mogelijk. Dit vereist meer rekenkracht.';

  @override
  String get daysBeforeNotificationTitle => 'Dagen voor melding bon';

  @override
  String notificationDays(int day) {
    String _temp0 = intl.Intl.pluralLogic(
      day,
      locale: localeName,
      other: '$day dagen',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String get statisticsTitle => 'Statistieken';

  @override
  String get loadingStatistics => 'Data aan het laden...';

  @override
  String storeCount(int count) {
    return 'Aantal winkels: $count';
  }

  @override
  String redeemableReceipts(int count) {
    return 'Inleverbare bonnen: $count';
  }

  @override
  String redeemedReceipts(int count) {
    return 'Ingeleverde bonnen: $count';
  }

  @override
  String availableAmount(String amount) {
    return 'Beschikbaar bedrag: €$amount';
  }

  @override
  String redeemedAmount(String amount) {
    return 'Verkregen bedrag: €$amount';
  }

  @override
  String averageAmountPerReceipt(String amount) {
    return 'Gemiddeld per bon: €$amount';
  }

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get receiptExpiringSoon => 'Bon verloopt binnenkort';

  @override
  String get receiptExpiringChannel => 'Bon bijna vervallen';

  @override
  String get receiptExpiringChannelDescription =>
      'Meldingen voor bonnen die binnenkort vervallen.';

  @override
  String receiptExpiresIn(String storeName, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dagen',
      one: '1 dag',
      zero: '0 dagen',
    );
    return 'Een bon van $storeName verloopt over $_temp0.';
  }

  @override
  String get receiptExpired => 'Bon verlopen';

  @override
  String receiptExpiresOn(String storeName) {
    return 'Een bon van $storeName is vandaag verlopen.';
  }

  @override
  String get receiptExpiredChannel => 'Bon verlopen';

  @override
  String get receiptExpiredChannelDescription =>
      'Meldingen voor bonnen die binnenkort vervallen.';

  @override
  String get receiptsTab => 'Bonnen';

  @override
  String get settingsTab => 'Instellingen';

  @override
  String get preferencesSection => 'Voorkeuren';

  @override
  String get languageOption => 'Taal aanpassen';

  @override
  String get themeOption => 'Thema veranderen';

  @override
  String get systemLanguage => 'Systeem';

  @override
  String get languageTitle => 'Taal';

  @override
  String get themeTitle => 'Thema';

  @override
  String get systemTheme => 'Systeem';

  @override
  String get lightTheme => 'Licht';

  @override
  String get darkTheme => 'Donker';
}
