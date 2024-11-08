import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/ejercicio.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;

const urlapi = url;

class Ejercicio_Provider with ChangeNotifier {
  List<Ejercicio> ejercicios = [];

  Ejercicio_Provider() {
    getEjercicios();
  }

  Future<void> getEjercicios() async {
    final url1 = Uri.http(urlapi, 'lista_ejercicio');
    try {
      final resp = await http.get(url1, headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });

      if (resp.statusCode == 200) {
        ejercicios = ejercicioFromJson(resp.body);
        notifyListeners();
      } else {
        print('Error al obtener ejercicios: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al obtener ejercicios: $e');
    }
  }

  List<Ejercicio> getExercisesByDifficulty(String dificultad) {
    return ejercicios.where((ej) => ej.dificultadEjercicio == dificultad).toList();
  }

  Ejercicio getEjercicioById(int id) {
    return ejercicios.firstWhere((ejercicio) => ejercicio.idListaEjercicio == id);
  }
}
