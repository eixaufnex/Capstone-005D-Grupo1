import 'package:flutter/material.dart';

import 'package:seguimiento_deportes/web_vs/screens/register_screen.dart';
import 'package:seguimiento_deportes/web_vs/screens/login_screen.dart'; // Asegúrate de importar la pantalla de login
import 'package:seguimiento_deportes/web_vs/screens/aboutUs_screen.dart';// Asegúrate de importar AboutUsScreen
import 'package:seguimiento_deportes/web_vs/screens/faq_screen.dart';  // Asegúrate de importar la pantalla de FAQ




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Repite la animación

    _animation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Efecto de suavizado
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menú superior (logo y enlaces)
            Row(
              children: [
                // Logo en la esquina superior izquierda
                Container(
                  margin: EdgeInsets.only(right: 10), // Espaciado entre logo y texto
                  child: Image.asset(
                    'assets/logo1.png', // Asegúrate de que la ruta sea correcta
                    width: 25, // Ajusta el tamaño del logo
                    height: 25, // Ajusta el tamaño del logo
                  ),
                ),
                Text(
                  'VitalityConnect.',
                  style: TextStyle(
                    fontSize: 15, // Tamaño del texto
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(), // Para empujar el menú a la derecha
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navegar a LoginScreen al hacer clic en "Iniciar sesión"
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        'Iniciar Sesión',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 20),
                    TextButton(
                      onPressed: () {
                        // Navegar a AboutUsScreen al hacer clic en "Sobre Nosotros"
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutUsScreen()),
                        );
                      },
                      child: Text(
                        'Sobre Nosotros',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 20), // Espaciado entre botones
                    TextButton(
                      onPressed: () {
                        // Navegar a FaqScreen al hacer clic en "Preguntas Frecuentes"
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FaqScreen()),
                        );
                      },
                      child: Text(
                        'Preguntas Frecuentes',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 80),

            // Título principal centrado
            Center(
              child: Text(
                '¡Bienvenido A VitalityConnect!\n La mejor aplicación sobre seguimiento de deporte',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Descripción
            Text(
              'En esta aplicación podrás crear y monitorear rutinas tanto personalizadas como recomendadas. '
              'Mediante la ayuda de tecnología que se adapta a tus necesidades, recursos y cambios físicos. '
              'Aficionados al deporte?, únete a una comunidad y comparte tus avances.',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            SizedBox(height: 40),

            // Espacio flexible para empujar el cuadrado hacia el fondo
            Spacer(),

            // Fila que contiene el cuadrado y el contenido a su derecha
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cuadrado contenedor en la parte inferior central con animación
                ScaleTransition(
                  scale: _animation,
                  child: Container(
                    width: 200, // Ancho del cuadrado
                    height: 250, // Alto del cuadrado
                    decoration: BoxDecoration(
                      color: Colors.white, // Color de fondo del cuadrado
                      borderRadius: BorderRadius.circular(15), // Esquinas redondeadas
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Sombra
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // Cambia la posición de la sombra
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Imagen "cora.png"
                        Image.asset(
                          'assets/cora.png', // Asegúrate de que la ruta sea correcta
                          height: 150, // Ajusta el tamaño según sea necesario
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20), // Espacio entre el cuadrado y el contenido a la derecha

                // Contenido a la derecha del cuadrado (botón de descarga e imágenes)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Botón de "Descargar"
                    ElevatedButton(
                      onPressed: () {
                        // Acción al presionar el botón
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Color del botón
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Tamaño más pequeño del botón
                      ),
                      child: Text(
                        'Descargar',
                        style: TextStyle(
                          fontSize: 16, // Tamaño de la fuente ajustado
                          color: Colors.white, // Color del texto cambiado a blanco
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Espacio entre el botón y las imágenes

                    // Fila con imágenes de las tiendas (centradas)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Cambiar a center
                      children: [
                        // Imagen de App Store
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0), // Espaciado entre imágenes
                          child: Image.asset(
                            'assets/app_store_badge.png', // Asegúrate de que la ruta sea correcta
                            width: 100, // Ajusta el tamaño según sea necesario
                            height: 40, // Ajusta el tamaño según sea necesario
                          ),
                        ),
                        // Imagen de Google Play
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0), // Espaciado entre imágenes
                          child: Image.asset(
                            'assets/google_play_badge.png', // Asegúrate de que la ruta sea correcta
                            width: 100, // Ajusta el tamaño según sea necesario
                            height: 40, // Ajusta el tamaño según sea necesario
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
