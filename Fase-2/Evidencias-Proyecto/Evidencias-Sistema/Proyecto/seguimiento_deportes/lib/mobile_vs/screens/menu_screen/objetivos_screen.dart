import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/core/providers/objetivo_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/login_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/logros_screen.dart';

class ObjetivosScreen extends StatefulWidget {
  const ObjetivosScreen({super.key});

  @override
  State<ObjetivosScreen> createState() => _ObjetivosScreenState();
}

class _ObjetivosScreenState extends State<ObjetivosScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String usuario = "Cargando...";

  @override
  void initState() {
    super.initState();
    _fetchUsername();
    // Obtén los objetivos al iniciar la pantalla
    Provider.of<ObjetivoProvider>(context, listen: false).getObjetivos();
  }

  Future<void> _fetchUsername() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String username = await Provider.of<Usuario_provider>(context, listen: false)
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Objetivos',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'En progreso'),
              Tab(text: 'Completadas'),
              Tab(text: 'Sin comenzar'),
            ],
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
                        radius: 40,
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
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LogrosScreen()));
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
        body: TabBarView(
          children: [
            _buildGoalsList(), // En progreso
            Center(child: Text("No hay objetivos completados de momento")),
            Center(child: Text("No hay objetivos sin comenzar de momento")),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsList() {
    return Consumer<ObjetivoProvider>(
      builder: (context, objetivoProvider, child) {
        if (objetivoProvider.objetivos.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: objetivoProvider.objetivos.length,
          itemBuilder: (context, index) {
            final objetivo = objetivoProvider.objetivos[index];
            return _buildGoalItem(
              Icons.star, // Puedes cambiar el ícono según el tipo de objetivo
              objetivo.nombreObjetivo,
              objetivo.descripcionObjetivo ?? 'Sin descripción', // Descripción
              objetivo.fechaLimite.toString().split(" ")[0], // Formato de fecha
              (objetivo.valorActual / objetivo.valorObjetivo), // Progreso como un valor entre 0 y 1
              objetivo.valorActual,
              objetivo.valorObjetivo,
            );
          },
        );
      },
    );
  }

  Widget _buildGoalItem(IconData icon, String title, String description, String dueDate, double progress, int currentValue, int targetValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey[200],
            child: Icon(icon, color: Colors.black),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(description, style: TextStyle(color: Colors.grey)), // Descripción del objetivo
                SizedBox(height: 4),
                Text(dueDate, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 4),
                Text('Valor Actual: $currentValue', style: TextStyle(color: Colors.black)),
                Text('Valor Objetivo: $targetValue', style: TextStyle(color: Colors.black)),
                SizedBox(height: 8),
                LinearProgressIndicator(value: progress),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
