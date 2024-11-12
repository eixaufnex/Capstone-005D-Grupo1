import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/login_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/logros_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/objetivos_screen.dart';

class Lista_EjercicioScreen extends StatefulWidget {
  const Lista_EjercicioScreen({super.key});

  @override
  State<Lista_EjercicioScreen> createState() => _ListaEjercicioScreenState();
}

// Mapa de iconos a utilizar
const Map<String, IconData> iconMap = {
  'facil': Icons.battery_1_bar_rounded,
  'intermedio': Icons.battery_4_bar_rounded,
  'dificil': Icons.battery_alert_rounded,
};

class _ListaEjercicioScreenState extends State<Lista_EjercicioScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String usuario = "Cargando...";

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String username = await Provider.of<UsuarioProvider>(context, listen: false)
          .getUsername(user.uid);
      setState(() {
        usuario = username;
      });
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // Lista de ejercicios
  final List<Map<String, String>> ejercicios = [
    {
      'title': 'Press banca',
      'dificultad': 'Intermedio',
      'grupo': 'Pecho',
      'iconName': 'intermedio',
      'imagen': 'https://static.strengthlevel.com/images/exercises/bench-press/bench-press-800.jpg',
    },
    {
      'title': 'Sentadilla',
      'dificultad': 'Avanzado',
      'grupo': 'Pierna',
      'iconName': 'dificil',
      'imagen': 'https://static.strengthlevel.com/images/exercises/squat/squat-800.jpg',
    },
    {
      'title': 'Peso muerto',
      'dificultad': 'Intermedio',
      'grupo': 'Espalda',
      'iconName': 'intermedio',
      'imagen': 'https://static.strengthlevel.com/images/exercises/deadlift/deadlift-800.jpg',
    },
    {
      'title': 'Flexiones',
      'dificultad': 'Fácil',
      'grupo': 'Pecho',
      'iconName': 'facil',
      'imagen': 'https://static.strengthlevel.com/images/exercises/push-ups/push-ups-800.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de ejercicios',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40, // Tamaño de la imagen
                      backgroundImage: AssetImage('assets/miguelito.jpeg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      usuario,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_events),
              title: Text('Logros'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LogrosScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.flag),
              title: Text('Objetivos'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ObjetivosScreen()));
              },
            ),
            
            SizedBox(height: 280),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[200],
                ),
                onPressed: () async {
                  await _signOut();
                },
                child: Text('Cerrar sesión', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: ejercicios.length,
        itemBuilder: (context, index) {
          final ejercicio = ejercicios[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EjercicioDetalleScreen(ejercicio: ejercicio),
                ),
              );
            },
            child: ListaEjercicios(
              title: ejercicio['title']!,
              dificultad: ejercicio['dificultad']!,
              icon: iconMap[ejercicio['iconName']] ?? Icons.help,
              grupo: ejercicio['grupo']!,
              imagen: ejercicio['imagen']!,
            ),
          );
        },
      ),
    );
  }
}

// Clase para lista de ejercicios
class ListaEjercicios extends StatelessWidget {
  final String title;
  final String dificultad;
  final IconData icon;
  final String grupo;
  final String imagen;

  const ListaEjercicios({
    required this.title,
    required this.dificultad,
    required this.icon, 
    required this.grupo,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: Offset(0.0, 10.0),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          )
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
          ),
          image: NetworkImage(imagen),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.5),
                    )
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.accessibility_new_sharp,
                        color: Colors.red,
                        size: 18,
                      ),
                      SizedBox(width: 7),
                      Text(grupo),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: Colors.red,
                        size: 18,
                      ),
                      SizedBox(width: 7),
                      Text(dificultad),
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
}

// Clase para detalles de ejercicio
class EjercicioDetalleScreen extends StatelessWidget {
  final Map<String, String> ejercicio;

  const EjercicioDetalleScreen({Key? key, required this.ejercicio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ejercicio['title']!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  ejercicio['imagen']!,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.contain,
                ),
                Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 50,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ejercicio['title']!,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Dificultad: ${ejercicio['dificultad']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'The ${ejercicio['title']} is a popular exercise for targeting specific muscle groups like ${ejercicio['grupo']}. It’s a great way to build strength and improve balance.',
                    style: TextStyle(fontSize: 16),
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
