import 'package:flutter/material.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/settings/widgets/settings_section.dart';
import 'package:vibration/vibration.dart';

class GeneralSection extends StatefulWidget {
  const GeneralSection({super.key});

  @override
  State<GeneralSection> createState() => _GeneralSectionState();
}

class _GeneralSectionState extends State<GeneralSection> {
  void _toggleVibration(bool enabled) {
    setState(() {
      AppSettings.vibrationEnabled.set(enabled);
    });

    if (enabled) {
      Vibration.vibrate(duration: 100);
    }
  }

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

  void _toggleGoToNext(bool enabled) {
    setState(() {
      AppSettings.goToNextWhenDeleted.set(enabled);

    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: "Algemeen",
      children: [
        SwitchListTile(
          title: const Text("Trillen bij acties"),
          secondary: const Icon(Icons.vibration),
          value: AppSettings.vibrationEnabled.get(),
          onChanged: _toggleVibration,
        ),
        SwitchListTile(
          title: const Text("Meldingen ontvangen"),
          secondary: const Icon(Icons.notifications_active),
          value: AppSettings.notificationsEnabled.get(),
          onChanged: _toggleNotifications,
        ),
        DropdownButtonFormField<int>(
          value: _notificationDays,
          decoration: const InputDecoration(
            labelText: 'Dagen voor melding bon',
            prefixIcon: Icon(Icons.event_note),
          ),
          items:
              List.generate(10, (index) => index + 1)
                  .map(
                    (day) => DropdownMenuItem(
                      value: day,
                      child: Text('$day ${day == 1 ? "dag" : "dagen"}'),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            if (value != null) _updateNotificationDays(value);
          },
          title: const Text("Volgende bon na verwijderen"),
          subtitle: const Text(
            "Ga na het verwijderen naar de volgende bon van de supermarkt.",
          ),
          secondary: const Icon(Icons.double_arrow),
          value: AppSettings.goToNextWhenDeleted.get(),
          onChanged: _toggleGoToNext,
        ),
      ],
    );
  }
}
