import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    const androidInit = AndroidInitializationSettings(
      '@drawable/ic_stat_notifications',
    );
    const initSettings = InitializationSettings(android: androidInit);
    _notificationsPlugin.initialize(initSettings);

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Amsterdam'));
  }

  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  Future<void> scheduleReceipts(
    List<Receipt> receipts,
    List<Store> stores,
  ) async {
    for (final receipt in receipts) {
      final store =
          stores.where((store) => store.id == receipt.storeId).firstOrNull;

      if (store == null) continue;

      await scheduleReceiptExpiryNotification(receipt, store);
    }
  }

  Future<void> cancelNotificationsForReceipt(int receiptId) async {
    await _notificationsPlugin.cancel(receiptId);
    await _notificationsPlugin.cancel(receiptId + 100000);
  }

  Future<void> requestPermission() async {
    await _getAndroidImplementation()?.requestNotificationsPermission();
  }

  AndroidFlutterLocalNotificationsPlugin? _getAndroidImplementation() {
    return _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
  }

  Future<bool> isNotificationsAllowed() async {
    return await _getAndroidImplementation()?.areNotificationsEnabled() ??
        false;
  }

  Future<void> scheduleReceiptExpiryNotification(
    Receipt receipt,
    Store store,
  ) async {
    final expiryDate = receipt.expiresAt;

    if (expiryDate == null) {
      return;
    }

    final storeName = store.name;
    final int daysBefore = AppSettings.notificationDaysBeforeExpiry.get();
    final Duration daysBeforeDuration = Duration(days: daysBefore);
    final DateTime receiptReminderDateTime = expiryDate.subtract(
      daysBeforeDuration,
    );
    final tz.TZDateTime receiptReminder = tz.TZDateTime.from(
      receiptReminderDateTime,
      tz.local,
    );

    await _notificationsPlugin.zonedSchedule(
      receipt.id,
      'Bon verloopt binnenkort',
      'Een bon van $storeName verloopt over $daysBefore ${daysBefore == 1 ? 'dag' : 'dagen'}.',
      receiptReminder,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'receipt_expiry_channel_soon',
          'Bon bijna vervallen',
          channelDescription: 'Meldingen voor bonnen die binnenkort vervallen.',
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'Bon verloopt binnenkort',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );

    final tz.TZDateTime expiryTime = tz.TZDateTime.from(expiryDate, tz.local);

    await _notificationsPlugin.zonedSchedule(
      receipt.id + 100000,
      'Bon verlopen',
      'Een bon van $storeName is vandaag verlopen.',
      expiryTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'receipt_expired_channel_today',
          'Bon verlopen',
          channelDescription: 'Meldingen voor bonnen die vandaag verlopen.',
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
