import 'package:flutter/material.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/settings/widgets/settings_section.dart';
import 'package:statiescan/src/screens/settings/widgets/notification_days_popup.dart';

class NotificationSection extends StatefulWidget {
  const NotificationSection({super.key});

  @override
  State<NotificationSection> createState() => _GeneralSectionState();
}

class _GeneralSectionState extends State<NotificationSection> {
  void _toggleNotifications(bool enabled) {
    setState(() {
      AppSettings.notificationsEnabled.set(enabled);
    });
  }

  int _notificationDays = AppSettings.notificationDaysBeforeExpiry.get();

  void _updateNotificationDays(int days) {
    setState(() {
      _notificationDays = days;
      AppSettings.notificationDaysBeforeExpiry.set(days);
    });
  }

  Future<void> _showNotificationDaysPopup() async {
    final int? selectedDay = await showNotificationDaysPopup(
      context,
      _notificationDays,
    );
    if (selectedDay != null) {
      _updateNotificationDays(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: "Meldingen",
      children: [
        SwitchListTile(
          title: const Text("Meldingen ontvangen"),
          secondary: const Icon(Icons.notifications_active),
          value: AppSettings.notificationsEnabled.get(),
          onChanged: _toggleNotifications,
        ),
        ListTile(
          leading: const Icon(Icons.calendar_month_outlined),
          title: Text(
            'Dagen voor melding bon: $_notificationDays ${_notificationDays == 1 ? "dag" : "dagen"}',
          ),
          onTap: _showNotificationDaysPopup,
        ),
      ],
    );
  }
}
