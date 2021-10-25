import 'package:flutter/material.dart';

class AppThemeModel extends ChangeNotifier {
  ///current index of the bottom nav-bar
  bool _lightAppTheme = true;
  bool get lightAppTheme => _lightAppTheme;

  ///updates the current index of the bottom nav
  switchAppTheme(int index) {
    _lightAppTheme = !_lightAppTheme;
    notifyListeners();
  }
}
