import 'package:flutter/material.dart';

class UIState with ChangeNotifier {
  Widget? _floatingActionButton;

  Widget? get floatingActionButton => _floatingActionButton;

  void setState(Widget? floatingActionButton) {
    _floatingActionButton = floatingActionButton;
    notifyListeners();
  }
}
