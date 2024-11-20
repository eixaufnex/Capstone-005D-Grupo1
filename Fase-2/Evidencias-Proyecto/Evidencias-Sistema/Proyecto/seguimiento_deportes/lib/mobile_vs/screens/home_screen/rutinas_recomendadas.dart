import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';

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
          if ((tipoNivel == 'Principiante' || tipoNivel == 'Beginner') &&
              (!isRoutineExists('Rutina de Fuerza') && !isRoutineExists('Strength Routine')) &&
              !isRecommendedAddedList[0])
            Listarecomendaciones(
              nombre: S.current.rutinafuerza1,
              ejercicios: "5 ${S.current.ejercicios}",
              emoji: '💪',
              nivel: S.current.label_intensity1,
              onAdd: () => addRecommendedRoutine(
                0,
                S.current.rutinafuerza1, 
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

          if ((tipoNivel == 'Principiante' || tipoNivel == 'Beginner') &&
              (!isRoutineExists('Rutina de Cardio') && !isRoutineExists('Cardio Routine')) &&
              !isRecommendedAddedList[1])
            Listarecomendaciones(
              nombre: S.current.rutinacardio1,
              ejercicios: "6 ${S.current.ejercicios}",
              emoji: '🏃‍♂️',
              nivel: S.current.label_intensity1,
              onAdd: () => addRecommendedRoutine(
                1,
                S.current.rutinacardio1,
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

          if ((tipoNivel == 'Principiante' || tipoNivel == 'Beginner') &&
              (!isRoutineExists('Rutina de Flexibilidad') && !isRoutineExists('Flexibility Routine')) &&
              !isRecommendedAddedList[2])
            Listarecomendaciones(
              nombre: S.current.rutinaflexibilidad1,
              ejercicios: "6 ${S.current.ejercicios}",
              emoji: '🧘‍♂️',
              nivel: S.current.label_intensity1,
              onAdd: () => addRecommendedRoutine(
                2,
                S.current.rutinaflexibilidad1,
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

          if ((tipoNivel == 'Medio' ||  tipoNivel == 'Medium') &&
              (!isRoutineExists('Rutina de Fuerza') && !isRoutineExists('Strength Routine')) &&
              !isRecommendedAddedList[0])
            Listarecomendaciones(
              nombre: S.current.rutinafuerza1,
              ejercicios: "7 ${S.current.ejercicios}",
              emoji: '💪',
              nivel: S.current.label_intensity2,
              onAdd: () => addRecommendedRoutine(
                0,
                S.current.rutinafuerza1,
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

          if ((tipoNivel == 'Medio' ||  tipoNivel == 'Medium') &&
              (!isRoutineExists('Rutina de Cardio') && !isRoutineExists('Cardio Routine')) &&
              !isRecommendedAddedList[1])
            Listarecomendaciones(
              nombre: S.current.rutinacardio1,
              ejercicios: "2 ${S.current.ejercicios}",
              emoji: '🏃‍♂️',
              nivel: S.current.label_intensity2,
              onAdd: () => addRecommendedRoutine(
                1,
                S.current.rutinacardio1,
                '🏃‍♂️',
                'Cardiovascular',
                [
                  {'id': '1'},
                  {'id': '2'}
                ],
              ),
            ),

          if ((tipoNivel == 'Medio' ||  tipoNivel == 'Medium') &&
              (!isRoutineExists('Rutina de Flexibilidad') && !isRoutineExists('Flexibility Routine')) &&
              !isRecommendedAddedList[2])
            Listarecomendaciones(
              nombre: S.current.rutinaflexibilidad1,
              ejercicios: "3 ${S.current.ejercicios}",
              emoji: '🧘‍♂️',
              nivel: S.current.label_intensity2,
              onAdd: () => addRecommendedRoutine(
                2,
                S.current.rutinaflexibilidad1,
                '🧘‍♂️',
                'Flexibilidad',
                [
                  {'id': '1'},
                  {'id': '2'},
                  {'id': '3'}
                ],
              ),
            ),

          if ((tipoNivel == 'Avanzado' || tipoNivel == 'Advanced') &&
              (!isRoutineExists('Rutina de Fuerza') && !isRoutineExists('Strength Routine')) &&
              !isRecommendedAddedList[0])
            Listarecomendaciones(
              nombre: S.current.rutinafuerza1,
              ejercicios: "10 ${S.current.ejercicios}",
              emoji: '💪',
              nivel: S.current.label_intensity3,
              onAdd: () => addRecommendedRoutine(
                0,
                S.current.rutinafuerza1,
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

          if ((tipoNivel == 'Avanzado' || tipoNivel == 'Advanced') &&
              (!isRoutineExists('Rutina de Cardio') && !isRoutineExists('Cardio Routine')) &&
              !isRecommendedAddedList[1])
            Listarecomendaciones(
              nombre: S.current.rutinacardio1,
              ejercicios: "4 ${S.current.ejercicios}",
              emoji: '🏃‍♂️',
              nivel: S.current.label_intensity3,
              onAdd: () => addRecommendedRoutine(
                1,
                S.current.rutinacardio1,
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

          if ((tipoNivel == 'Avanzado' || tipoNivel == 'Advanced') &&
              (!isRoutineExists('Rutina de Flexibilidad') && !isRoutineExists('Flexibility Routine')) &&
              !isRecommendedAddedList[2])
            Listarecomendaciones(
              nombre: S.current.rutinaflexibilidad1,
              ejercicios: "8 ${S.current.ejercicios}",
              emoji: '🧘‍♂️',
              nivel: S.current.label_intensity3,
              onAdd: () => addRecommendedRoutine(
                2,
                S.current.rutinaflexibilidad1,
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
                      // "8 ${S.current.ejercicios}"
                      "${S.current.nivel}: $nivel",
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
