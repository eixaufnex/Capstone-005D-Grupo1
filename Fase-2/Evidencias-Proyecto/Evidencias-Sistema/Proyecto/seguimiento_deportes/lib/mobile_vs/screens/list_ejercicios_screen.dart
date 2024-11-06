import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/perfil_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/1_rutinas_screen.dart';

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
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Direccionar a las diferentes pantallas
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RutinaScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PublicacionesScreen()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PerfilScreen()),
      );
    }
  }

  // Lista de ejercicios
  //llamar a la bd
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
        title: Center(child: Text('Lista de ejercicios', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold))),
      ),
      body: ListView.builder(
        itemCount: ejercicios.length,
        itemBuilder: (context, index) {
          final ejercicio = ejercicios[index];
          return GestureDetector(
            onTap: () {
              // Navegar a la pantalla de detalles del ejercicio
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

      //NAVBAR
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
                  offset: Offset(0, 10),
                  child: Icon(Icons.add_circle, size: 45),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                // icon: Icon(Icons.fitness_center_rounded),
                icon: Icon(Icons.line_axis_outlined),
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

//Clase detalle ejercicio
class EjercicioDetalleScreen extends StatelessWidget {
  final Map<String, String> ejercicio;

  const EjercicioDetalleScreen({Key? key, required this.ejercicio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ejercicio['title']!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(ejercicio['imagen']!),
            SizedBox(height: 20),
            Text(
              'Dificultad: ${ejercicio['dificultad']}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Grupo: ${ejercicio['grupo']}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
