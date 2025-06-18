import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';

Future<int?> showNotificationDaysPopup(
  BuildContext context,
  int selectedDay,
) async {
  return showDialog<int>(
    context: context,
    builder: (context) {
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
    },
  );
}
