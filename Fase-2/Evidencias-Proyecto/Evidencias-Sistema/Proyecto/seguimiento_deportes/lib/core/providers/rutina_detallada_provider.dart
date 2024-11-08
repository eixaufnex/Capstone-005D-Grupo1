import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:seguimiento_deportes/core/models/rutina_detallada.dart';
import 'package:seguimiento_deportes/core/constants.dart';

const urlapi = url;

class RutinaDetalladaProvider with ChangeNotifier {
  List<RutinaDetallada> rutinaDetallada = [];

  // Obtener todas las rutinas detalladas
  Future<void> getRutinasDetalladas() async {
    final url = Uri.http(urlapi, 'rutina_detallada');
    try {
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      if (resp.statusCode == 200) {
        rutinaDetallada = rutinaDetalladaFromJson(resp.body);
        notifyListeners(); // Notificar a los oyentes sobre el cambio en el estado
      } else {
        print('Error al obtener rutinas detalladas: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al obtener rutinas detalladas: $e');
    }
  }

  // Crear una nueva rutina detallada
  Future<int?> postRutinaDetallada(RutinaDetallada rutina) async {
    final url = Uri.http(urlapi, 'rutina_detallada');
    try {
      final resp = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(rutina.toJson()),
      );

      if (resp.statusCode == 201) {
        final responseData = jsonDecode(resp.body);
        await getRutinasDetalladas(); // Refresca la lista de rutinas
        return responseData['id_rutina_detallada'];
      } else {
        print('Error al crear la rutina detallada: ${resp.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error de conexión al crear rutina detallada: $e');
      return null;
    }
  }

  // Actualizar una rutina detallada
  Future<void> updateRutinaDetallada(RutinaDetallada rutina) async {
    final url = Uri.http(urlapi, 'rutina_detallada/${rutina.idRutinaDetallada}');
    try {
      final resp = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(rutina.toJson()),
      );

      if (resp.statusCode == 200) {
        await getRutinasDetalladas(); // Refresca la lista de rutinas
      } else {
        print('Error al actualizar la rutina detallada: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al actualizar rutina detallada: $e');
    }
  }

  // Eliminar una rutina detallada
  Future<void> deleteRutinaDetallada(int id) async {
    final url = Uri.http(urlapi, 'rutina_detallada/$id');
    try {
      final resp = await http.delete(url);

      if (resp.statusCode == 200) {
        await getRutinasDetalladas(); // Refresca la lista de rutinas
      } else {
        print('Error al eliminar la rutina detallada: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al eliminar rutina detallada: $e');
    }
  }
}
