import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/graficos_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/logros_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/objetivos_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/perfil_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/1_rutinas_screen.dart';
import 'package:seguimiento_deportes/core/providers/notificacion_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String usuario = "Cargando...";
  String fechaActual = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
    _setFechaActual();
  }

  void _setFechaActual() {
    fechaActual = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  Future<void> _fetchUsername() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String username =
          await Provider.of<Usuario_provider>(context, listen: false)
              .getUsername(user.uid);
      setState(() {
        usuario = username;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RutinaScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PublicacionesScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GraficosScreen()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PerfilScreen()),
      );
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void onEmojiSelected(String mood) async {
    String tipoNotificacion = mood;
    String mensaje = await getMensajeMotivacional(tipoNotificacion);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Dale con todo!"),
          content: Text(
              "Muchas gracias por compartirnos como te sientes. \n\n$mensaje"),
          actions: [
            TextButton(
              child: Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
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
                      radius: 40,
                      backgroundImage: AssetImage('assets/miguelito.jpeg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$usuario',
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
              leading: Icon(Icons.list),
              title: Text('Lista de ejercicios'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Lista_EjercicioScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_events),
              title: Text('Logros'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogrosScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.flag),
              title: Text('Objetivos'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ObjetivosScreen()));
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
                child: Text('Cerrar sesión',
                    style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) {
                          return IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          );
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5ECE3),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.black12,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '¡Hola, $usuario!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        fechaActual,
                        style:
                            TextStyle(color: Colors.green[700], fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Cómo te sientes hoy?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EmojiColumn(
                        emoji: '☹',
                        label: 'Triste',
                        onTap: () => onEmojiSelected('Triste'),
                      ),
                      EmojiColumn(
                        emoji: '😐',
                        label: 'Normal',
                        onTap: () => onEmojiSelected('Normal'),
                      ),
                      EmojiColumn(
                        emoji: '😊',
                        label: 'Bien',
                        onTap: () => onEmojiSelected('Bien'),
                      ),
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
                    child: Icon(Icons.add_circle, size: 45)),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.stacked_line_chart_rounded),
                label: 'Progreso',
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
        color: Color(0xFFF5ECE3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black12,
          width: 2,
        ),
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
          color: Color(0xFFF5ECE3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black12,
            width: 2,
          ),
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
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      '10 Ejercicios',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.add,
              size: 40,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
