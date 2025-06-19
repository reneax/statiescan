import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
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
    BuildContext context,
    List<Receipt> receipts,
    List<Store> stores,
  ) async {
    for (final receipt in receipts) {
      final store =
          stores.where((store) => store.id == receipt.storeId).firstOrNull;

      if (store == null) continue;

      await scheduleReceiptExpiryNotification(context, receipt, store);
    }
  }

  Future<void> cancelNotificationsForReceipt(int receiptId) async {
    await _notificationsPlugin.cancel(receiptId);
    await _notificationsPlugin.cancel(receiptId + 100000);
  }

  Future<bool?> requestPermission() async {
    return await _getAndroidImplementation()?.requestNotificationsPermission();
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
    BuildContext context,
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
      AppLocalizations.of(context)!.receiptExpiringSoon,
      AppLocalizations.of(context)!.receiptExpiresIn(storeName, daysBefore),
      receiptReminder,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'receipt_expiry_channel_soon',
          AppLocalizations.of(context)!.receiptExpiringChannel,
          channelDescription:
              AppLocalizations.of(context)!.receiptExpiringChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );

    final tz.TZDateTime expiryTime = tz.TZDateTime.from(expiryDate, tz.local);

    if (!context.mounted) return;

    await _notificationsPlugin.zonedSchedule(
      receipt.id + 100000,
      AppLocalizations.of(context)!.receiptExpired,
      AppLocalizations.of(context)!.receiptExpiresOn(storeName),
      expiryTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'receipt_expired_channel_today',
          AppLocalizations.of(context)!.receiptExpiredChannel,
          channelDescription:
              AppLocalizations.of(context)!.receiptExpiredChannelDescription,
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
