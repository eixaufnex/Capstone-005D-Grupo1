import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/idioma_provider.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';
// Asegúrate de importar el archivo donde está `IdiomaProvider`

class IdiomaScreen extends StatefulWidget {
  const IdiomaScreen({super.key});

  @override
  _IdiomaScreenState createState() => _IdiomaScreenState();
}

class _IdiomaScreenState extends State<IdiomaScreen> {
  String _selectedLanguage = 'Español';

  final List<Map<String, String>> languages = [
    {'name': 'Español', 'flag': '🇪🇸', 'locale': 'es'},
    {'name': 'Inglés', 'flag': '🇺🇸', 'locale': 'en'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.Email,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
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
            const SizedBox(height: 50),

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
                  final selectedLocale = languages.firstWhere(
                    (lang) => lang['name'] == _selectedLanguage,
                  )['locale'];

                  if (selectedLocale != null) {
                    Provider.of<IdiomaProvider>(context, listen: false)
                        .setLocale(Locale(selectedLocale));

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Idioma $_selectedLanguage seleccionado"),
                      ),
                    );
                  }
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
