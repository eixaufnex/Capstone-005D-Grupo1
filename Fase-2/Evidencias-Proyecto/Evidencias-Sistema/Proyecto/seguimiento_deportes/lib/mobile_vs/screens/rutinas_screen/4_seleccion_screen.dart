import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/ejercicio_provider.dart';

class SeleccionScreen extends StatefulWidget {
  final int rutinaId;
  final String exerciseType;

  const SeleccionScreen({Key? key, required this.rutinaId, required this.exerciseType})
      : super(key: key);

  @override
  _SeleccionScreenState createState() => _SeleccionScreenState();
}

class _SeleccionScreenState extends State<SeleccionScreen> {
  final Map<int, bool> selectedExercises = {}; // Map para almacenar el estado de selección

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Ejercicio_Provider(),
      child: Consumer<Ejercicio_Provider>(
        builder: (context, ejercicioProvider, _) {
          final principianteExercises = ejercicioProvider.getExercisesByDifficulty('Principiante');
          final intermedioExercises = ejercicioProvider.getExercisesByDifficulty('Intermedio');
          final avanzadoExercises = ejercicioProvider.getExercisesByDifficulty('Avanzado');

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
                      onPressed: _confirmSelection,
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

  Widget _buildDifficultySection(String title, List ejercicios) {
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
          name: ejercicio.nombreEjercicio,
          muscleGroup: ejercicio.grupoMuscular,
        )),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildExerciseItem({
    required int id,
    required String emoji,
    required String name,
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
                    name,
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
          IconButton(
            onPressed: () {
              setState(() {
                selectedExercises[id] = !(selectedExercises[id] ?? false);
              });
            },
            icon: Icon(
              selectedExercises[id] == true ? Icons.check : Icons.add,
              color: selectedExercises[id] == true ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmSelection() async {
    final selectedIds = selectedExercises.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    Navigator.pop(context, selectedIds); // Retorna los IDs seleccionados
  }
}
