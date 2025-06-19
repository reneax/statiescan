import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/settings/widgets/notification_days_dialog.dart';
import 'package:statiescan/src/screens/settings/widgets/settings_section.dart';
import 'package:statiescan/src/services/notification_service.dart';
import 'package:statiescan/src/utils/snackbar_creator.dart';

class NotificationSection extends StatefulWidget {
  const NotificationSection({super.key});

  @override
  State<NotificationSection> createState() => _GeneralSectionState();
}

class _GeneralSectionState extends State<NotificationSection> {
  void _toggleNotifications(bool enabled) async {
    final notificationService = context.read<NotificationService>();

    final isNotificationsAllowed =
        await notificationService.isNotificationsAllowed();

    if (!isNotificationsAllowed && enabled) {
      final isAllowedAfterRequest =
          await notificationService.requestPermission();

      enabled = isAllowedAfterRequest ?? false;

      if (!enabled && mounted) {
        SnackbarCreator.show(
          context,
          message:
              AppLocalizations.of(context)!.errorNotificationPermissionDenied,
          status: SnackbarStatus.error,
          duration: Duration(seconds: 5),
        );
      }
    }

    if (!mounted) return;

    if (enabled) {
      _rescheduleNotifications(notificationService);
    } else {
      _cancelNotifications(notificationService);
    }

    setState(() {
      AppSettings.notificationsEnabled.set(enabled);
    });
  }

  Future<void> _rescheduleNotifications(
    NotificationService notificationService,
  ) async {
    final database = context.read<AppDatabase>();

    final receipts = await database.select(database.receipts).get();
    final stores = await database.select(database.stores).get();

    if (mounted) {
      await notificationService.scheduleReceipts(context, receipts, stores);
    }
  }

  Future<void> _cancelNotifications(
    NotificationService notificationService,
  ) async {
    await notificationService.cancelAllNotifications();
  }

  void _updateNotificationDays(int days) async {
    final notificationService = context.read<NotificationService>();

    final isNotificationsAllowed =
        await notificationService.isNotificationsAllowed();

    if (AppSettings.notificationsEnabled.get() && isNotificationsAllowed) {
      await _cancelNotifications(notificationService);
      await _rescheduleNotifications(notificationService);
    }

    setState(() {
      AppSettings.notificationDaysBeforeExpiry.set(days);
    });
  }

  Future<void> _showNotificationDaysPopup() async {
    final int? selectedDay = await showDialog(
      context: context,
      builder:
          (context) => NotificationDaysDialog(
            selectedDay: AppSettings.notificationDaysBeforeExpiry.get(),
          ),
    );

    if (selectedDay != null) {
      _updateNotificationDays(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: AppLocalizations.of(context)!.notificationSection,
      children: [
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.notificationsEnabledOption),
          secondary: const Icon(Icons.notifications_active),
          value: AppSettings.notificationsEnabled.get(),
          onChanged: _toggleNotifications,
        ),
        ListTile(
          leading: const Icon(Icons.calendar_month_outlined),
          title: Text(AppLocalizations.of(context)!.daysBeforeExpiryOption),
          subtitle: Text(
            AppLocalizations.of(context)!.daysBeforeExpiryDescription,
          ),
          onTap: _showNotificationDaysPopup,
        ),
      ],
    );
  }
}
