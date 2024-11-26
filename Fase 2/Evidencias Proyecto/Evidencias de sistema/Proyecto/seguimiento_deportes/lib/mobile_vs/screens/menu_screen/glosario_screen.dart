import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/perfil_provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';
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

  final Map<String, String> _glosario = {
    S.current.oneRM_One_Repetition_Maximum:
        S.current.oneRM_One_Repetition_Maximum_definition,
    S.current.Grip: S.current.Grip_definition,
    S.current.Aerobic: S.current.Aerobic_definition,
    S.current.Isolation: S.current.Isolation_definition,
    S.current.Range_of_Motion_ROM: S.current.Range_of_Motion_ROM_definition,
    S.current.AMRAP_As_Many_Reps_As_Possible:
        S.current.AMRAP_As_Many_Reps_As_Possible_definition,
    S.current.Swinging: S.current.Swinging_definition,
    S.current.Biceps: S.current.Biceps_definition,
    S.current.Biomechanics: S.current.Biomechanics_definition,
    S.current.Warm_Up: S.current.Warm_Up_definition,
    S.current.Cardiovascular: S.current.Cardiovascular_definition,
    S.current.Training_Cycle: S.current.Training_Cycle_definition,
    S.current.Core: S.current.Core_definition,
    S.current.Pull_Ups: S.current.Pull_Ups_definition,
    S.current.Drop_Set: S.current.Drop_Set_definition,
    S.current.e1RM_Estimated_One_Repetition_Maximum:
        S.current.e1RM_Estimated_One_Repetition_Maximum_definition,
    S.current.EMOM_Every_Minute_On_the_Minute:
        S.current.EMOM_Every_Minute_On_the_Minute_definition,
    S.current.Strength_Training: S.current.Strength_Training_definition,
    S.current.Stretching: S.current.Stretching_definition,
    S.current.Compound_Exercise: S.current.Compound_Exercise_definition,
    S.current.Failure: S.current.Failure_definition,
    S.current.Muscle_Failure: S.current.Muscle_Failure_definition,
    S.current.Flexibility: S.current.Flexibility_definition,
    S.current.Muscle_Gain: S.current.Muscle_Gain_definition,
    S.current.Glutes: S.current.Glutes_definition,
    S.current.Hyperextension: S.current.Hyperextension_definition,
    S.current.Hypertrophy: S.current.Hypertrophy_definition,
    S.current.Intensity: S.current.Intensity_definition,
    S.current.Rest_Interval: S.current.Rest_Interval_definition,
    S.current.Pull: S.current.Pull_definition,
    S.current.Olympic_Lifting: S.current.Olympic_Lifting_definition,
    S.current.Lunge: S.current.Lunge_definition,
    S.current.Dumbbell: S.current.Dumbbell_definition,
    S.current.Maximum_Repetition_OneRM:
        S.current.Maximum_Repetition_OneRM_definition,
    S.current.Bodybuilding: S.current.Bodybuilding_definition,
    S.current.Deadlift: S.current.Deadlift_definition,
    S.current.Plank: S.current.Plank_definition,
    S.current.Plyometrics: S.current.Plyometrics_definition,
    S.current.Press: S.current.Press_definition,
    S.current.Repetitions_Reps: S.current.Repetitions_Reps_definition,
    S.current.RM_Repetition_Maximum: S.current.RM_Repetition_Maximum_definition,
    S.current.RPE_Rate_of_Perceived_Exertion:
        S.current.RPE_Rate_of_Perceived_Exertion_definition,
    S.current.Sets: S.current.Sets_definition,
    S.current.Submaximal: S.current.Submaximal_definition,
    S.current.Superset: S.current.Superset_definition,
    S.current.Tempo: S.current.Tempo_definition,
    S.current.Toning: S.current.Toning_definition,
    S.current.Trapezius: S.current.Trapezius_definition,
    S.current.VO2_Max: S.current.VO2_Max_definition,
    S.current.Training_Volume: S.current.Training_Volume_definition,
    S.current.Heart_Rate_Zone: S.current.Heart_Rate_Zone_definition,
  };

  @override
  Widget build(BuildContext context) {
    // Ordenar los términos alfabéticamente por clave
    final sortedEntries = _glosario.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    // Agrupar los términos por la primera letra de la clave
    final Map<String, List<MapEntry<String, String>>> groupedTerms = {};
    for (var entry in sortedEntries) {
      final letter = entry.key[0].toUpperCase();
      groupedTerms.putIfAbsent(letter, () => []).add(entry);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.glosario1, // Localización para el título del glosario
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
              // Mostrar la letra como encabezado
              Text(
                group.key,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 8.0),
              // Mostrar los términos bajo cada letra
              ...group.value.map((entry) {
                return ListTile(
                  leading: Icon(Icons.collections_bookmark),
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
            title: Text(S.current.home), // Localización para "Inicio"
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text(S.current
                .listaejercicio1), // Localización para "Lista de ejercicios"
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Lista_EjercicioScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.emoji_events),
            title: Text(S.current.logros1), // Localización para "Logros"
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogrosScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text(S.current.objetivos1), // Localización para "Objetivos"
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
              child: Text(S.current.cerrarsesion,
                  style: TextStyle(
                      color:
                          Colors.black)), // Localización para "Cerrar sesión"
            ),
          ),
        ],
      ),
    );
  }
}
