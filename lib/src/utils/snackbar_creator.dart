import 'package:flutter/material.dart';

enum SnackbarStatus { success, error, warning, info }

class SnackbarCreator {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarStatus status = SnackbarStatus.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final colorScheme = _getColorAndIcon(status);

    final snackBar = SnackBar(
      content: Row(
        spacing: 10,
        children: [
          Icon(colorScheme['icon'] as IconData, color: Colors.white),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: colorScheme['color'] as Color,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      duration: duration,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }

  static Map<String, dynamic> _getColorAndIcon(SnackbarStatus status) {
    switch (status) {
      case SnackbarStatus.success:
        return {'color': Colors.green, 'icon': Icons.check_circle_outline};
      case SnackbarStatus.error:
        return {'color': Colors.red, 'icon': Icons.error_outline};
      case SnackbarStatus.warning:
        return {'color': Colors.orange, 'icon': Icons.warning_amber_outlined};
      case SnackbarStatus.info:
        return {'color': Colors.blue, 'icon': Icons.info_outline};
    }
  }
}
