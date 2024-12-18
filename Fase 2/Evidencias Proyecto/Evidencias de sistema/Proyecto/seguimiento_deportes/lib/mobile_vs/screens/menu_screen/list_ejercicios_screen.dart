import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/ejercicio_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seguimiento_deportes/core/providers/perfil_provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';
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
    _fetchUserAvatar();
  }

  String avatarUrl = 'assets/av9.png';

  Future<void> _fetchUserAvatar() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final perfilProvider =
          Provider.of<PerfilProvider>(context, listen: false);
      final perfil = await perfilProvider.getPerfil(user.uid);
      if (perfil != null && perfil.fotoPerfil != null) {
        setState(() {
          avatarUrl = perfil.fotoPerfil!;
        });
      }
    }
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
    final ejerciciosFiltrados =
        selectedDificultad == null || selectedDificultad?.toLowerCase() == 'todas'
            ? ejercicioProvider.ejercicios
                .where((ejercicio) => ['Principiante', 'Intermedio', 'Avanzado']
                .contains(ejercicio.dificultadEjercicio))
                .toList()
            : selectedDificultad?.toLowerCase() == 'all'
                ? ejercicioProvider.ejercicios
                    .where((ejercicio) => ['Beginner', 'Intermediate', 'Advanced']
                    .contains(ejercicio.dificultadEjercicio))
                    .toList()
                : ejercicioProvider.ejercicios
                    .where((ejercicio) =>
                        ejercicio.dificultadEjercicio.toLowerCase() ==
                        selectedDificultad?.toLowerCase())
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  ejercicio.imagenEjercicio ??
                      'https://media.istockphoto.com/id/1128826884/es/vector/ning%C3%BAn-s%C3%ADmbolo-de-vector-de-imagen-falta-icono-disponible-no-hay-galer%C3%ADa-para-este-momento.jpg?s=612x612&w=0&k=20&c=9vnjI4XI3XQC0VHfuDePO7vNJE7WDM8uzQmZJ1SnQgk=',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.contain, // Ajuste para que se vea toda la imagen
                ),
                SizedBox(height: 16),
                Text(
                  ejercicio.nombreEjercicio,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '${S.current.dificultad}: ${ejercicio.dificultadEjercicio}',
                  style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                ),
                SizedBox(height: 8),
                Text(
                  '${S.current.grupo}: ${ejercicio.grupoMuscular}',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16),
                if (ejercicio.detalle != null) ...[
                  Text(
                    '${S.current.descripcion}:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ejercicio.detalle!.descripcion,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${S.current.instrucciones1}:',
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
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            S.current.listaejercicio1,
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
                        radius: 40,
                        backgroundImage: avatarUrl.startsWith('http')
                            ? NetworkImage(avatarUrl)
                            : AssetImage(avatarUrl)
                                as ImageProvider, // Mostrar desde la BD o local
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
                title: Text(S.current.home),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.emoji_events),
                title: Text(S.current.logros1),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogrosScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.flag),
                title: Text(S.current.objetivos1),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ObjetivosScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.menu_book_rounded),
                title: Text(S.current.glosario1),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GlosarioScreen()));
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
                  child: Text(S.current.cerrarsesion,
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
                  _buildFilterButton(S.current.todas),
                  _buildFilterButton(S.current.label_intensity1),
                  _buildFilterButton(S.current.intermedio),
                  _buildFilterButton(S.current.label_intensity3),
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
                        '${S.current.dificultad}: ${ejercicio.dificultadEjercicio} - ${S.current.grupo}: ${ejercicio.grupoMuscular}',
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
    final isSelected = (dificultad.toLowerCase() == "todas" &&
            selectedDificultad?.toLowerCase() == "todas") ||
        (dificultad.toLowerCase() == "all" &&
            selectedDificultad?.toLowerCase() == "all") ||
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
          selectedDificultad = (dificultad.toLowerCase() == "todas" ||
                  dificultad.toLowerCase() == "all")
              ? dificultad.toLowerCase()
              : dificultad;
        });
      },
      child: Text(
        dificultad,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
