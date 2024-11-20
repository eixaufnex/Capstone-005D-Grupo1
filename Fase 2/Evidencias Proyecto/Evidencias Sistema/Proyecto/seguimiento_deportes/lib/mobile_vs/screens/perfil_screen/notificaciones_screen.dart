import 'package:flutter/material.dart';

class NotificacionesScreen extends StatelessWidget {
  const NotificacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
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
              "Seleccione las notificaciones que desee recibir en su teléfono, recuerde que antes tiene que aceptar los permisos",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),
            
            // Lista de opciones de notificación
            _buildNotificationOption("Mensajes motivacionales"),
            _buildNotificationOption("Recordatorios"),
            _buildNotificationOption("Temporizador"),
            _buildNotificationOption("Ayuda"),
            const SizedBox(height: 142), // Espacio antes del botón
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

  Widget _buildNotificationOption(String title) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            const Text("Sí/No", style: TextStyle(fontSize: 16)),
          ],
        ),
        const Divider(),
      ],
    );
  }
}