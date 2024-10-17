import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/usuario.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;

const urlapi = url;

class Usuario_provider with ChangeNotifier{
    List<Usuario> usuarios = [];

    Usuario_provider(){
      getUsuarios();
    }


    getUsuarios() async{
        final url1 = Uri.http(urlapi,'usuario');
        final resp = await http.get(url1, headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": "true",
            'Content-type': 'application/json',
            'Accept':'application/json'
            });
            final response = usuarioFromJson(resp.body);

            usuarios = response;
            notifyListeners();
    }

  // Método para crear un nuevo usuario
  Future<bool> postUsuario(String email, String password) async {
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
          'email': email,
          'user_password': password,
        }),
      );
  
      //Manejo de errores
      if (resp.statusCode == 201) {
        // Usuario creado correctamente
        print('Usuario creado exitosamente');
        return true;

      } else if (resp.statusCode == 400) {
        // Manejo del error si el correo ya existe
        print('Error: El correo ya está en uso');
        return false;

      } else {
        // Manejo de otros errores
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


