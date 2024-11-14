import 'package:flutter/material.dart';

class IdiomaScreen extends StatefulWidget {
  const IdiomaScreen({super.key});

  @override
  _IdiomaScreenState createState() => _IdiomaScreenState();
}

class _IdiomaScreenState extends State<IdiomaScreen> {
  String _selectedLanguage = 'Chileno';

  final List<Map<String, String>> languages = [
    {'name': 'Chileno', 'flag': '🇨🇱'},
    {'name': 'Español', 'flag': '🇪🇸'},
    {'name': 'Inglés', 'flag': '🇺🇸'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Idioma', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // Lista de idiomas
            Expanded(
              child: ListView(
                children: languages.map((language) {
                  return ListTile(
                    leading: Text(
                      language['flag']!,
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(language['name']!),
                    trailing: _selectedLanguage == language['name']
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              "Seleccionado",
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          )
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedLanguage = language['name']!;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 50),
            // Botón de aplicar
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  // Acción al presionar "Aplicar"
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Idioma $_selectedLanguage seleccionado")),
                  );
                },
                child: const Text("Aplicar", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 88),
          ],
        ),
      ),
    );
  }
}
