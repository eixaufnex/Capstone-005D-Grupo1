import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/ejercicio.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Asegúrate de importar esta librería para manejar JSON

const urlapi = url;

class EjercicioProvider with ChangeNotifier {
  List<Ejercicio> ejercicios = [];
  List<Ejercicio> ejerciciosSeleccionados =
      []; // Lista para los ejercicios seleccionados
  bool isLoading = true; // Controla el estado de carga

  EjercicioProvider() {
    getEjercicios();
  }

  // Método para obtener la lista completa de ejercicios desde la API
  Future<void> getEjercicios() async {
    final url1 = Uri.http(urlapi, 'lista_ejercicio');
    try {
      final resp = await http.get(url1, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        final List<dynamic> data =
            json.decode(resp.body); // Decodifica la respuesta JSON
        if (data.isNotEmpty) {
          ejercicios =
              data.map((ejercicio) => Ejercicio.fromJson(ejercicio)).toList();
          isLoading = false;
          notifyListeners();
        } else {
          print('No se encontraron ejercicios');
          isLoading = false;
          notifyListeners();
        }
      } else {
        print('Error al obtener ejercicios: ${resp.statusCode}');
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Error de conexión al obtener ejercicios: $e');
      isLoading = false;
      notifyListeners();
    }
  }

  // Método para obtener un ejercicio por su ID
  Ejercicio getEjercicioById(int idListaEjercicio) {
    return ejercicios.firstWhere(
        (ejercicio) => ejercicio.idListaEjercicio == idListaEjercicio,
        orElse: () => throw Exception('Ejercicio no encontrado'));
  }

  // Método para filtrar ejercicios por dificultad
  List<Ejercicio> getExercisesByDifficulty(String dificultad) {
    return ejercicios
        .where((ej) => ej.dificultadEjercicio == dificultad)
        .toList();
  }

  // Método para filtrar ejercicios por tipo de ejercicio
  List<Ejercicio> getExercisesByType(String tipoEjercicio) {
    return ejercicios.where((ej) => ej.tipoEjercicio == tipoEjercicio).toList();
  }

  // Método para añadir un ejercicio a la lista de ejercicios seleccionados
  void addEjercicioToSelected(Ejercicio ejercicio) {
    if (!ejerciciosSeleccionados.contains(ejercicio)) {
      ejerciciosSeleccionados.add(ejercicio);
      notifyListeners();
    }
  }

  // Método para eliminar un ejercicio de la lista de ejercicios seleccionados
  void removeEjercicioFromSelected(Ejercicio ejercicio) {
    ejerciciosSeleccionados.remove(ejercicio);
    notifyListeners();
  }

  // Método para obtener los ejercicios seleccionados
  List<Ejercicio> getSelectedEjercicios() {
    return ejerciciosSeleccionados;
  }

}
