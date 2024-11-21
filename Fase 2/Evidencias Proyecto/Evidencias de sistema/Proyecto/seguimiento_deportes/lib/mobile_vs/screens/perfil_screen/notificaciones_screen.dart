import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';

class NotificacionesScreen extends StatelessWidget {
  const NotificacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.notificaciones, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
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
            Text(
              S.current.notificaciones1,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),
            
            // Lista de opciones de notificación
            _buildNotificationOption(S.current.notificaciones2),
            _buildNotificationOption(S.current.notificaciones3),
            _buildNotificationOption(S.current.notificaciones4),
            _buildNotificationOption(S.current.notificaciones5),
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
                    SnackBar(content: Text(S.current.notificaciones6)),
                  );
                },
                child: Text(S.current.apply, style: const TextStyle(color: Colors.white)),
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