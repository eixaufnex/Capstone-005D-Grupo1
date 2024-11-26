import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:seguimiento_deportes/core/constants.dart';

const urlapi = url; 

class ApiService {

    

  // Método para guardar los ejercicios a una rutina
  Future<bool> saveEjerciciosToRutina(
      int rutinaId, List<Map<String, String>> ejercicios) async {
    final uri = Uri.https(urlapi, 'rutina_ejercicio/agregar'); // Endpoint para agregar ejercicios a la rutina

    if (ejercicios.isEmpty) {
      print('Error: No hay ejercicios seleccionados');
      return false;
    }

    List<int> ejerciciosId = ejercicios.map((ejercicio) {
      return int.tryParse(ejercicio['id'] ?? '') ?? 0;
    }).toList();

    final body = json.encode({
      'id_rutina': rutinaId,
      'ejercicios_id': ejerciciosId,
    });

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print('Ejercicios agregados correctamente');
        return true;
      } else {
        print('Error al guardar la rutina: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return false;
    }
  }

  // Método para obtener los ejercicios de una rutina por su ID
  Future<List<Map<String, dynamic>>?> getEjerciciosByRutina(
      int rutinaId) async {
    final uri = Uri.https(urlapi, 'rutina/$rutinaId/ejercicios');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Asegúrate de que los datos tienen 'id_lista_ejercicio' como int
        List<Map<String, dynamic>> ejercicios = data
            .map((item) => Map<String, dynamic>.from(item))
            .where((item) => item['id_lista_ejercicio'] != null)
            .toList();
        return ejercicios;
      } else {
        print('Error al obtener ejercicios de la rutina: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return null;
    }
  }

  // Método para eliminar un ejercicio de una rutina
  Future<bool> deleteEjercicioFromRutina(int rutinaId, int ejercicioId) async {
    final uri = Uri.https(urlapi, 'rutina/$rutinaId/ejercicio/$ejercicioId'); // Endpoint para eliminar el ejercicio de la rutina

    try {
      final response = await http.delete(uri);

      // Verificar si la respuesta es exitosa (código 200)
      if (response.statusCode == 200) {
        print('Ejercicio eliminado correctamente');
        return true;
      } else {
        print('Error al eliminar el ejercicio: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return false;
    }
  }


// Método para obtener las rutinas y ejercicios de un usuario por su firebase_id
  Future<List<Map<String, dynamic>>?> getRutinasAndEjerciciosByUser(
      String firebaseId) async {
    final uri = Uri.https(urlapi, 'usuario/$firebaseId/rutinas'); // Endpoint para obtener rutinas y ejercicios por firebase_id

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Convertir la lista dinámica en una lista de mapas para mayor facilidad de uso
        List<Map<String, dynamic>> rutinas = data.map((item) {
          return Map<String, dynamic>.from(item);
        }).toList();
        return rutinas;
      } else {
        print('Error al obtener rutinas y ejercicios: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return null;
    }
  }
}
