import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/logro.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const urlapi = url;

class LogroProvider with ChangeNotifier {
  List<LogroGlobal> logrosGlobales = [];
  List<LogroObtenido> logrosObtenidos = [];
  bool isLoading = false;

  LogroProvider() {
    getLogrosGlobales();
  }

  // Obtener logros globales
  Future<void> getLogrosGlobales() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(urlapi, 'logros-globales');
    try {
      final resp = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        logrosGlobales = logroGlobalFromJson(resp.body);
      } else {
        print(
            'Error al obtener logros globales: Código de estado ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al obtener logros globales: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Obtener logros obtenidos por usuario
  Future<void> getLogrosObtenidos(String firebaseId) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(urlapi, 'logros-obtenidos/$firebaseId');
    print("Fetching logros obtenidos for user: $firebaseId"); // Debugging
    try {
      final resp = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        logrosObtenidos = logroObtenidoFromJson(resp.body);
        print(
            "Fetched logros obtenidos: ${logrosObtenidos.length}"); // Debugging
      } else {
        print(
            'Error al obtener logros obtenidos: Código de estado ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al obtener logros obtenidos: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Crear un logro global
  Future<void> createLogroGlobal(LogroGlobal nuevoLogroGlobal) async {
    final urlCreate = Uri.http(urlapi, 'logros-globales');
    try {
      final resp = await http.post(
        urlCreate,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(nuevoLogroGlobal.toJson()),
      );

      if (resp.statusCode == 201) {
        final createdLogroGlobal = LogroGlobal.fromJson(json.decode(resp.body));
        logrosGlobales.add(createdLogroGlobal);
        notifyListeners();
      } else {
        print(
            'Error al crear logro global: Código de estado ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al crear logro global: $e');
    }
  }

  // Eliminar un logro global
  Future<void> deleteLogroGlobal(int idLogroGlobal) async {
    final urlDelete = Uri.http(urlapi, 'logros-globales/$idLogroGlobal');
    try {
      final resp = await http.delete(urlDelete);

      if (resp.statusCode == 200) {
        logrosGlobales
            .removeWhere((logro) => logro.idLogroGlobal == idLogroGlobal);
        notifyListeners();
      } else {
        print('Error al eliminar logro global: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al eliminar logro global: $e');
    }
  }

  // Registrar logro obtenido por el usuario
  Future<void> registrarLogroObtenido(LogroObtenido nuevoLogroObtenido) async {
    final urlCreate = Uri.http(urlapi, 'logros-obtenidos');
    try {
      final resp = await http.post(
        urlCreate,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(nuevoLogroObtenido.toJson()),
      );

      if (resp.statusCode == 201) {
        logrosObtenidos.add(nuevoLogroObtenido);
        notifyListeners();
      } else {
        print(
            'Error al registrar logro obtenido: Código de estado ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al registrar logro obtenido: $e');
    }
  }
}
