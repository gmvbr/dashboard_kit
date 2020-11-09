import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final _themeDarkModeKey = "__theme__dark";
  final SharedPreferences preferences;

  bool _themeDarkMode = false;

  ThemeProvider({this.preferences}) {
    if (preferences.containsKey(_themeDarkModeKey)) {
      this._themeDarkMode = preferences.getBool(_themeDarkModeKey);
    }
  }

  ThemeMode getThemeMode() {
    if (_themeDarkMode == true) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  setThemeDark(bool dark) async {
    await preferences.setBool(_themeDarkModeKey, dark);
    _themeDarkMode = dark;
    notifyListeners();
  }
}
