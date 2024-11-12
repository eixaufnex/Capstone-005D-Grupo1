import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/usuario.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

const urlapi = url;

class UsuarioProvider with ChangeNotifier {
  List<Usuario> usuarios = [];

  UsuarioProvider() {
    getUsuarios();
  }

  Future<void> getUsuarios() async {
    final url1 = Uri.http(urlapi, 'usuario');
    try {
      final resp = await http.get(url1, headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });

      if (resp.statusCode == 200) {
        usuarios = usuarioFromJson(resp.body);
        notifyListeners();
      } else {
        print('Error al obtener usuarios: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al obtener usuarios: $e');
    }
  }

  Future<String> getUsername(String firebaseId) async {
    final url = Uri.http(urlapi, 'usuario/$firebaseId');

    try {
      final resp = await http.get(url, headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        if (data is Map<String, dynamic>) {
          return data['username'] ?? 'Usuario no encontrado';
        } else {
          return 'Formato de respuesta inesperado';
        }
      } else {
        print('Error al obtener el usuario: ${resp.statusCode}');
        return 'Error al obtener el usuario';
      }
    } catch (e) {
      print('Error de conexión al obtener el usuario: $e');
      return 'Error de conexión';
    }
  }

  // Método para crear un nuevo usuario
  Future<bool> postUsuario(
      String email, String password, String username) async {
    final url = Uri.http(urlapi, 'usuario');

    try {
      // Crear usuario en Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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

      if (resp.statusCode == 201) {
        print('Usuario creado exitosamente');
        return true;
      } else if (resp.statusCode == 400) {
        print('Error: El nombre de usuario ya está en uso');
        return false;
      } else {
        final errorResponse = jsonDecode(resp.body);
        print(
            'Error al crear el usuario: ${errorResponse['message'] ?? errorResponse}');
        return false;
      }
    } catch (e) {
      print('Error de conexión al crear el usuario: $e');
      return false;
    }
  }

//función para guardar el firbase_id y el username de google.
  Future<bool> guardarUsuario(String firebaseId, String username) async {
    final url = Uri.http(urlapi, 'usuario');

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
          'firebase_id': firebaseId,
          'username': username,
        }),
      );

      if (resp.statusCode == 201) {
        print('Usuario guardado exitosamente');
        return true;
      } else if (resp.statusCode == 400) {
        print('Error: El nombre de usuario ya está en uso');
        return false;
      } else {
        final errorResponse = jsonDecode(resp.body);
        print(
            'Error al guardar el usuario: ${errorResponse['message'] ?? errorResponse}');
        return false;
      }
    } catch (e) {
      print('Error de conexión al guardar el usuario: $e');
      return false;
    }
  }

  Future<bool> checkIfUserExists(String firebaseId) async {
    final url = Uri.http(urlapi, 'usuario/$firebaseId');
    try {
      final resp = await http.get(url, headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });

      if (resp.statusCode == 200) {
        return true; // Usuario existe
      } else if (resp.statusCode == 404) {
        return false; // Usuario no existe
      } else {
        print('Error al verificar usuario: ${resp.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error de conexión al verificar usuario: $e');
      return false;
    }
  }
}