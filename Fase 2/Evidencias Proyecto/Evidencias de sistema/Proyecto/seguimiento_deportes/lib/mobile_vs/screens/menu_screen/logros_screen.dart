import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/logro_provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/login_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/glosario_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/objetivos_screen.dart';
import 'package:seguimiento_deportes/core/services/logro_service.dart';

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
  bool logroVerificado = false; // Estado para evitar múltiples verificaciones

  @override
  void initState() {
    super.initState();
    _fetchUsername();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    _fetchAchievements();

    // Verificar logro si aún no se ha verificado
    if (!logroVerificado) {
      _verificarLogro();
    }
  }

  void _handleTabChange() {
    if (_tabController.index == 1) {
      _fetchAchievements(); // Actualiza los logros obtenidos
    }
  }

  Future<void> _verificarLogro() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        // Verificar y asignar logro para rutinas
        bool logroRutinaExiste =
            await existeLogro(user.uid, 1); // ID del logro "crear rutina"
        if (!logroRutinaExiste) {
          await verificarLogroCrearRutina(user.uid);
        } else {
          print('El logro "crear rutina" ya ha sido registrado previamente.');
        }

        // Verificar y asignar logro para objetivos
        bool logroObjetivoExiste =
            await existeLogro(user.uid, 2); // ID del logro "crear objetivo"
        if (!logroObjetivoExiste) {
          await verificarLogroCrearObjetivo(user.uid);
        } else {
          print('El logro "crear objetivo" ya ha sido registrado previamente.');
        }

        // Verificar y asignar logro para publicaciones
        bool logroPublicacionExiste =
            await existeLogro(user.uid, 3); // ID del logro "crear publicación"
        if (!logroPublicacionExiste) {
          await verificarLogroCrearPublicacion(user.uid);
        } else {
          print(
              'El logro "crear publicación" ya ha sido registrado previamente.');
        }

        setState(() {
          logroVerificado = true; // Indicar que ya se verificaron los logros
        });
      } catch (e) {
        print('Error al verificar o registrar los logros: $e');
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

  Future<void> _fetchAchievements() async {
    final user = _auth.currentUser;
    if (user != null) {
      final logroProvider = Provider.of<LogroProvider>(context, listen: false);
      await logroProvider.getLogrosGlobales();
      await logroProvider.getLogrosObtenidos(user.uid);
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
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.logros1,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: S.current.logros_globales),
            Tab(text: S.current.logros_obtenidos),
          ],
          indicatorColor: Colors.blue,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      drawer: _buildDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGlobalAchievementsList(),
          _buildObtainedAchievementsList(),
        ],
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
            title: Text(S.current.home),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text(S.current.listaejercicio1),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Lista_EjercicioScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text(S.current.objetivos1),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ObjetivosScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.menu_book_rounded),
            title: Text(S.current.glosario1),
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
              child:
                  Text(S.current.cerrarsesion, style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlobalAchievementsList() {
    return Consumer<LogroProvider>(
      builder: (context, logroProvider, child) {
        final logrosGlobales = logroProvider.logrosGlobales;
        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: logrosGlobales.length,
          itemBuilder: (context, index) {
            final logro = logrosGlobales[index];
            return Card(
              child: ListTile(
                leading: Icon(Icons.emoji_events, size: 40, color: Colors.grey),
                title: Text(logro.nombreLogro),
                subtitle: Text(logro.descripcionLogro),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildObtainedAchievementsList() {
    return Consumer<LogroProvider>(
      builder: (context, logroProvider, child) {
        final logrosObtenidos = logroProvider.logrosObtenidos
            .where((logro) => logro.fechaObtencion != null)
            .toList();

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: logrosObtenidos.length,
          itemBuilder: (context, index) {
            final logro = logrosObtenidos[index];
            final formattedDate =
                "${logro.fechaObtencion!.day.toString().padLeft(2, '0')}/"
                "${logro.fechaObtencion!.month.toString().padLeft(2, '0')}/"
                "${logro.fechaObtencion!.year}";

            return Card(
              child: ListTile(
                leading:
                    Icon(Icons.emoji_events, size: 40, color: Colors.yellow),
                title: Text(logro.nombreLogro),
                subtitle: Text('Obtenido el $formattedDate'),
              ),
            );
          },
        );
      },
    );
  }
}
