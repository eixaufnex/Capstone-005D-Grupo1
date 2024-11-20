import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/web_vs/screens/home_screen.dart'; // Asegúrate de importar la pantalla de inicio

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> with SingleTickerProviderStateMixin {
  // Lista de preguntas y respuestas
  final List<Map<String, String>> faqList = [
    {
      "question": "¿Qué es VitalityConnect?",
      "answer": "VitalityConnect es una aplicación diseñada para ayudarte a crear y monitorear rutinas de ejercicio."
    },
    {
      "question": "¿Cómo puedo registrarme?",
      "answer": "Puedes registrarte fácilmente desde la pantalla de inicio haciendo clic en 'Iniciar sesión'."
    },
    {
      "question": "¿Es gratuita la aplicación?",
      "answer": "Sí, VitalityConnect es completamente gratuita, aunque puede ofrecer funciones premium."
    },
    {
      "question": "¿Puedo personalizar mis rutinas?",
      "answer": "Sí, la aplicación permite crear rutinas personalizadas adaptadas a tus necesidades."
    },
  ];

  // Lista para controlar el estado de expansión de cada pregunta
  List<bool> expanded = [];
  TextEditingController _consultaController = TextEditingController(); // Controlador para el campo de texto
  late AnimationController _animationController; // Controlador de animación
  late Animation<double> _animation; // Animación de pulso

  @override
  void initState() {
    super.initState();
    expanded = List.generate(faqList.length, (_) => false);
    
    // Inicializar el controlador de animación
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(_animationController);
  }

  void toggleExpansion(int index) {
    setState(() {
      expanded[index] = !expanded[index];
    });
  }

  void showConsultaDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Escribe tu consulta'),
          content: Container(
            width: double.maxFinite,
            child: TextField(
              controller: _consultaController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Escribe aquí tu consulta...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para enviar la consulta
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text('Enviar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose(); // Limpiar el controlador de animación
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Eliminar la flecha de back
        title: Row(
          children: [
            // Logo en la esquina superior izquierda
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Image.asset(
                'assets/logo1.png',
                width: 25,
                height: 25,
              ),
            ),
            Text(
              'VitalityConnect.',
              style: TextStyle(
                fontSize: 15, // Tamaño de la letra ajustado
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(), // Para empujar el botón a la derecha
            TextButton(
              onPressed: () {
                // Navegar de vuelta a la pantalla de inicio
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text(
                'Volver a Inicio',
                style: TextStyle(
                  fontSize: 18, // Tamaño del texto del botón
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            // Título de preguntas frecuentes subrayado
            Center(
              child: Column(
                children: [
                  Text(
                    'Preguntas Frecuentes',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    height: 2,
                    width: 150,
                    color: Colors.black, // Color del subrayado
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Espacio entre el título y la lista de preguntas
            Expanded(
              child: ListView.builder(
                itemCount: faqList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            faqList[index]["question"]!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () => toggleExpansion(index),
                        ),
                        AnimatedSize(
                          duration: Duration(milliseconds: 300), // Duración de la animación
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: expanded[index] ? 100 : 0, // Limita la altura del contenedor
                            ),
                            child: AnimatedOpacity(
                              opacity: expanded[index] ? 1.0 : 0.0, // Opacidad del texto
                              duration: Duration(milliseconds: 300), // Duración de la animación de opacidad
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(faqList[index]["answer"]!),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Mensaje de contacto y botón para abrir el cuadro de consulta
            Container(
              margin: const EdgeInsets.only(top: 20.0), // Espacio superior
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Color de la sombra
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Desplazamiento de la sombra
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'No dudes en contactarnos para aclarar dudas y/o consultas',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10), // Espacio entre el mensaje y el botón
                  ScaleTransition(
                    scale: _animation,
                    child: ElevatedButton(
                      onPressed: showConsultaDialog,
                      child: Text('Redactar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
