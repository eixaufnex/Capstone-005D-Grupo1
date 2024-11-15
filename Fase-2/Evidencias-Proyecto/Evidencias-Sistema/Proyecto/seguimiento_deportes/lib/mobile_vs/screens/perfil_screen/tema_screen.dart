import 'package:flutter/material.dart';

class TemaScreen extends StatefulWidget {
  const TemaScreen({super.key});

  @override
  _TemaScreenState createState() => _TemaScreenState();
}

class _TemaScreenState extends State<TemaScreen> {
  String _selectedTheme = 'Claro';

  void _applyTheme() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Tema '$_selectedTheme' aplicado")),
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
          fontWeight:
              _selectedTheme == theme ? FontWeight.bold : FontWeight.normal,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tema', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'perfil');
          },
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: [
            SizedBox(height: 60),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tema',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),


            SizedBox(height: 40),
            _buildThemeOption('Claro', Icons.wb_sunny),
            _buildThemeOption('Oscuro', Icons.nights_stay),
            _buildThemeOption('Defecto del Sistema', Icons.settings),


            SizedBox(height: 268), // Separación del boton
            ElevatedButton(
              onPressed: _applyTheme,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Text("Aplicar", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}