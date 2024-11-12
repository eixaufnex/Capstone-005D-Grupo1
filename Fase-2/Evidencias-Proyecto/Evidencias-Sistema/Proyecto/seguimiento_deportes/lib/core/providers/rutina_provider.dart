import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/ejercicio.dart';
import 'package:seguimiento_deportes/core/models/rutina.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seguimiento_deportes/core/services/rutina_ejercicio_service.dart';

const urlapi = url; // Asegúrate de poner la URL correcta de la API

class RutinaProvider with ChangeNotifier {
  List<Rutina> rutinas = [];
  List<Ejercicio> ejerciciosDeRutina =
      []; // Lista de ejercicios de la rutina seleccionada
  final ApiService apiService = ApiService();

  RutinaProvider() {
    initializeUserRutinas();
  }

  // Inicializa las rutinas del usuario actual
  Future<void> initializeUserRutinas() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await getRutinaXUsuario(user.uid);
    } else {
      print("Error: No hay usuario autenticado.");
    }
  }

  // Obtener las rutinas del usuario por firebaseId
  Future<void> getRutinaXUsuario(String firebaseId) async {
    final url = Uri.http(urlapi, 'rutina/usuario/$firebaseId');
    try {
      final resp = await http.get(url, headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });

      if (resp.statusCode == 200) {
        rutinas = (json.decode(resp.body) as List)
            .map((data) => Rutina.fromJson(data))
            .toList();
        notifyListeners();
      } else if (resp.statusCode == 404) {
        print('No se encontraron rutinas para este usuario');
      } else {
        print('Error al obtener las rutinas: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al obtener rutinas: $e');
    }
  }

  // Crear una nueva rutina
  Future<int?> postRutina(
    String nombreRutina,
    String emoji,
    String firebaseId, {
    String? tipoRutina,
  }) async {
    final url = Uri.http(urlapi, 'rutina');
    try {
      final resp = await http.post(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": "true",
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'nombre_rutina': nombreRutina,
          'emoji': emoji,
          'firebase_id': firebaseId,
          'tipo_rutina': tipoRutina,
        }),
      );

      if (resp.statusCode == 201) {
        final responseData = jsonDecode(resp.body);
        int rutinaId = responseData['id_rutina'];
        await getRutinaXUsuario(firebaseId); // Refresca la lista de rutinas
        return rutinaId;
      } else {
        final errorResponse = jsonDecode(resp.body);
        print(
            'Error al crear la rutina: ${errorResponse['message'] ?? errorResponse}');
        return null;
      }
    } catch (e) {
      print('Error de conexión al crear rutina: $e');
      return null;
    }
  }

  // Obtener los ejercicios de una rutina específica usando el servicio
  Future<void> getEjerciciosDeRutina(int rutinaId) async {
    try {
      final ejerciciosData = await apiService.getEjerciciosByRutina(rutinaId);
      if (ejerciciosData != null) {
        ejerciciosDeRutina =
            ejerciciosData.map((data) => Ejercicio.fromJson(data)).toList();
      } else {
        ejerciciosDeRutina = [];
      }
      notifyListeners();
    } catch (e) {
      print("Error al obtener ejercicios de la rutina: $e");
    }
  }
}
