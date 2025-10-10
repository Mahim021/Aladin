import 'package:flutter/material.dart';
import 'package:grocery_shop/themes/light_mode.dart';
import 'package:grocery_shop/themes/dark_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData getTheme() => _themeData;

  // ✅ Add this getter
  bool get isDarkMode => _themeData == darkMode;

  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }
}
