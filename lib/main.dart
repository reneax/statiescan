import 'package:flutter/material.dart';
import 'package:statiescan/src/app.dart';
import 'package:statiescan/src/utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs.init();

  runApp(const StatiescanApp());
}
