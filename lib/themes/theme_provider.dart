
import package:flutter/material.dart';
import 'Aladin/themes/light_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}

void toggleTheme() {
  if (_themeData == lightMode) {
    _themeData = darkMode;
  } else {
    _themeData = lightMode;
  }
  notifyListeners();
}

