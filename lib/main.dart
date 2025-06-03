import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:statiescan/src/app.dart';
import 'package:statiescan/src/utils/notification_service.dart';
import 'package:statiescan/src/utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await SharedPrefs.init();
  await NotificationService().init();

  runApp(const StatiescanApp());
}
