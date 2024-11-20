import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/web_vs/screens/home_screen.dart'; // Asegúrate de que esta sea la ruta correcta a tu HomeScreen

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // Variables para controlar el despliegue de las secciones
  bool _showMission = false;
  bool _showVision = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Iniciar la animación de palpitación de manera repetitiva
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menú superior (logo y enlace a inicio)
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
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Text(
                    'Volver a Inicio',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),

            // Cuadrado contenedor con el logo y nombre de la empresa
            Center(
              child: ScaleTransition(
                scale: _animation,
                child: Container(
                  width: 150, // Ancho del cuadrado
                  height: 150, // Alto del cuadrado
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
                      // Logo
                      Image.asset(
                        'assets/logo1.png', // Asegúrate de que la ruta sea correcta
                        width: 100, // Ajusta el tamaño del logo
                        height: 100, // Ajusta el tamaño del logo
                      ),
                      SizedBox(height: 10), // Espacio entre logo y nombre
                      // Nombre de la empresa
                      Text(
                        'VitalityConnect',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Título de la sección "Acerca de Nosotros"
            Center(
              child: Text(
                'Acerca de Nosotros',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Descripción de "Acerca de Nosotros"
            Text(
              'VitalityConnect es una aplicación dedicada a ayudar a los usuarios a realizar un seguimiento de su actividad física y mejorar su salud general. '
              'Con funcionalidades personalizadas, puedes crear rutinas adaptadas a tus necesidades y unirte a una comunidad que te motivará a alcanzar tus objetivos.',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),

            // Fila para Misión y Visión
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botón para "Misión"
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showMission = !_showMission; // Cambiar el estado de despliegue
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Misión',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    _showMission ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                    size: 30,
                                  ),
                                ],
                              ),
                              // Contenido de la misión
                              AnimatedSize(
                                duration: Duration(milliseconds: 300), // Duración de la animación
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxHeight: _showMission ? 100 : 0, // Limita la altura del contenedor
                                  ),
                                  child: AnimatedOpacity(
                                    opacity: _showMission ? 1.0 : 0.0, // Opacidad del texto
                                    duration: Duration(milliseconds: 300), // Duración de la animación de opacidad
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Nuestra misión es empoderar a las personas a llevar un estilo de vida saludable a través de la actividad física, ofreciendo herramientas y recursos que faciliten su progreso y bienestar.',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[700],
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20), // Espacio entre Misión y Visión
                // Botón para "Visión"
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showVision = !_showVision; // Cambiar el estado de despliegue
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Visión',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    _showVision ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                    size: 30,
                                  ),
                                ],
                              ),
                              // Contenido de la visión
                              AnimatedSize(
                                duration: Duration(milliseconds: 300), // Duración de la animación
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxHeight: _showVision ? 100 : 0, // Limita la altura del contenedor
                                  ),
                                  child: AnimatedOpacity(
                                    opacity: _showVision ? 1.0 : 0.0, // Opacidad del texto
                                    duration: Duration(milliseconds: 300), // Duración de la animación de opacidad
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Nuestra visión es ser la aplicación líder en el ámbito del fitness, promoviendo la salud y el bienestar en todo el mundo mediante la tecnología y la comunidad.',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[700],
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
