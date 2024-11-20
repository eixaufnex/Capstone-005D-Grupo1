import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdiomaProvider with ChangeNotifier {
  Locale _locale = const Locale('es'); // Español como idioma predeterminado

  Locale get locale => _locale;

  IdiomaProvider() {
    _loadSavedLocale();
  }

  /// Cambia el idioma y lo guarda en SharedPreferences
  Future<void> cambiarIdioma(String languageCode) async {
    _locale = Locale(languageCode);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', languageCode);
  }

  /// Carga el idioma guardado desde SharedPreferences
  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguageCode = prefs.getString('selectedLanguage') ?? 'es';
    _locale = Locale(savedLanguageCode);
    notifyListeners();
  }
}
