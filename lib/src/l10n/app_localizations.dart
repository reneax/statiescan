import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('nl'),
  ];

  /// No description provided for @addNewStore.
  ///
  /// In nl, this message translates to:
  /// **'Nieuwe winkel toevoegen'**
  String get addNewStore;

  /// No description provided for @storeName.
  ///
  /// In nl, this message translates to:
  /// **'Winkelnaam'**
  String get storeName;

  /// No description provided for @errorEmptyStore.
  ///
  /// In nl, this message translates to:
  /// **'Voer een winkelnaam in'**
  String get errorEmptyStore;

  /// No description provided for @errorTooLongName.
  ///
  /// In nl, this message translates to:
  /// **'Deze naam is te lang.'**
  String get errorTooLongName;

  /// No description provided for @errorStoreExists.
  ///
  /// In nl, this message translates to:
  /// **'Deze winkel bestaat al.'**
  String get errorStoreExists;

  /// No description provided for @cancel.
  ///
  /// In nl, this message translates to:
  /// **'Annuleren'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In nl, this message translates to:
  /// **'Opslaan'**
  String get save;

  /// No description provided for @amount.
  ///
  /// In nl, this message translates to:
  /// **'Bedrag'**
  String get amount;

  /// No description provided for @errorAmountInvalid.
  ///
  /// In nl, this message translates to:
  /// **'Voer een geldig bedrag in'**
  String get errorAmountInvalid;

  /// No description provided for @expiryTime.
  ///
  /// In nl, this message translates to:
  /// **'Vervaltijd'**
  String get expiryTime;

  /// No description provided for @errorExpiryTimeEmpty.
  ///
  /// In nl, this message translates to:
  /// **'Selecteer een vervaltijd'**
  String get errorExpiryTimeEmpty;

  /// No description provided for @createStoreFirst.
  ///
  /// In nl, this message translates to:
  /// **'Maak eerst een winkel aan'**
  String get createStoreFirst;

  /// No description provided for @store.
  ///
  /// In nl, this message translates to:
  /// **'Winkel'**
  String get store;

  /// No description provided for @errorStoreEmpty.
  ///
  /// In nl, this message translates to:
  /// **'Selecteer een winkel'**
  String get errorStoreEmpty;

  /// No description provided for @saveReceiptSuccess.
  ///
  /// In nl, this message translates to:
  /// **'De bon is succesvol opgeslagen.'**
  String get saveReceiptSuccess;

  /// No description provided for @addReceipt.
  ///
  /// In nl, this message translates to:
  /// **'Bon toevoegen'**
  String get addReceipt;

  /// No description provided for @noExpiration.
  ///
  /// In nl, this message translates to:
  /// **'Geen'**
  String get noExpiration;

  /// No description provided for @oneWeek.
  ///
  /// In nl, this message translates to:
  /// **'1 week'**
  String get oneWeek;

  /// No description provided for @oneMonth.
  ///
  /// In nl, this message translates to:
  /// **'1 maand'**
  String get oneMonth;

  /// No description provided for @threeMonths.
  ///
  /// In nl, this message translates to:
  /// **'3 maanden'**
  String get threeMonths;

  /// No description provided for @sixMonths.
  ///
  /// In nl, this message translates to:
  /// **'6 maanden'**
  String get sixMonths;

  /// No description provided for @oneYear.
  ///
  /// In nl, this message translates to:
  /// **'1 jaar'**
  String get oneYear;

  /// No description provided for @saveReceipt.
  ///
  /// In nl, this message translates to:
  /// **'Bon opslaan'**
  String get saveReceipt;

  /// No description provided for @share.
  ///
  /// In nl, this message translates to:
  /// **'Delen'**
  String get share;

  /// No description provided for @noExpiryDate.
  ///
  /// In nl, this message translates to:
  /// **'Geen verloopdatum'**
  String get noExpiryDate;

  /// No description provided for @expiresOnDate.
  ///
  /// In nl, this message translates to:
  /// **'Verloopt op {date}'**
  String expiresOnDate(String date);

  /// No description provided for @expiredOnDate.
  ///
  /// In nl, this message translates to:
  /// **'Verlopen op {date}'**
  String expiredOnDate(String date);

  /// No description provided for @deleteHintSuggestion.
  ///
  /// In nl, this message translates to:
  /// **'Houd ingedrukt om te verwijderen.'**
  String get deleteHintSuggestion;

  /// No description provided for @amountDescription.
  ///
  /// In nl, this message translates to:
  /// **'Het bedrag is €{amount}'**
  String amountDescription(String amount);

  /// No description provided for @receiptFileName.
  ///
  /// In nl, this message translates to:
  /// **'emballage'**
  String get receiptFileName;

  /// No description provided for @shareMessage.
  ///
  /// In nl, this message translates to:
  /// **'Emballage bon van €{amount} die je kunt inleveren bij {storeName}. Verstuurd vanaf de Statiescan app.'**
  String shareMessage(String amount, String storeName);

  /// No description provided for @dontForgetDeleteAfterShare.
  ///
  /// In nl, this message translates to:
  /// **'Vergeet de bon niet te verwijderen na het delen.'**
  String get dontForgetDeleteAfterShare;

  /// No description provided for @receiptDeleteSuccess.
  ///
  /// In nl, this message translates to:
  /// **'De bon is succesvol verwijderd.'**
  String get receiptDeleteSuccess;

  /// No description provided for @receiptDetailsTitle.
  ///
  /// In nl, this message translates to:
  /// **'Bon weergeven'**
  String get receiptDetailsTitle;

  /// No description provided for @nextButton.
  ///
  /// In nl, this message translates to:
  /// **'Verder'**
  String get nextButton;

  /// No description provided for @continueButton.
  ///
  /// In nl, this message translates to:
  /// **'Doorgaan'**
  String get continueButton;

  /// No description provided for @slideOneTitle.
  ///
  /// In nl, this message translates to:
  /// **'Scannen met app'**
  String get slideOneTitle;

  /// No description provided for @slideOneDescription.
  ///
  /// In nl, this message translates to:
  /// **'Scan statiegeld bonnen eenvoudig met je telefoon.'**
  String get slideOneDescription;

  /// No description provided for @slideTwoTitle.
  ///
  /// In nl, this message translates to:
  /// **'Bonnetjes terugvinden'**
  String get slideTwoTitle;

  /// No description provided for @slideTwoDescription.
  ///
  /// In nl, this message translates to:
  /// **'Vind je opgeslagen bonnetjes snel terug.'**
  String get slideTwoDescription;

  /// No description provided for @slideThreeTitle.
  ///
  /// In nl, this message translates to:
  /// **'Bon vervalt melding'**
  String get slideThreeTitle;

  /// No description provided for @slideThreeDescription.
  ///
  /// In nl, this message translates to:
  /// **'Krijg meldingen voordat je bon vervalt.'**
  String get slideThreeDescription;

  /// No description provided for @slideFourTitle.
  ///
  /// In nl, this message translates to:
  /// **'Delen met mensen'**
  String get slideFourTitle;

  /// No description provided for @slideFourDescription.
  ///
  /// In nl, this message translates to:
  /// **'Deel je bonnen gemakkelijk met anderen.'**
  String get slideFourDescription;

  /// No description provided for @noReceiptsFound.
  ///
  /// In nl, this message translates to:
  /// **'Geen bonnen gevonden'**
  String get noReceiptsFound;

  /// No description provided for @addNewReceiptHint.
  ///
  /// In nl, this message translates to:
  /// **'Voeg een nieuwe bon toe met het plusicoon onderaan.'**
  String get addNewReceiptHint;

  /// No description provided for @filterStore.
  ///
  /// In nl, this message translates to:
  /// **'Filter op winkel'**
  String get filterStore;

  /// No description provided for @allStores.
  ///
  /// In nl, this message translates to:
  /// **'Alle winkels'**
  String get allStores;

  /// No description provided for @receiptsTitle.
  ///
  /// In nl, this message translates to:
  /// **'Bonnen'**
  String get receiptsTitle;

  /// No description provided for @processingReceipt.
  ///
  /// In nl, this message translates to:
  /// **'Verwerken...'**
  String get processingReceipt;

  /// No description provided for @scanReceiptTitle.
  ///
  /// In nl, this message translates to:
  /// **'Bon scannen'**
  String get scanReceiptTitle;

  /// No description provided for @aboutSection.
  ///
  /// In nl, this message translates to:
  /// **'Over'**
  String get aboutSection;

  /// No description provided for @statisticsOption.
  ///
  /// In nl, this message translates to:
  /// **'Statistieken'**
  String get statisticsOption;

  /// No description provided for @reviewUsOption.
  ///
  /// In nl, this message translates to:
  /// **'Beoordeel ons'**
  String get reviewUsOption;

  /// No description provided for @reviewUsDescription.
  ///
  /// In nl, this message translates to:
  /// **'Geef de app een beoordeling'**
  String get reviewUsDescription;

  /// No description provided for @githubOption.
  ///
  /// In nl, this message translates to:
  /// **'Github'**
  String get githubOption;

  /// No description provided for @githubDescription.
  ///
  /// In nl, this message translates to:
  /// **'Bekijk de broncode van de app'**
  String get githubDescription;

  /// No description provided for @generalSection.
  ///
  /// In nl, this message translates to:
  /// **'Algemeen'**
  String get generalSection;

  /// No description provided for @vibrationOption.
  ///
  /// In nl, this message translates to:
  /// **'Trillen bij acties'**
  String get vibrationOption;

  /// No description provided for @nextAfterDeleteOption.
  ///
  /// In nl, this message translates to:
  /// **'Volgende bon na verwijderen'**
  String get nextAfterDeleteOption;

  /// No description provided for @nextAfterDeleteDescription.
  ///
  /// In nl, this message translates to:
  /// **'Ga na het verwijderen naar de volgende bon van de supermarkt.'**
  String get nextAfterDeleteDescription;

  /// No description provided for @deleteExpiredReceiptsOption.
  ///
  /// In nl, this message translates to:
  /// **'Verlopen bonnen wissen'**
  String get deleteExpiredReceiptsOption;

  /// No description provided for @deleteExpiredReceiptsDescription.
  ///
  /// In nl, this message translates to:
  /// **'Bon automatisch verwijderen als deze verloopt.'**
  String get deleteExpiredReceiptsDescription;

  /// No description provided for @errorNotificationPermissionDenied.
  ///
  /// In nl, this message translates to:
  /// **'Kon geen permissie verkrijgen. Geef de app notificatie permissies via instellingen.'**
  String get errorNotificationPermissionDenied;

  /// No description provided for @notificationSection.
  ///
  /// In nl, this message translates to:
  /// **'Meldingen'**
  String get notificationSection;

  /// No description provided for @notificationsEnabledOption.
  ///
  /// In nl, this message translates to:
  /// **'Meldingen ontvangen'**
  String get notificationsEnabledOption;

  /// No description provided for @daysBeforeExpiryOption.
  ///
  /// In nl, this message translates to:
  /// **'Aantal dagen voor bonverval melding'**
  String get daysBeforeExpiryOption;

  /// No description provided for @daysBeforeExpiryDescription.
  ///
  /// In nl, this message translates to:
  /// **'Stel in hoeveel dagen van tevoren je een melding wilt over het verlopen van je bon.'**
  String get daysBeforeExpiryDescription;

  /// No description provided for @scannerSection.
  ///
  /// In nl, this message translates to:
  /// **'Scanner'**
  String get scannerSection;

  /// No description provided for @automaticAmountDetectionOption.
  ///
  /// In nl, this message translates to:
  /// **'Automatisch bedrag invullen'**
  String get automaticAmountDetectionOption;

  /// No description provided for @automaticAmountDetectionDescription.
  ///
  /// In nl, this message translates to:
  /// **'Vult automatisch het bonbedrag in wanneer mogelijk. Dit vereist meer rekenkracht.'**
  String get automaticAmountDetectionDescription;

  /// No description provided for @daysBeforeNotificationTitle.
  ///
  /// In nl, this message translates to:
  /// **'Dagen voor melding bon'**
  String get daysBeforeNotificationTitle;

  /// No description provided for @notificationDays.
  ///
  /// In nl, this message translates to:
  /// **'{day, plural, =1{1 dag} other{{day} dagen}}'**
  String notificationDays(int day);

  /// No description provided for @statisticsTitle.
  ///
  /// In nl, this message translates to:
  /// **'Statistieken'**
  String get statisticsTitle;

  /// No description provided for @loadingStatistics.
  ///
  /// In nl, this message translates to:
  /// **'Data aan het laden...'**
  String get loadingStatistics;

  /// No description provided for @storeCount.
  ///
  /// In nl, this message translates to:
  /// **'Aantal winkels: {count}'**
  String storeCount(int count);

  /// No description provided for @redeemableReceipts.
  ///
  /// In nl, this message translates to:
  /// **'Inleverbare bonnen: {count}'**
  String redeemableReceipts(int count);

  /// No description provided for @redeemedReceipts.
  ///
  /// In nl, this message translates to:
  /// **'Ingeleverde bonnen: {count}'**
  String redeemedReceipts(int count);

  /// No description provided for @availableAmount.
  ///
  /// In nl, this message translates to:
  /// **'Beschikbaar bedrag: €{amount}'**
  String availableAmount(String amount);

  /// No description provided for @redeemedAmount.
  ///
  /// In nl, this message translates to:
  /// **'Verkregen bedrag: €{amount}'**
  String redeemedAmount(String amount);

  /// No description provided for @averageAmountPerReceipt.
  ///
  /// In nl, this message translates to:
  /// **'Gemiddeld per bon: €{amount}'**
  String averageAmountPerReceipt(String amount);

  /// No description provided for @settingsTitle.
  ///
  /// In nl, this message translates to:
  /// **'Instellingen'**
  String get settingsTitle;

  /// No description provided for @receiptExpiringSoon.
  ///
  /// In nl, this message translates to:
  /// **'Bon verloopt binnenkort'**
  String get receiptExpiringSoon;

  /// No description provided for @receiptExpiringChannel.
  ///
  /// In nl, this message translates to:
  /// **'Bon bijna vervallen'**
  String get receiptExpiringChannel;

  /// No description provided for @receiptExpiringChannelDescription.
  ///
  /// In nl, this message translates to:
  /// **'Meldingen voor bonnen die binnenkort vervallen.'**
  String get receiptExpiringChannelDescription;

  /// No description provided for @receiptExpiresIn.
  ///
  /// In nl, this message translates to:
  /// **'Een bon van {storeName} verloopt over {days, plural, =0{0 dagen} =1{1 dag} other{{days} dagen}}.'**
  String receiptExpiresIn(String storeName, int days);

  /// No description provided for @receiptExpired.
  ///
  /// In nl, this message translates to:
  /// **'Bon verlopen'**
  String get receiptExpired;

  /// No description provided for @receiptExpiresOn.
  ///
  /// In nl, this message translates to:
  /// **'Een bon van {storeName} is vandaag verlopen.'**
  String receiptExpiresOn(String storeName);

  /// No description provided for @receiptExpiredChannel.
  ///
  /// In nl, this message translates to:
  /// **'Bon verlopen'**
  String get receiptExpiredChannel;

  /// No description provided for @receiptExpiredChannelDescription.
  ///
  /// In nl, this message translates to:
  /// **'Meldingen voor bonnen die binnenkort vervallen.'**
  String get receiptExpiredChannelDescription;

  /// No description provided for @receiptsTab.
  ///
  /// In nl, this message translates to:
  /// **'Bonnen'**
  String get receiptsTab;

  /// No description provided for @settingsTab.
  ///
  /// In nl, this message translates to:
  /// **'Instellingen'**
  String get settingsTab;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'nl':
      return AppLocalizationsNl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
