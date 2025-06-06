import 'package:flutter/material.dart';

Future<int?> showNotificationDaysPopup(
  BuildContext context,
  int selectedDay,
) async {
  return showDialog<int>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Dagen voor melding bon'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              List.generate(3, (index) => index + 1).map((day) {
                return ListTile(
                  title: Text('$day ${day == 1 ? "dag" : "dagen"}'),
                  selected: day == selectedDay,
                  onTap: () {
                    Navigator.of(context).pop(day);
                  },
                );
              }).toList(),
        ),
      );
    },
  );
}
