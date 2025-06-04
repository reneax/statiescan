import 'package:flutter/material.dart';

class UIStateProvider with ChangeNotifier {
  Widget? _floatingActionButton;

  Widget? get floatingActionButton => _floatingActionButton;

  void setState(Widget? floatingActionButton) {
    _floatingActionButton = floatingActionButton;
    notifyListeners();
  }
}
