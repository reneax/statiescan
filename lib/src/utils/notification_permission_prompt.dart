import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statiescan/src/utils/notification_service.dart';

class NotificationPermissionPrompt extends StatefulWidget {
  const NotificationPermissionPrompt({super.key});

  @override
  State<NotificationPermissionPrompt> createState() =>
      _NotificationPermissionPromptState();
}

class _NotificationPermissionPromptState
    extends State<NotificationPermissionPrompt> {
  @override
  void initState() {
    super.initState();
    _notificationPermission();
  }

  Future<void> _notificationPermission() async {
    final prefs = await SharedPreferences.getInstance();
    final hasAsked = prefs.getBool('hasAskedNotificationPermission') ?? false;

    if (!hasAsked) {
      await NotificationService().requestPermission();

      if (mounted) {
        await prefs.setBool('hasAskedNotificationPermission', true);
      }
    }
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
