import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';

class UnidadesScreen extends StatelessWidget {
  const UnidadesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.unidades,
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
            const SizedBox(height: 60),
            const Text(
              "!Ajusta las Unidades según tus preferencias!",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),
            // Lista de opciones 
            _buildUnidadesOption("Peso"),
            _buildUnidadesOption("Distancia"),
            _buildUnidadesOption("Temporizador"),
            _buildUnidadesOption("¿Alguna otra cosa?"),
            const SizedBox(height: 200), // Espacio antes del botón
            
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
                    SnackBar(content: Text("Unidades aplicadas")),
                  );
                },
                child: const Text("Aplicar", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 50), // Espacio después del botón
          ],
        ),
      ),
    );
  }

  Widget _buildUnidadesOption(String title) {
    String unidad;
    
    if (title == "Peso") {
      unidad = "kg/lbs";
    } else if (title == "Distancia") {
      unidad = "km/ml";
    } else if (title == "Temporizador") {
      unidad = "Si/No";
    } else {
      unidad = "No se";
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            Text(unidad, style: const TextStyle(fontSize: 16)), 
          ],
        ),
        const Divider(),
      ],
    );
  }
}
