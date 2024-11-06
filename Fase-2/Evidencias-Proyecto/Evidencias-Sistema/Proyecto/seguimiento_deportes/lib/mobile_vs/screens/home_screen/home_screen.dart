import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Importa la biblioteca intl
import 'package:seguimiento_deportes/mobile_vs/screens/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/perfil_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/3_anadir_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/1_rutinas_screen.dart';
import 'package:seguimiento_deportes/core/providers/notificacion_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String usuario = "Cargando..."; // Texto inicial mientras se carga el usuario
  String fechaActual = ''; // Nueva variable para la fecha actual
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
    _setFechaActual(); // Llama a la función para establecer la fecha
  }

  void _setFechaActual() {
    // Obtener la fecha actual
    fechaActual = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }


  Future<void> _fetchUsername() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String username = await Provider.of<Usuario_provider>(context, listen: false)
      
          .getUsername(user.uid);
      setState(() {
        usuario = username; // Actualiza el nombre de usuario en la interfaz
      });
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Direccionar a diferentes pantallas
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RutinaScreen()),
        // MaterialPageRoute(builder: (context) => AnadirEjerciciosScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PublicacionesScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Lista_EjercicioScreen()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PerfilScreen()),
      );
    }
  }

  void onEmojiSelected(String mood) async {
  // Mostrar un Dialog con el estado seleccionado
  String tipoNotificacion = mood; // Asignar el tipo de notificación
  String mensaje = await getMensajeMotivacional(tipoNotificacion);
  

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Dale con todo!"),
        content: Text("Muchas gracias por compartirnos como te sientes. \n\n$mensaje"), // Mostrar mensaje de la notificación
        actions: [
          TextButton(
            child: Text("Cerrar"),
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el dialog
            },
          ),
        ],
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  // Bienvenida
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola, $usuario!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            fechaActual,
                            style: TextStyle(color: Colors.blue[700]),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                      // Icono de notificación
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  // Barra de búsqueda
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Busqueda...',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  // Cómo te sientes hoy
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '¿Cómo te sientes hoy?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.more_horiz),
                    ],
                  ),
                  SizedBox(height: 25),
                  // Emojis
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Triste
                      EmojiColumn(
                        emoji: '☹',
                        label: 'Triste',
                        onTap: () => onEmojiSelected('Triste'),
                      ),
                      // Normal
                      EmojiColumn(
                        emoji: '😐',
                        label: 'Normal',
                        onTap: () => onEmojiSelected('Normal'),
                      ),
                      // Bien
                      EmojiColumn(
                        emoji: '😊',
                        label: 'Bien',
                        onTap: () => onEmojiSelected('Bien'),
                      ),
                      // Super bien
                      EmojiColumn(
                        emoji: '🥳',
                        label: 'Superbién',
                        onTap: () => onEmojiSelected('Superbién'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            // Contenido expandido
            Expanded(
              child: ClipRRect(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    color: Colors.grey[100],
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recomendado',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Icon(Icons.more_horiz),
                            ],
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: ListView(
                              children: [
                                Listarecomendaciones(),
                                Listarecomendaciones(),
                                Listarecomendaciones(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Navbar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.view_list_rounded),
                label: 'Rutinas',
              ),
              BottomNavigationBarItem(
                icon: Transform.translate(
                    offset: Offset(0, 10), child: Icon(Icons.add_circle, size: 45)),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.line_axis_outlined),
                // icon: Icon(Icons.fitness_center_rounded),
                label: 'Ejercicios',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmojiColumn extends StatelessWidget {
  final String emoji;
  final String label;
  final VoidCallback onTap;

  const EmojiColumn({
    Key? key,
    required this.emoji,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Emojis(emojis: emoji),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class Emojis extends StatelessWidget {
  final String emojis;

  const Emojis({Key? key, required this.emojis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(12),
      child: Center(
        child: Text(
          emojis,
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}

class Listarecomendaciones extends StatelessWidget {
  const Listarecomendaciones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.red,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recomendación N°1',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      '10 Ejercicios',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.add, size: 40,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
