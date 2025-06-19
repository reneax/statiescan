import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';

class NotificationDaysDialog extends StatelessWidget {
  final int selectedDay;

  const NotificationDaysDialog({super.key, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.daysBeforeNotificationTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            List.generate(3, (index) => index + 1).map((dayCount) {
              return ListTile(
                title: Text(
                  AppLocalizations.of(context)!.notificationDays(dayCount),
                ),
                selected: dayCount == selectedDay,
                onTap: () {
                  Navigator.of(context).pop(dayCount);
                },
              );
            }).toList(),
      ),
    );
  }
}
