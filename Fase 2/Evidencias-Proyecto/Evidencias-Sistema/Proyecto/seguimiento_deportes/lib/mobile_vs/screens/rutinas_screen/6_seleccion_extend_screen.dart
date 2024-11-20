import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/ejercicio_provider.dart';
import 'package:seguimiento_deportes/core/models/ejercicio.dart';
import 'package:seguimiento_deportes/core/services/rutina_ejercicio_service.dart';

class SeleccionExtendScreen extends StatefulWidget {
  final int rutinaId;
  final String tipoRutina;
  final List<Map<String, String>> ejerciciosSeleccionados;

  const SeleccionExtendScreen({
    Key? key,
    required this.rutinaId,
    required this.tipoRutina,
    required this.ejerciciosSeleccionados,
  }) : super(key: key);

  @override
  State<SeleccionExtendScreen> createState() => _SeleccionExtendScreenState();
}

class _SeleccionExtendScreenState extends State<SeleccionExtendScreen> {
  final Map<int, bool> selectedExercises = {};

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EjercicioProvider(),
      child: Consumer<EjercicioProvider>(
        builder: (context, ejercicioProvider, _) {
          final tipoRutina = widget.tipoRutina;
          final filteredExercises = ejercicioProvider.getExercisesByType(tipoRutina);

          final principianteExercises = filteredExercises
              .where((ejercicio) =>
                  ejercicio.dificultadEjercicio == 'Principiante' &&
                  !widget.ejerciciosSeleccionados
                      .any((selected) => selected['id'] == ejercicio.idListaEjercicio.toString()))
              .toList();

          final intermedioExercises = filteredExercises
              .where((ejercicio) =>
                  ejercicio.dificultadEjercicio == 'Intermedio' &&
                  !widget.ejerciciosSeleccionados
                      .any((selected) => selected['id'] == ejercicio.idListaEjercicio.toString()))
              .toList();

          final avanzadoExercises = filteredExercises
              .where((ejercicio) =>
                  ejercicio.dificultadEjercicio == 'Avanzado' &&
                  !widget.ejerciciosSeleccionados
                      .any((selected) => selected['id'] == ejercicio.idListaEjercicio.toString()))
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Lista de Ejercicios', style: TextStyle(color: Colors.black)),
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
                        _buildDifficultySection('Principiante', principianteExercises),
                        _buildDifficultySection('Intermedio', intermedioExercises),
                        _buildDifficultySection('Avanzado', avanzadoExercises),
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
                      child: const Text('Confirmar'),
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

  Widget _buildDifficultySection(String title, List<Ejercicio> ejercicios) {
    if (ejercicios.isEmpty) return const SizedBox();

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
                selectedExercises[id] = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> _confirmSelection(List<Ejercicio> filteredExercises) async {
    final selectedExercisesData = selectedExercises.entries
        .where((entry) => entry.value)
        .map((entry) {
          final ejercicio = filteredExercises.firstWhere(
            (ejercicio) => ejercicio.idListaEjercicio == entry.key,
          );
          return {
            'id': ejercicio.idListaEjercicio.toString(),
            'nombre': ejercicio.nombreEjercicio,
          };
        }).toList();

    final success = await ApiService().saveEjerciciosToRutina(
      widget.rutinaId,
      selectedExercisesData,
    );

    if (success) {
      Navigator.pop(context, selectedExercisesData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ejercicios guardados correctamente')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar los ejercicios')),
      );
    }
  }
}

