import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/rutina_detallada.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;

const urlapi = url;

class RutinaDetalladaProvider with ChangeNotifier {
  List<RutinaDetallada> rutinasDetalladas = [];

  RutinaDetalladaProvider() {
    getRutinasDetalladas();
  }

  Future<void> getRutinasDetalladas() async {
    final url = Uri.http(urlapi, 'rutinas_detalladas_ejercicios');
    try {
      final resp = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        final List<dynamic> data = jsonDecode(resp.body);
        rutinasDetalladas = data.map((json) => RutinaDetallada.fromJson(json)).toList();
        print("Rutinas detalladas cargadas: ${rutinasDetalladas.length}");
        notifyListeners();
      } else {
        print('Error al obtener rutinas detalladas con ejercicios: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al obtener rutinas detalladas con ejercicios: $e');
    }
  }

  Future<void> saveMultipleRutinasDetalladas(List<RutinaDetallada> rutinas) async {
    for (RutinaDetallada rutina in rutinas) {
      await postRutinaDetallada(rutina);
    }
    await getRutinasDetalladas();  // Actualizar la lista después del guardado
  }

  Future<RutinaDetallada?> getRutinaDetalladaById(int id) async {
    final url = Uri.http(urlapi, 'rutinas_detalladas/$id');
    try {
      final resp = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        return RutinaDetallada.fromJson(jsonDecode(resp.body));
      } else {
        print('Error al obtener la rutina detallada: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al obtener la rutina detallada: $e');
    }
    return null;
  }

  Future<bool> postRutinaDetallada(RutinaDetallada rutinaDetallada) async {
    final url = Uri.http(urlapi, 'rutinas_detalladas');
    try {
      final resp = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(rutinaDetallada.toJson()),
      );

      if (resp.statusCode == 201) {
        print('Rutina detallada creada exitosamente');
        await getRutinasDetalladas();  // Actualizar la lista
        return true;
      } else {
        print('Error al crear la rutina detallada: ${jsonDecode(resp.body)['message'] ?? resp.body}');
      }
    } catch (e) {
      print('Error de conexión al crear la rutina detallada: $e');
    }
    return false;
  }

  Future<bool> updateRutinaDetallada(int id, RutinaDetallada rutinaDetallada) async {
    final url = Uri.http(urlapi, 'rutinas_detalladas/$id');
    try {
      final resp = await http.put(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(rutinaDetallada.toJson()),
      );

      if (resp.statusCode == 200) {
        print('Rutina detallada actualizada exitosamente');
        await getRutinasDetalladas();  // Actualizar la lista
        return true;
      } else {
        print('Error al actualizar la rutina detallada: ${jsonDecode(resp.body)['message'] ?? resp.body}');
      }
    } catch (e) {
      print('Error de conexión al actualizar la rutina detallada: $e');
    }
    return false;
  }

  Future<bool> deleteRutinaDetallada(int id) async {
    final url = Uri.http(urlapi, 'rutinas_detalladas/$id');
    try {
      final resp = await http.delete(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        print('Rutina detallada eliminada exitosamente');
        await getRutinasDetalladas();  // Actualizar la lista
        return true;
      } else {
        print('Error al eliminar la rutina detallada: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al eliminar la rutina detallada: $e');
    }
    return false;
  }
}
