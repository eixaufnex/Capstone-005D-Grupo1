import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/ejercicio_provider.dart';
import 'package:seguimiento_deportes/core/models/ejercicio.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';

class SeleccionScreen extends StatefulWidget {
  final int rutinaId;
  final String tipoRutina;
  final List<Map<String, String>> ejerciciosSeleccionados; // Recibimos los ejercicios seleccionados

  const SeleccionScreen({
    Key? key,
    required this.rutinaId,
    required this.tipoRutina,
    required this.ejerciciosSeleccionados, // Recibimos desde el constructor
  }) : super(key: key);

  @override
  _SeleccionScreenState createState() => _SeleccionScreenState();
}

class _SeleccionScreenState extends State<SeleccionScreen> {
  final Map<int, bool> selectedExercises = {}; // Mapa para controlar las selecciones

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EjercicioProvider(), // Inicia el proveedor
      child: Consumer<EjercicioProvider>( // Aquí es donde se consume el proveedor
        builder: (context, ejercicioProvider, _) {
          // Filtramos los ejercicios según el tipo de rutina
          final tipoRutina = widget.tipoRutina;

          // Filtramos los ejercicios según el tipo (Fuerza o Cardiovascular)
          final filteredExercises = ejercicioProvider.getExercisesByType(tipoRutina);

          // Filtramos los ejercicios que ya están seleccionados
          final principianteExercises = filteredExercises
              .where((ejercicio) =>
                  (ejercicio.dificultadEjercicio == 'Principiante' || 
                   ejercicio.dificultadEjercicio == 'Beginner') &&
                  !widget.ejerciciosSeleccionados
                      .any((selected) => selected['id'] == ejercicio.idListaEjercicio.toString()))
              .toList();

          final intermedioExercises = filteredExercises
              .where((ejercicio) =>
                  (ejercicio.dificultadEjercicio == 'Intermedio' ||
                  ejercicio.dificultadEjercicio == 'Intermediate')&&
                  !widget.ejerciciosSeleccionados
                      .any((selected) => selected['id'] == ejercicio.idListaEjercicio.toString()))
              .toList();

          final avanzadoExercises = filteredExercises
              .where((ejercicio) =>
                  (ejercicio.dificultadEjercicio == 'Avanzado' ||
                  ejercicio.dificultadEjercicio == 'Advanced')
                   &&
                  !widget.ejerciciosSeleccionados
                      .any((selected) => selected['id'] == ejercicio.idListaEjercicio.toString()))
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text(S.current.listaejercicio1, style: const TextStyle(color: Colors.black)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        _buildDifficultySection(S.current.label_intensity1, principianteExercises),
                        _buildDifficultySection(S.current.intermedio, intermedioExercises),
                        _buildDifficultySection(S.current.label_intensity3, avanzadoExercises),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _confirmSelection(filteredExercises), // Pasa filteredExercises aquí
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFF5ECE3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(S.current.Enter),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Construye las secciones de ejercicios por dificultad
  Widget _buildDifficultySection(String title, List<Ejercicio> ejercicios) {
    if (ejercicios.isEmpty) return const SizedBox(); // No mostrar si la lista está vacía

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...ejercicios.map((ejercicio) => _buildExerciseItem(
          id: ejercicio.idListaEjercicio,
          emoji: ejercicio.emojiEjercicio ?? '🏋️',
          name_ejercicio: ejercicio.nombreEjercicio,
          muscleGroup: ejercicio.grupoMuscular,
        )),
        const SizedBox(height: 16),
      ],
    );
  }

  // Construye el item de cada ejercicio
  Widget _buildExerciseItem({
    required int id,
    required String emoji,
    required String name_ejercicio,
    required String muscleGroup,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5ECE3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name_ejercicio,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    muscleGroup,
                    style: TextStyle(fontSize: 14, color: Colors.teal[400]),
                  ),
                ],
              ),
            ],
          ),
          Checkbox(
            value: selectedExercises[id] ?? false,
            onChanged: (bool? value) {
              setState(() {
                selectedExercises[id] = value!; // Marca los ejercicios seleccionados
              });
            },
          ),
        ],
      ),
    );
  }

  // Método para confirmar la selección de ejercicios
  Future<void> _confirmSelection(List<Ejercicio> filteredExercises) async {
    final selectedExercisesData = selectedExercises.entries
        .where((entry) => entry.value)
        .map((entry) {
          // Busca el ejercicio correspondiente al id
          final ejercicio = filteredExercises.firstWhere(
            (ejercicio) => ejercicio.idListaEjercicio == entry.key,
          );
          return {
            'id': ejercicio.idListaEjercicio,
            'nombre': ejercicio.nombreEjercicio,
          };
        }).toList();

    // Devuelve la lista de ejercicios seleccionados con id y nombre
    Navigator.pop(context, selectedExercisesData); // Devuelve la lista de ejercicios seleccionados
  }
}
