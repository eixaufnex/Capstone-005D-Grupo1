import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/rutina.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

const urlapi = url;

class Rutina_provider with ChangeNotifier {
  List<Rutina> rutina = [];

  Rutina_provider() {
    _initializeUserRutinas();
  }

  Future<void> _initializeUserRutinas() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await getRutinaXUsuario(user.uid);
    } else {
      print("Error: No hay usuario autenticado.");
    }
  }

  Future<void> getRutinaXUsuario(String firebase_id) async {
    final url = Uri.http(urlapi, 'rutina/usuario/$firebase_id');
    try {
      final resp = await http.get(url, headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });

      if (resp.statusCode == 200) {
        rutina = rutinaFromJson(resp.body);
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

  Future<int?> postRutina(
      String nombreRutina, String emoji, String firebase_id) async {
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
          'firebase_id': firebase_id,
        }),
      );

      if (resp.statusCode == 201) {
        final responseData = jsonDecode(resp.body);
        int rutinaId = responseData['id_rutina']; // Asegúrate de que el servidor devuelve el ID
        await getRutinaXUsuario(firebase_id); // Refresca la lista de rutinas
        return rutinaId;
      } else if (resp.statusCode == 400) {
        print('Error: La rutina ya existe');
        return null;
      } else {
        final errorResponse = jsonDecode(resp.body);
        print('Error al crear la rutina: ${errorResponse['message'] ?? errorResponse}');
        return null;
      }
    } catch (e) {
      print('Error de conexión al crear rutina: $e');
      return null;
    }
  }
}
