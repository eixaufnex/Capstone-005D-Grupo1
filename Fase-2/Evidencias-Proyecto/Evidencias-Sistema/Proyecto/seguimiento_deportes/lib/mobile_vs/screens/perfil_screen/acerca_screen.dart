import 'package:flutter/material.dart';

class AcercaScreen extends StatefulWidget {
  const AcercaScreen({super.key});

  @override
  State<AcercaScreen> createState() => _AcercaScreenState();
}

class _AcercaScreenState extends State<AcercaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VitalityConnect',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.grey[900]),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'perfil');
          },
          color: Colors.black,
        ),
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
            padding: EdgeInsets.symmetric(horizontal: 20),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: kToolbarHeight + 80), // Ajuste de espacio

                // Descripción introductoria
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Explora cómo VitalityConnect puede ayudarte a mejorar tu bienestar físico y mental. Descubre nuestra misión y visión para inspirarte a alcanzar tus objetivos.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      _buildExpansionTile(
                        icon: Icons.info_outline,
                        title: '¿Qué es VitalityConnect?',
                        content:
                            'VitalityConnect es una aplicación dedicada a ayudar a los usuarios a realizar un seguimiento de su actividad física y mejorar su salud general. Con funcionalidades personalizadas, puedes crear rutinas adaptadas a tus necesidades y unirte a una comunidad que te motivará a alcanzar tus objetivos.',
                      ),
                      _buildExpansionTile(
                        icon: Icons.flag_outlined,
                        title: 'Nuestra Misión',
                        content:
                            'Nuestra misión es empoderar a las personas a llevar un estilo de vida saludable a través de la actividad física, ofreciendo herramientas y recursos que faciliten su progreso y bienestar.',
                      ),
                      _buildExpansionTile(
                        icon: Icons.visibility_outlined,
                        title: 'Nuestra Visión',
                        content:
                            'Nuestra visión es ser la aplicación líder en el ámbito del fitness, promoviendo la salud y el bienestar en todo el mundo mediante la tecnología y la comunidad.',
                      ),
                    ],
                  ),
                ),
                
                // Contenedor sombreado que cubre toda la parte inferior de la pantalla
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 40,
                        spreadRadius: 20,
                        offset: Offset(0, -10), // Sombra hacia arriba
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo en el centro del contenedor con sombra difusa
                      Image.asset(
                        'assets/logo.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile(
      {required IconData icon, required String title, required String content}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(icon, color: Colors.grey[700], size: 30),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          iconColor: Colors.grey[600],
          collapsedIconColor: Colors.grey[600],
          children: [
            Divider(color: Colors.grey[300], thickness: 0.8, indent: 16, endIndent: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}