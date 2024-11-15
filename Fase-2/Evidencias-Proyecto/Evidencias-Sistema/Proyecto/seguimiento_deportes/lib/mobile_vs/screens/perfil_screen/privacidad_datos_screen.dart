import 'package:flutter/material.dart';

class PrivacidadDatosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'perfil');
          },
        ),
        title: Text(
          'Privacidad de datos',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[900]),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Fondo con íconos translúcidos
          Positioned(
            top: 80,
            left: 20,
            child: Icon(Icons.fitness_center,
                color: Colors.grey[300]!.withOpacity(0.2), size: 100),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: Icon(Icons.accessibility_new,
                color: Colors.grey[300]!.withOpacity(0.2), size: 120),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[100]!,
                  Colors.grey[200]!,
                  Colors.grey[300]!,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: kToolbarHeight + 60), // Espacio adicional ajustado
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 600,
                    ),
                    child: SingleChildScrollView(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                            TextSpan(text: '1. Introducción\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'En nuestra aplicación, protegemos los datos personales de nuestros usuarios en cumplimiento de la Ley N°19.628 sobre Protección de la Vida Privada. Esta política describe cómo recopilamos, usamos y protegemos la información personal, además de asegurar el consentimiento informado del usuario para promover una mayor conciencia sobre la protección de su privacidad.\n\n'),
                            
                            TextSpan(text: '2. Contexto: Ley N°19.628\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Esta ley garantiza los derechos de acceso, rectificación y eliminación de datos personales y prohíbe el uso de estos sin el consentimiento del titular, salvo en casos específicos. Asimismo, establece la obligación de adoptar medidas de seguridad adecuadas para proteger los datos y de informar sobre el propósito de su recolección.\n\n'),

                            TextSpan(text: '3. Cumplimiento Legal y Normativo\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Para asegurar el cumplimiento de la Ley N°19.628 en nuestra aplicación móvil y web, aplicamos las siguientes medidas:\n\n'),
                            TextSpan(text: '- Identificación de datos personales: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Solicitamos únicamente los datos necesarios para el funcionamiento de la aplicación.\n'),
                            TextSpan(text: '- Política de privacidad accesible: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Explicamos claramente el propósito y uso de los datos recopilados.\n'),
                            TextSpan(text: '- Consentimiento informado: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Obtenemos el consentimiento claro y comprensible del usuario antes de recopilar sus datos.\n'),
                            TextSpan(text: '- Derechos del usuario: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Ofrecemos opciones para que los usuarios accedan, rectifiquen o eliminen sus datos en cualquier momento.\n'),
                            TextSpan(text: '- Medidas de seguridad: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Protegemos la información mediante cifrado, autenticación y protocolos seguros de transmisión.\n'),
                            TextSpan(text: '- Capacitación del equipo: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Garantizamos que nuestro equipo esté capacitado en el manejo seguro de datos.\n'),
                            TextSpan(text: '- Transparencia: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Informamos a los usuarios sobre cualquier cambio en el manejo de sus datos.\n\n'),

                            TextSpan(text: '4. Datos Solicitados\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Recopilamos los siguientes tipos de datos personales para personalizar la experiencia de los usuarios:\n\n'),
                            TextSpan(text: '- Identificación: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Nombre, correo electrónico y número de teléfono (opcional).\n'),
                            TextSpan(text: '- Salud y Fitness: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Edad, género, peso, altura, objetivos fitness y nivel de actividad.\n'),
                            TextSpan(text: '- Preferencias de Ejercicio: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Tipos de ejercicio preferidos y frecuencia de entrenamiento.\n'),
                            TextSpan(text: '- Progreso: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Registro de entrenamiento (ejercicios, duración e intensidad) y medidas corporales.\n'),
                            TextSpan(text: '- Notificaciones: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Preferencias de comunicación para recordatorios y mensajes motivacionales.\n\n'),

                            TextSpan(text: '5. Confidencialidad y Uso de los Datos\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'Toda la información recopilada se trata con estricta confidencialidad y se utiliza exclusivamente para los fines de mejorar la experiencia en la aplicación. Los datos están protegidos de acuerdo con las normativas legales vigentes.\n\n'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Texto VitalityConnect en la parte inferior
                  Text(
                    "VitalityConnect",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}