import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/usuario.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

const urlapi = url;

class Usuario_provider with ChangeNotifier {
  List<Usuario> usuarios = [];

  Usuario_provider() {
    getUsuarios();
  }

  Future<void> getUsuarios() async {
    final url1 = Uri.http(urlapi, 'usuario');
    final resp = await http.get(url1, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
    final response = usuarioFromJson(resp.body);

    usuarios = response;
    notifyListeners();
  }

  Future<String> getUsername(String firebaseId) async {
  final url = Uri.http(urlapi, 'usuario', {'firebase_id': firebaseId});

  try {
    final resp = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);
      // Asegúrate de que 'username' sea una clave válida en el objeto de respuesta
      if (data is List && data.isNotEmpty) {
        return data[0]['username'] ?? 'Usuario no encontrado'; // Asegúrate de acceder correctamente a la estructura
      } else if (data is Map) {
        return data['username'] ?? 'Usuario no encontrado';
      } else {
        return 'Formato de respuesta inesperado';
      }
    } else {
      print('Error al obtener el usuario: ${resp.statusCode}');
      return 'Error al obtener el usuario';
    }
  } catch (e) {
    print('Error de conexión: $e');
    return 'Error de conexión';
  }
}

  // Método para crear un nuevo usuario
  Future<bool> postUsuario(String email, String password, String username) async {
    final url = Uri.http(urlapi, 'usuario');

    try {
      // Crear usuario en Firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Obtener el ID de Firebase
      String firebaseId = userCredential.user!.uid;

      // Enviar el username y el firebaseId a tu servidor SQL
      final resp = await http.post(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": "true",
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'firebase_id': firebaseId,
          'username': username,
        }),
      );

      // Manejo de errores
      if (resp.statusCode == 201) {
        print('Usuario creado exitosamente');
        return true;
      } else if (resp.statusCode == 400) {
        print('Error: El correo ya está en uso');
        return false;
      } else {
        final errorResponse = jsonDecode(resp.body);
        print('Error al crear el usuario: ${errorResponse['message'] ?? errorResponse}');
        return false; 
      }
    } catch (e) {
      print('Error de conexión: $e');
      return false;
    }
  }
}
