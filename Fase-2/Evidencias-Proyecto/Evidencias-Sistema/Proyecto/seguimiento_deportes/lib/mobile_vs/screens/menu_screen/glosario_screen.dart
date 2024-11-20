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
    "1RM (Repetición Máxima)":
        "Peso máximo que una persona puede levantar en una sola repetición para un ejercicio específico.",
    "Agarre":
        "Forma de sujetar una barra o mancuernas al realizar un ejercicio. Puede ser en supinación (palmas hacia arriba), pronación (palmas hacia abajo) o neutro (palmas enfrentadas).",
    "Aeróbico":
        "Ejercicio que requiere oxígeno para producir energía, como correr o andar en bicicleta. Se enfoca en mejorar la resistencia cardiovascular.",
    "Aislamiento":
        "Ejercicio que se enfoca en trabajar un solo grupo muscular, como el curl de bíceps.",
    "Amplitud de movimiento (ROM)":
        "Rango completo de movimiento en una articulación durante un ejercicio.",
    "AMRAP (As Many Reps As Possible)":
        "Entrenamiento en el que se realizan tantas repeticiones como sea posible de un ejercicio dentro de un tiempo determinado o hasta el fallo muscular.",
    "Balanceo":
        "Movimiento que usa impulso en lugar de fuerza muscular controlada, generalmente se debe evitar para prevenir lesiones.",
    "Bíceps":
        "Músculo de la parte superior del brazo responsable de la flexión del codo.",
    "Biomecánica":
        "Estudio del movimiento del cuerpo, que incluye cómo interactúan los músculos y las articulaciones al realizar ejercicios.",
    "Calentamiento":
        "Serie de ejercicios suaves para preparar al cuerpo para el entrenamiento, aumentando la temperatura y la circulación en los músculos.",
    "Cardiovascular":
        "Ejercicio que mejora la eficiencia del sistema cardiovascular, como correr, nadar o andar en bicicleta.",
    "Ciclo de entrenamiento":
        "Período de tiempo definido para seguir una rutina de entrenamiento específica.",
    "Core":
        "Conjunto de músculos en la zona media del cuerpo, incluyendo abdominales, lumbares y oblicuos, que aportan estabilidad.",
    "Dominadas":
        "Ejercicio de tracción que implica levantar el cuerpo usando los brazos y los músculos de la espalda.",
    "Drop set":
        "Técnica donde se reduce el peso después de llegar al fallo muscular para continuar el ejercicio sin descanso.",
    "e1RM (Estimated 1 Repetition Maximum)":
        "Estimación del peso máximo que una persona podría levantar en una sola repetición, calculado mediante fórmulas en base al peso y repeticiones completadas en una serie.",
    "EMOM (Every Minute On the Minute)":
        "Entrenamiento en el que se realiza una serie de ejercicios al comienzo de cada minuto, descansando el resto del minuto antes de comenzar de nuevo.",
    "Entrenamiento de fuerza":
        "Ejercicio que se enfoca en el desarrollo de la fuerza muscular mediante el levantamiento de pesas o resistencia.",
    "Estiramiento":
        "Ejercicios para mejorar la flexibilidad y prevenir lesiones mediante la elongación de los músculos.",
    "Ejercicio compuesto":
        "Ejercicio que trabaja múltiples grupos musculares y articulaciones, como el press de banca o la sentadilla.",
    "Fallo":
        "Punto en el cual los músculos no pueden realizar otra repetición con buena forma, forzando al descanso.",
    "Fallo muscular":
        "Punto en el cual los músculos no pueden realizar otra repetición con buena forma.",
    "Flexibilidad":
        "Capacidad de una articulación para moverse a través de su rango de movimiento completo.",
    "Ganar masa muscular":
        "Objetivo de aumentar el volumen y tamaño de los músculos mediante ejercicios de fuerza y una dieta adecuada.",
    "Glúteos":
        "Músculos grandes en la zona de las nalgas, responsables de la extensión y rotación de la cadera.",
    "Hiperextensión":
        "Movimiento excesivo de una articulación más allá de su rango normal, lo cual puede causar lesiones.",
    "Hipertrofia":
        "Crecimiento del tamaño de los músculos debido a un entrenamiento específico y nutrición adecuada.",
    "Intensidad":
        "Nivel de esfuerzo requerido para realizar un ejercicio o una rutina, usualmente medido en porcentaje del esfuerzo máximo.",
    "Intervalo de descanso":
        "Tiempo de recuperación entre series o ejercicios.",
    "Jalón":
        "Movimiento de tracción, como en ejercicios de espalda que requieren tirar de una carga hacia el cuerpo.",
    "Levantamiento olímpico":
        "Deportes y movimientos específicos que incluyen levantamientos como el clean and jerk y el snatch.",
    "Lunge":
        "Ejercicio de pierna en el cual un pie da un paso adelante y la rodilla se flexiona, trabajando glúteos y cuadríceps.",
    "Mancuerna":
        "Peso libre que se sostiene en una mano, utilizado en ejercicios de fuerza.",
    "Máxima repetición (1RM)":
        "Peso máximo que una persona puede levantar en una sola repetición para un ejercicio determinado.",
    "Musculación":
        "Entrenamiento enfocado en desarrollar tamaño y fuerza muscular.",
    "Núcleo o core":
        "Grupo de músculos estabilizadores en la zona media del cuerpo, fundamentales para la postura y equilibrio.",
    "Peso muerto":
        "Ejercicio compuesto que involucra múltiples grupos musculares, levantando una barra desde el suelo.",
    "Plancha":
        "Ejercicio isométrico de core que consiste en mantener el cuerpo recto en posición de flexión.",
    "Pliometría":
        "Ejercicios diseñados para aumentar la potencia y velocidad a través de movimientos explosivos, como saltos o lanzamientos.",
    "Press":
        "Ejercicio de empuje que utiliza movimientos como el press de banca o press de hombros.",
    "Rango de movimiento (ROM)":
        "Distancia y dirección en la que se puede mover una articulación.",
    "Repeticiones (reps)":
        "Número de veces que se realiza un ejercicio en una serie.",
    "RM (Repetición Máxima)":
        "Número máximo de repeticiones que se pueden hacer con un peso determinado antes de llegar al fallo muscular.",
    "RPE (Rate of Perceived Exertion)":
        "Escala subjetiva que mide la intensidad percibida durante un ejercicio, generalmente de 1 a 10, donde 10 es el máximo esfuerzo posible.",
    "Series": "Conjunto de repeticiones en un ejercicio antes de descansar.",
    "Submáximo":
        "Peso o esfuerzo que está por debajo del nivel máximo, utilizado en entrenamientos para evitar el agotamiento.",
    "Superserie":
        "Técnica donde se realizan dos ejercicios seguidos sin descanso, generalmente para grupos musculares opuestos.",
    "Tempo":
        "Velocidad controlada de cada fase del movimiento en un ejercicio, generalmente expresado en una secuencia de cuatro números (ej.: 2-0-2-0) para controlar la ejecución.",
    "Tonificación":
        "Programa de ejercicios y dieta para reducir grasa y aumentar la definición muscular sin grandes aumentos de volumen.",
    "Trapecio":
        "Músculo grande de la espalda que controla los movimientos de la escápula y el cuello.",
    "VO2 Máx":
        "Capacidad máxima del cuerpo para transportar y utilizar oxígeno durante el ejercicio intenso, un indicador de la aptitud cardiovascular.",
    "Volumen de entrenamiento":
        "Cantidad total de trabajo realizado, generalmente calculado como series x repeticiones x peso.",
    "Zona de frecuencia cardíaca":
        "Rango de latidos por minuto adecuado para un objetivo específico de entrenamiento (ej.: zona aeróbica, anaeróbica)."
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
                  leading: Icon(
                      Icons.collections_bookmark), // Change icon as desired
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
