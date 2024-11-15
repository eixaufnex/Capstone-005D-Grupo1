import 'package:flutter/material.dart';

class RutinasRecomendadas extends StatelessWidget {
  final String tipoNivel; // El nivel del usuario
  final List<bool> isRecommendedAddedList;
  final Function(int, String, String, String, List<Map<String, String>>)
      addRecommendedRoutine;
  final Function(String) isRoutineExists;

  const RutinasRecomendadas({
    Key? key,
    required this.tipoNivel,
    required this.isRecommendedAddedList,
    required this.addRecommendedRoutine,
    required this.isRoutineExists,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          // Filtrar rutinas según el nivel del usuario
          if (tipoNivel == 'Principiante' &&
              !isRoutineExists('Rutina de Fuerza') &&
              !isRecommendedAddedList[0])
            Listarecomendaciones(
              nombre: 'Rutina de Fuerza',
              ejercicios: '5 Ejercicios',
              emoji: '💪',
              nivel: 'Principiante',
              onAdd: () => addRecommendedRoutine(
                0,
                'Rutina de Fuerza',
                '💪',
                'Fuerza',
                [
                  {'id': '1'},
                  {'id': '2'},
                  {'id': '3'},
                  {'id': '4'},
                  {'id': '5'},
                ],
              ),
            ),

          if (tipoNivel == 'Principiante' &&
              !isRoutineExists('Rutina de Cardio') &&
              !isRecommendedAddedList[1])
            Listarecomendaciones(
              nombre: 'Rutina de Cardio',
              ejercicios: '6 Ejercicios',
              emoji: '🏃‍♂️',
              nivel: 'Principiante',
              onAdd: () => addRecommendedRoutine(
                1,
                'Rutina de Cardio',
                '🏃‍♂️',
                'Cardio',
                [
                  {'id': '1'},
                  {'id': '2'},
                  {'id': '3'},
                  {'id': '4'},
                  {'id': '5'},
                  {'id': '6'},
                ],
              ),
            ),

          if (tipoNivel == 'Principiante' &&
              !isRoutineExists('Rutina de Flexibilidad') &&
              !isRecommendedAddedList[2])
            Listarecomendaciones(
              nombre: 'Rutina de Flexibilidad',
              ejercicios: '6 Ejercicios',
              emoji: '🧘‍♂️',
              nivel: 'Principiante',
              onAdd: () => addRecommendedRoutine(
                2,
                'Rutina de Flexibilidad',
                '🧘‍♂️',
                'Flexibilidad',
                [
                  {'id': '1'},
                  {'id': '2'},
                  {'id': '3'},
                  {'id': '4'},
                  {'id': '5'},
                  {'id': '6'},
                ],
              ),
            ),

          if (tipoNivel == 'Medio' &&
              !isRoutineExists('Rutina de Fuerza') &&
              !isRecommendedAddedList[0])
            Listarecomendaciones(
              nombre: 'Rutina de Fuerza',
              ejercicios: '7 Ejercicios',
              emoji: '💪',
              nivel: 'Intermedio',
              onAdd: () => addRecommendedRoutine(
                0,
                'Rutina de Fuerza',
                '💪',
                'Fuerza',
                [
                  {'id': '1'},
                  {'id': '2'},
                  {'id': '3'},
                  {'id': '4'},
                  {'id': '5'},
                  {'id': '6'},
                  {'id': '7'},
                ],
              ),
            ),

          if (tipoNivel == 'Medio' &&
              !isRoutineExists('Rutina de Cardio') &&
              !isRecommendedAddedList[1])
            Listarecomendaciones(
              nombre: 'Rutina de Cardio',
              ejercicios: '2 Ejercicios',
              emoji: '🏃‍♂️',
              nivel: 'Intermedio',
              onAdd: () => addRecommendedRoutine(
                1,
                'Rutina de Cardio',
                '🏃‍♂️',
                'Cardiovascular',
                [
                  {'id': '1'},
                  {'id': '2'}
                ],
              ),
            ),

          if (tipoNivel == 'Medio' &&
              !isRoutineExists('Rutina de Flexibilidad') &&
              !isRecommendedAddedList[2])
            Listarecomendaciones(
              nombre: 'Rutina de Flexibilidad',
              ejercicios: '3 Ejercicios',
              emoji: '🧘‍♂️',
              nivel: 'Intermedio',
              onAdd: () => addRecommendedRoutine(
                2,
                'Rutina de Flexibilidad',
                '🧘‍♂️',
                'Flexibilidad',
                [
                  {'id': '1'},
                  {'id': '2'},
                  {'id': '3'}
                ],
              ),
            ),

          if (tipoNivel == 'Avanzado' &&
              !isRoutineExists('Rutina de Fuerza') &&
              !isRecommendedAddedList[0])
            Listarecomendaciones(
              nombre: 'Rutina de Fuerza',
              ejercicios: '10 Ejercicios',
              emoji: '💪',
              nivel: 'Avanzado',
              onAdd: () => addRecommendedRoutine(
                0,
                'Rutina de Fuerza',
                '💪',
                'Fuerza',
                [
                  {'id': '1'},
                  {'id': '2'},
                  {'id': '3'},
                  {'id': '4'},
                  {'id': '5'},
                  {'id': '6'},
                  {'id': '7'},
                  {'id': '8'},
                  {'id': '9'},
                  {'id': '10'}
                ],
              ),
            ),

          if (tipoNivel == 'Avanzado' &&
              !isRoutineExists('Rutina de Cardio') &&
              !isRecommendedAddedList[1])
            Listarecomendaciones(
              nombre: 'Rutina de Cardio',
              ejercicios: '4 Ejercicios',
              emoji: '🏃‍♂️',
              nivel: 'Avanzado',
              onAdd: () => addRecommendedRoutine(
                1,
                'Rutina de Cardio',
                '🏃‍♂️',
                'Cardio',
                [
                  {'id': '1'},
                  {'id': '2'},
                  {'id': '3'},
                  {'id': '4'}
                ],
              ),
            ),

          if (tipoNivel == 'Avanzado' &&
              !isRoutineExists('Rutina de Flexibilidad') &&
              !isRecommendedAddedList[2])
            Listarecomendaciones(
              nombre: 'Rutina de Flexibilidad',
              ejercicios: '8 Ejercicios',
              emoji: '🧘‍♂️',
              nivel: 'Avanzado',
              onAdd: () => addRecommendedRoutine(
                2,
                'Rutina de Flexibilidad',
                '🧘‍♂️',
                'Flexibilidad',
                [
                  {'id': '1'},
                  {'id': '2'},
                  {'id': '3'},
                  {'id': '4'},
                  {'id': '5'},
                  {'id': '6'},
                  {'id': '7'},
                  {'id': '8'},
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class Listarecomendaciones extends StatelessWidget {
  final String nombre;
  final String ejercicios;
  final String emoji;
  final String nivel;
  final VoidCallback onAdd;

  const Listarecomendaciones({
    Key? key,
    required this.nombre,
    required this.ejercicios,
    required this.emoji,
    required this.nivel,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Color(0xFFF5ECE3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black12,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.red,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      ejercicios,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Nivel: $nivel',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: onAdd,
              child: Icon(
                Icons.add,
                size: 40,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
