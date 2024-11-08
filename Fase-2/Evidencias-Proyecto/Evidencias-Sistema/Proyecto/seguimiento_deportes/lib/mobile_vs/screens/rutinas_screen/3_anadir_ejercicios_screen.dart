import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/4_seleccion_screen.dart';

class AnadirEjerciciosScreen extends StatefulWidget {
  final int rutinaId;
  final String exerciseType;

  const AnadirEjerciciosScreen({
    Key? key,
    required this.rutinaId,
    required this.exerciseType,
  }) : super(key: key);

  @override
  _AnadirEjerciciosScreenState createState() => _AnadirEjerciciosScreenState();
}

class _AnadirEjerciciosScreenState extends State<AnadirEjerciciosScreen> {
  final List<String> days = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];
  final Map<String, bool> selectedDays = {
    'Lunes': false,
    'Martes': false,
    'Miércoles': false,
    'Jueves': false,
    'Viernes': false,
    'Sábado': false,
    'Domingo': false,
  };

  // Lista de ejercicios seleccionados que se visualizarán
  List<Map<String, String>> ejercicios = [];

  // Navega a la pantalla de selección y añade los ejercicios seleccionados
  Future<void> _navigateAndAddExercises() async {
    final selectedEjercicios = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeleccionScreen(
          rutinaId: widget.rutinaId,
          exerciseType: widget.exerciseType,
        ),
      ),
    );

    // Añade los ejercicios seleccionados si hay retorno desde Screen 4
    if (selectedEjercicios != null) {
      setState(() {
        for (var ejercicio in selectedEjercicios) {
          ejercicios.add({
            'id': ejercicio.idListaEjercicio.toString(),
            'nombre': ejercicio.nombreEjercicio,
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.exerciseType,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'creacion');
          },
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "Ejercicios de ${widget.exerciseType}",
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'ID de Rutina: ${widget.rutinaId}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ejercicios.isEmpty
                  ? Center(
                      child: Text(
                        "Tienes que agregar tus ejercicios",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]),
                      ),
                    )
                  : ListView.builder(
                      itemCount: ejercicios.length,
                      itemBuilder: (context, index) {
                        final ejercicio = ejercicios[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5ECE3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.fitness_center,
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                            title: Text(
                              ejercicio['nombre'] ?? '',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text('00 Series | 00 Reps'),
                            trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, 'rutina_detalle');
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: const Color(0xFFF5ECE3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Editar'),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _navigateAndAddExercises,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFF5ECE3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Agrega un nuevo ejercicio'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
