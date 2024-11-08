import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/objetivo.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;

const urlapi = url;

class ObjetivoProvider with ChangeNotifier {
  List<Objetivo> objetivos = [];
  bool isLoading = false; // Nueva propiedad para el estado de carga

  ObjetivoProvider() {
    getObjetivos();
  }

  Future<void> getObjetivos() async {
    isLoading = true; // Cambia el estado de carga a verdadero
    notifyListeners();

    final url1 = Uri.http(urlapi, 'objetivo'); // Asegúrate de que esta ruta sea la correcta
    try {
      final resp = await http.get(url1, headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });

      if (resp.statusCode == 200) {
        objetivos = objetivoFromJson(resp.body);
      } else {
        print('Error al obtener objetivos: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al obtener objetivos: $e');
    } finally {
      isLoading = false; // Cambia el estado de carga a falso
      notifyListeners(); // Notifica a los listeners del cambio de estado
    }
  }

  List<Objetivo> getObjetivosByTipo(String tipo) {
    return objetivos.where((obj) => obj.tipoObjetivo == tipo).toList();
  }

  Objetivo? getObjetivoById(int id) {
    try {
      return objetivos.firstWhere((objetivo) => objetivo.idObjetivo == id);
    } catch (e) {
      print('Objetivo con ID $id no encontrado');
      return null;
    }
  }
}
