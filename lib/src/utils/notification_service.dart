import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:statiescan/src/database/app_database.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late final AppDatabase _database;

  NotificationService._internal() {
    _database = AppDatabase();
  }

  Future<void> cancelNotificationsForReceipt(int receiptId) async {
    await _notificationsPlugin.cancel(receiptId);
    await _notificationsPlugin.cancel(receiptId + 100000);
  }

  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _notificationsPlugin.initialize(initSettings);

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Amsterdam'));
  }

  Future<void> requestPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    await androidImplementation?.requestNotificationsPermission();
  }

  Future<String> _getStoreNameFromDb(int? storeId) async {
    if (storeId == null) {
      return "onbekende winkel";
    }

    final Store? store =
        await (_database.select(_database.stores)
          ..where((s) => s.id.equals(storeId))).getSingleOrNull();

    if (store != null) {
      return store.name;
    } else {
      return "winkel (ID: $storeId)";
    }
  }

  Future<void> scheduleReceiptExpiryNotification(Receipt receipt) async {
    if (receipt.expiresAt == null) {
      return;
    }

    final now = DateTime.now();
    final expiry = receipt.expiresAt!;

    if (expiry.isBefore(now)) {
      return;
    }

    final String storeName = await _getStoreNameFromDb(receipt.storeId);

    final Duration threeDays = const Duration(days: 3);
    final DateTime scheduledNotificationDateTime = expiry.subtract(threeDays);
    final tz.TZDateTime receiptReminder;

    if (scheduledNotificationDateTime.isAfter(now)) {
      receiptReminder = tz.TZDateTime.from(
        scheduledNotificationDateTime,
        tz.local,
      );
    } else {
      receiptReminder = tz.TZDateTime.from(
        now.add(const Duration(seconds: 10)),
        tz.local,
      );
    }

    await _notificationsPlugin.zonedSchedule(
      receipt.id,
      'Bon verloopt binnenkort',
      'Een bon van $storeName verloopt over 3 dagen.',
      receiptReminder,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'receipt_expiry_channel_soon',
          'Bon Bijna Vervallen Meldingen',
          channelDescription: 'Meldingen voor bonnen die binnenkort vervallen.',
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'Bon verloopt binnenkort',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );

    final tz.TZDateTime expiryTime = tz.TZDateTime.from(expiry, tz.local);

    await _notificationsPlugin.zonedSchedule(
      receipt.id + 100000,
      'Bon verlopen',
      'Een bon van $storeName is vandaag verlopen.',
      expiryTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'receipt_expired_channel_today',
          'Bon Verlopen Meldingen',
          channelDescription: 'Meldingen voor bonnen die vandaag vervallen.',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          ticker: 'Bon verlopen',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
