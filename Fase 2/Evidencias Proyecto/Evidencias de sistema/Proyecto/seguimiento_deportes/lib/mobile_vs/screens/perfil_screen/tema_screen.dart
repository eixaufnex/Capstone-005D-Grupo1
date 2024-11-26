import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';

class TemaScreen extends StatefulWidget {
  const TemaScreen({super.key});

  @override
  _TemaScreenState createState() => _TemaScreenState();
}

class _TemaScreenState extends State<TemaScreen> {
  String _selectedTheme = S.current.Claro;
  ThemeData _currentTheme = ThemeData.light();

  @override
  void initState() {
    super.initState();
    _loadTheme(); // Cargar el tema almacenado
  }

  // Carga el tema almacenado en SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('selectedTheme') ?? S.current.Claro;

    setState(() {
      _selectedTheme = theme;
      _currentTheme = _getThemeData(theme);
    });
  }

  // Almacena el tema seleccionado en SharedPreferences
  Future<void> _saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedTheme', theme);
  }

  // Devuelve el ThemeData según el tema seleccionado
  ThemeData _getThemeData(String theme) {
    if (theme == S.current.Oscuro) {
      return ThemeData.dark();
    }
    return ThemeData.light();
  }

  void _applyTheme() {
    setState(() {
      _currentTheme = _getThemeData(_selectedTheme);
      _saveTheme(_selectedTheme); // Guarda el tema seleccionado
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${S.current.tema} '$_selectedTheme' ${S.current.aplicado}")),
    );
  }

  Widget _buildThemeOption(String theme, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: _selectedTheme == theme ? Colors.black : Colors.grey,
      ),
      title: Text(
        theme,
        style: TextStyle(
          color: _selectedTheme == theme ? Colors.black : Colors.grey,
          fontWeight: _selectedTheme == theme ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        setState(() {
          _selectedTheme = theme;
        });
      },
      tileColor: _selectedTheme == theme ? Colors.greenAccent.shade100 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _currentTheme, // Aplica el tema solo a este screen
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.current.tema,
            style: TextStyle(
              color: _currentTheme.brightness == Brightness.dark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'perfil');
            },
            color: _currentTheme.brightness == Brightness.dark ? Colors.white : Colors.black,
          ),
          backgroundColor: _currentTheme.brightness == Brightness.dark ? Colors.grey[900] : Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.current.tema,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _currentTheme.brightness == Brightness.dark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _buildThemeOption(S.current.Claro, Icons.wb_sunny),
              _buildThemeOption(S.current.Oscuro, Icons.nights_stay),
              const SizedBox(height: 268), // Separación del botón
              ElevatedButton(
                onPressed: _applyTheme,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(S.current.apply, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
