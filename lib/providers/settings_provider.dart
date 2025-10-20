import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _darkMode = false;
  double _fontScale = 1.0;

  bool get darkMode => _darkMode;
  double get fontScale => _fontScale;

  void toggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }

  void setFontScale(double scale) {
    _fontScale = scale.clamp(0.8, 1.6);
    notifyListeners();
  }
}
