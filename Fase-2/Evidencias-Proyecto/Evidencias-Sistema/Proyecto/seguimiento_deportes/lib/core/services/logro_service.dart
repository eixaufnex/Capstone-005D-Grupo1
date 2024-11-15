import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:seguimiento_deportes/core/constants.dart';

const urlapi = url; // Define la URL de la API aquí

// Verificar si el usuario tiene al menos una rutina creada
Future<void> verificarLogroCrearRutina(String firebaseId) async {
  try {
    final url = Uri.http(urlapi, 'rutina/usuario/$firebaseId');
    final resp = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    if (resp.statusCode == 200) {
      final List rutinas = json.decode(resp.body);
      if (rutinas.isNotEmpty) {
        // Verificar si el logro ya existe antes de intentar registrarlo
        bool logroExiste = await existeLogro(firebaseId, 1); // ID del logro
        if (!logroExiste) {
          await registrarLogro(firebaseId, 1); // Registrar logro
        } else {
          print(
              'El logro "crear una rutina" ya existe y no será registrado nuevamente.');
        }
      }
    } else {
      print('Error al verificar rutinas: ${resp.statusCode}');
    }
  } catch (e) {
    print('Error de conexión al verificar rutinas: $e');
  }
}

// Verificar si el usuario tiene al menos un objetivo creado
Future<void> verificarLogroCrearObjetivo(String firebaseId) async {
  try {
    final url = Uri.http(urlapi, 'objetivo/usuario/$firebaseId');
    final resp = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    if (resp.statusCode == 200) {
      final List objetivos = json.decode(resp.body);
      if (objetivos.isNotEmpty) {
        // Verificar si el logro ya existe antes de registrarlo
        bool logroExiste = await existeLogro(
            firebaseId, 2); // ID del logro para crear un objetivo
        if (!logroExiste) {
          await registrarLogro(firebaseId, 2); // Registrar logro
        } else {
          print(
              'El logro "crear un objetivo" ya existe y no será registrado nuevamente.');
        }
      } else {
        print('El usuario no tiene objetivos creados, no se asignará logro.');
      }
    } else {
      print('Error al verificar objetivos: ${resp.statusCode}');
    }
  } catch (e) {
    print('Error de conexión al verificar objetivos: $e');
  }
}

Future<void> verificarLogroCrearPublicacion(String firebaseId) async {
  try {
    final url = Uri.http(urlapi, 'publicacion/usuario/$firebaseId');
    final resp = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    if (resp.statusCode == 200) {
      final List publicaciones = json.decode(resp.body);
      if (publicaciones.isNotEmpty) {
        // Verificar si el logro ya existe antes de registrarlo
        bool logroExiste = await existeLogro(
            firebaseId, 3); // ID del logro "crear publicación"
        if (!logroExiste) {
          await registrarLogro(firebaseId, 3); // Registrar logro
        } else {
          print(
              'El logro "crear una publicación" ya existe y no será registrado nuevamente.');
        }
      } else {
        print(
            'El usuario no tiene publicaciones creadas, no se asignará logro.');
      }
    } else {
      print('Error al verificar publicaciones: ${resp.statusCode}');
    }
  } catch (e) {
    print('Error de conexión al verificar publicaciones: $e');
  }
}

// Verificar si el logro ya existe para el usuario en la base de datos
Future<bool> existeLogro(String firebaseId, int idLogroGlobal) async {
  final url = Uri.http(urlapi, 'logros-obtenidos/$firebaseId/$idLogroGlobal');

  try {
    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      final logroExiste = data.isNotEmpty; // Si hay datos, el logro ya existe
      print(logroExiste
          ? 'El logro con ID $idLogroGlobal ya existe para el usuario $firebaseId'
          : 'El logro con ID $idLogroGlobal no existe para el usuario $firebaseId');
      return logroExiste;
    } else {
      print('Error al verificar existencia del logro: ${resp.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error de conexión al verificar logro existente: $e');
    return false;
  }
}

// Registrar el logro obtenido en la base de datos
Future<void> registrarLogro(String firebaseId, int idLogroGlobal) async {
  final url = Uri.http(urlapi, 'logros-obtenidos');

  try {
    final resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        "firebase_id": firebaseId,
        "id_logro_global": idLogroGlobal,
        "fecha_obtencion": DateTime.now().toIso8601String(),
      }),
    );

    if (resp.statusCode == 201) {
      print('Logro registrado con éxito');
    } else {
      print('Error al registrar logro: Código de estado ${resp.statusCode}');
    }
  } catch (e) {
    print('Error de conexión al registrar logro: $e');
  }
}
