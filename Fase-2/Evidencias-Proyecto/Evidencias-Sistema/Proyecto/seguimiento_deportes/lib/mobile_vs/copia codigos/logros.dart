import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/login_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/objetivos_screen.dart';

class LogrosScreen extends StatefulWidget {
  const LogrosScreen({super.key});

  @override
  State<LogrosScreen> createState() => _LogrosScreenState();
}

class _LogrosScreenState extends State<LogrosScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String usuario = "Cargando...";

  late TabController _tabController;
  bool _isTabControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _fetchUsername();

    // Inicializa el TabController y marca como inicializado
    _tabController = TabController(length: 2, vsync: this);
    _isTabControllerInitialized = true;
  }

  Future<void> _fetchUsername() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String username =
          await Provider.of<UsuarioProvider>(context, listen: false)
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Logros',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        bottom: _isTabControllerInitialized
            ? TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: 'Logros Globales'),
                  Tab(text: 'Logros Obtenidos'),
                ],
                indicatorColor: Colors.blue,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
              )
            : null,
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
      body: _isTabControllerInitialized
          ? TabBarView(
              controller: _tabController,
              children: [
                _buildAchievementsList(),
                _buildAchievementsList(),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildAchievementsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 4, // Aquí defines el número de logros en la lista
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Icon(Icons.emoji_events, size: 40, color: Colors.grey),
            title: Text('Habit Master'),
            subtitle: Text("You've added 5 new habits this week"),
            trailing: Icon(Icons.star_border, color: Colors.grey),
          ),
        );
      },
    );
  }
}
