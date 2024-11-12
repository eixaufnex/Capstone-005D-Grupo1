import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/objetivo.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const urlapi = url;

class ObjetivoProvider with ChangeNotifier {
  List<Objetivo> objetivos = [];
  bool isLoading = false;

  ObjetivoProvider() {
    getObjetivos();
  }

  Future<void> getObjetivos() async {
    isLoading = true;
    notifyListeners();

    final url1 = Uri.http(urlapi, 'objetivo');
    try {
      final resp = await http.get(url1, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        objetivos = objetivoFromJson(resp.body);
      } else {
        print('Error al obtener objetivos: Código de estado ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al obtener objetivos: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<Objetivo> get objetivosEnProgreso {
    return objetivos.where((objetivo) {
      final progreso = (objetivo.valorActual - objetivo.valorInicial) /
          (objetivo.valorObjetivo - objetivo.valorInicial) * 100;
      return progreso > 1 && progreso < 99;
    }).toList();
  }

  List<Objetivo> get objetivosCompletados {
    return objetivos.where((objetivo) {
      final progreso = (objetivo.valorActual - objetivo.valorInicial) /
          (objetivo.valorObjetivo - objetivo.valorInicial) * 100;
      return progreso >= 99;
    }).toList();
  }

  List<Objetivo> get objetivosSinComenzar {
    return objetivos.where((objetivo) {
      final progreso = (objetivo.valorActual - objetivo.valorInicial) /
          (objetivo.valorObjetivo - objetivo.valorInicial) * 100;
      return progreso <= 1;
    }).toList();
  }

  Future<void> createObjetivo(Objetivo nuevoObjetivo) async {
    final urlCreate = Uri.http(urlapi, 'objetivo');
    try {
      final resp = await http.post(
        urlCreate,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(nuevoObjetivo.toJson()),
      );

      if (resp.statusCode == 201) {
        final createdObjetivo = Objetivo.fromJson(json.decode(resp.body));
        objetivos.add(createdObjetivo);
        notifyListeners();
      } else {
        print('Error al crear objetivo en el servidor: Código de estado ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al crear el objetivo: $e');
    }
  }

  Future<void> deleteObjetivo(int idObjetivo) async {
    final urlDelete = Uri.http(urlapi, 'objetivo/$idObjetivo');
    try {
      final resp = await http.delete(urlDelete);
      if (resp.statusCode == 200) {
        objetivos.removeWhere((obj) => obj.idObjetivo == idObjetivo);
        notifyListeners();
      } else {
        print('Error al eliminar objetivo en el servidor: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al eliminar el objetivo: $e');
    }
  }

  Future<void> updateValorActual(int idObjetivo, int nuevoValor) async {
    final objetivo = objetivos.firstWhere((obj) => obj.idObjetivo == idObjetivo);
    objetivo.valorActual = nuevoValor;
    notifyListeners();

    final urlUpdate = Uri.http(urlapi, 'objetivo/$idObjetivo');
    try {
      final resp = await http.put(
        urlUpdate,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'id_objetivo': idObjetivo,
          'tipo_objetivo': objetivo.tipoObjetivo,
          'nombre_objetivo': objetivo.nombreObjetivo,
          'descripcion_objetivo': objetivo.descripcionObjetivo,
          'valor_inicial': objetivo.valorInicial,
          'valor_actual': nuevoValor,
          'valor_objetivo': objetivo.valorObjetivo,
          'fecha_limite': objetivo.fechaLimite.toIso8601String(),
          'alcanzado': objetivo.alcanzado,
          'firebase_id': objetivo.firebaseId,
        }),
      );

      if (resp.statusCode != 200) {
        print('Error al actualizar el objetivo en el servidor: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al actualizar el objetivo: $e');
    }
  }
}
