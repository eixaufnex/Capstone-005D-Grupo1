import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/ejercicio_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/login_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/glosario_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/logros_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/objetivos_screen.dart';

class Lista_EjercicioScreen extends StatefulWidget {
  const Lista_EjercicioScreen({super.key});

  @override
  State<Lista_EjercicioScreen> createState() => _ListaEjercicioScreenState();
}

class _ListaEjercicioScreenState extends State<Lista_EjercicioScreen> {
  int? selectedEjercicioId;
  String? selectedDificultad;
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

  void selectEjercicio(int ejercicioId) {
    setState(() {
      selectedEjercicioId = ejercicioId;
    });
  }

  void deselectEjercicio() {
    setState(() {
      selectedEjercicioId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ejercicioProvider = Provider.of<EjercicioProvider>(context);

    // Filtrar los ejercicios según la dificultad seleccionada
    final ejerciciosFiltrados = selectedDificultad == null
        ? ejercicioProvider.ejercicios
        : selectedDificultad == 'Todas'
            ? ejercicioProvider.ejercicios
                .where((ejercicio) => ['Principiante', 'Intermedio', 'Avanzado']
                    .contains(ejercicio.dificultadEjercicio))
                .toList()
            : ejercicioProvider.ejercicios
                .where((ejercicio) =>
                    ejercicio.dificultadEjercicio == selectedDificultad)
                .toList();

    if (selectedEjercicioId != null) {
      final ejercicio =
          ejercicioProvider.getEjercicioById(selectedEjercicioId!);

      return Scaffold(
        appBar: AppBar(
          title: Text(
            ejercicio.nombreEjercicio,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: deselectEjercicio,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                ejercicio.imagenEjercicio ??
                    'https://media.istockphoto.com/id/1128826884/es/vector/ning%C3%BAn-s%C3%ADmbolo-de-vector-de-imagen-falta-icono-disponible-no-hay-galer%C3%ADa-para-este-momento.jpg?s=612x612&w=0&k=20&c=9vnjI4XI3XQC0VHfuDePO7vNJE7WDM8uzQmZJ1SnQgk=',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                ejercicio.nombreEjercicio,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Dificultad: ${ejercicio.dificultadEjercicio}',
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              SizedBox(height: 8),
              Text(
                'Grupo Muscular: ${ejercicio.grupoMuscular}',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16),
              if (ejercicio.detalle != null) ...[
                Text(
                  'Descripción:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  ejercicio.detalle!.descripcion,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Instrucciones:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  ejercicio.detalle!.instrucciones,
                  style: TextStyle(fontSize: 16),
                ),
              ] else ...[
                Text(
                  'No hay detalles disponibles para este ejercicio.',
                  style: TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              ],
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Lista de Ejercicios',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
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
                        backgroundImage: AssetImage('assets/av9.png'),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ObjetivosScreen()));
                },
              ),
              ListTile(
              leading: Icon(Icons.menu_book_rounded),
              title: Text('Glosario'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GlosarioScreen()));
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
                  child: Text('Cerrar sesión',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: Wrap(
                spacing: 10.0,
                children: [
                  _buildFilterButton("Todas"),
                  _buildFilterButton("Principiante"),
                  _buildFilterButton("Intermedio"),
                  _buildFilterButton("Avanzado"),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ejerciciosFiltrados.length,
                itemBuilder: (context, index) {
                  final ejercicio = ejerciciosFiltrados[index];
                  return Container(
                    color: index % 2 == 0 ? Colors.orange[300] : Colors.white,
                    child: ListTile(
                      leading: Text(
                        ejercicio.emojiEjercicio ??
                            '🏋️', // Muestra el emoji o un emoji predeterminado
                        style: TextStyle(fontSize: 32),
                      ),
                      title: Text(ejercicio.nombreEjercicio),
                      subtitle: Text(
                        'Dificultad: ${ejercicio.dificultadEjercicio} - Grupo: ${ejercicio.grupoMuscular}',
                      ),
                      onTap: () => selectEjercicio(ejercicio.idListaEjercicio),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildFilterButton(String dificultad) {
    final isSelected = (dificultad == "Todas" && selectedDificultad == null) ||
        selectedDificultad == dificultad;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.red[300] : Colors.red[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        setState(() {
          selectedDificultad = dificultad == "Todas" ? null : dificultad;
        });
      },
      child: Text(
        dificultad,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
