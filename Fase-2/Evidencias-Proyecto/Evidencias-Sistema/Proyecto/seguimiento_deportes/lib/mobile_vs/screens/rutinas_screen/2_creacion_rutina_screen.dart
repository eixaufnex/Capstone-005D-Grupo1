import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/3_anadir_ejercicios_screen.dart';

class CreacionRutinaScreen extends StatelessWidget {
  final int rutinaId;

  const CreacionRutinaScreen({Key? key, required this.rutinaId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? selectedExerciseType;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'rutinas');
          },
        ),
        title: Text('Selecciona el tipo de ejercicio'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Elige en base a tus objetivos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildExerciseOption('Fuerza', 'assets/pesas.jpeg', (type) {
                    selectedExerciseType = type;
                  }),
                  _buildExerciseOption('Cardiovasculares', 'assets/cardiovascular.jpeg', (type) {
                    selectedExerciseType = type;
                  }),
                  _buildExerciseOption('Flexibilidad', 'assets/flexibilidad.jpeg', (type) {
                    selectedExerciseType = type;
                  }),
                  _buildExerciseOption('Deporte en equipo', 'assets/deporte.jpeg', (type) {
                    selectedExerciseType = type;
                  }),
                  _buildExerciseOption('Elongacion', 'assets/elongacion.jpeg', (type) {
                    selectedExerciseType = type;
                  }),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedExerciseType != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnadirEjerciciosScreen(
                          rutinaId: rutinaId,
                          exerciseType: selectedExerciseType!,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Seleccione un tipo de ejercicio')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey[200],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Confirmar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseOption(String title, String imagePath, Function(String) onTap) {
    return GestureDetector(
      onTap: () => onTap(title),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
