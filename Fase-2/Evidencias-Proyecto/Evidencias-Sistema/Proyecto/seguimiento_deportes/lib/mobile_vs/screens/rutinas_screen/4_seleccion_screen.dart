import 'package:flutter/material.dart';

class SeleccionScreen extends StatelessWidget {
  const SeleccionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Ejercicios',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'anadir');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Acción de búsqueda
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Crea un nuevo ejercicio',
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed: () {
                    // Acción para agregar un nuevo ejercicio
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSection('Principiante', [
                    _buildExerciseItem(
                        Icons.accessibility_new, 'Flexiones', 'Pecho, Tríceps'),
                    _buildExerciseItem(
                        Icons.sports_mma, 'Sentadillas', 'Cuádriceps, Glúteos'),
                  ]),
                  _buildSection('Intermedio', [
                    _buildExerciseItem(
                        Icons.fitness_center, 'Plancha', 'Abdominales'),
                    _buildExerciseItem(
                        Icons.rotate_right, 'Giro Ruso', 'Oblicuos'),
                  ]),
                  _buildSection('Avanzado', [
                    _buildExerciseItem(
                        Icons.sports_gymnastics, 'Flexión Pike', 'Hombros'),
                    _buildExerciseItem(
                        Icons.accessibility, 'Hollow Hold', 'Abdomen Inferior'),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción para confirmar la selección
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFF5ECE3), // Color del texto
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
  }

  Widget _buildSection(String title, List<Widget> exercises) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...exercises,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildExerciseItem(IconData icon, String name, String muscles) {
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
                child: Icon(icon, size: 24, color: Colors.black),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    muscles,
                    style: TextStyle(fontSize: 14, color: Colors.teal[400]),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              // Acción para agregar el ejercicio
            },
            icon: const Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
