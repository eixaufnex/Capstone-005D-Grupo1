import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/login_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/objetivos_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/logros_screen.dart';

class GlosarioScreen extends StatefulWidget {
  const GlosarioScreen({super.key});

  @override
  State<GlosarioScreen> createState() => _GlosarioScreenState();
}

class _GlosarioScreenState extends State<GlosarioScreen> {
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

  final Map<String, String> _glosario = {
    "abandonment": "The act of leaving or deserting something.",
    "abate": "To reduce in degree or intensity.",
    "abbreviate": "To make briefer in length or extent, to condense.",
    "abdicate": "To formally give up a position or responsibility.",
    "benevolent": "Characterized by or suggestive of doing good.",
    "brevity": "Conciseness and exact use of words in writing or speech.",
    "beleaguer": "To cause constant or repeated trouble for someone.",
    "1": "To cause constant or repeated trouble for someone.",
    "z": "To causesdfaasd constant or repeated trouble for someone.",
    // Add more terms as needed
  };

  @override
  Widget build(BuildContext context) {
    // Group terms by their starting letter
    final Map<String, List<MapEntry<String, String>>> groupedTerms = {};
    for (var entry in _glosario.entries) {
      final letter = entry.key[0].toUpperCase();
      groupedTerms.putIfAbsent(letter, () => []).add(entry);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Glosario',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
      ),
      drawer: _buildDrawer(),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: groupedTerms.entries.map((group) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the letter header
              Text(
                group.key,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 8.0),
              // Display the terms under each letter
              ...group.value.map((entry) {
                return ListTile(
                  leading: Icon(Icons.collections_bookmark), // Change icon as desired
                  title: Text(
                    entry.key,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(entry.value),
                );
              }).toList(),
              Divider(),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
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
          SizedBox(height: 260),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[200],
              ),
              onPressed: () async {
                await _signOut();
              },
              child:
                  Text('Cerrar sesión', style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
