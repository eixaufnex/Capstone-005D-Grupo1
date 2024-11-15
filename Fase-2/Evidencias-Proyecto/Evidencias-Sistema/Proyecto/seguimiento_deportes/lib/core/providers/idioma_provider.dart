import 'package:flutter/material.dart';

class IdiomaProvider extends ChangeNotifier {
  Locale? _locale; // Cambia a nullable con `Locale?`

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
