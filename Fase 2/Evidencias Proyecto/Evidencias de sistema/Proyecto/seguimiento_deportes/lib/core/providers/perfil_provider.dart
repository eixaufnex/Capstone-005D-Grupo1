import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/perfil.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const urlapi = url;

class PerfilProvider with ChangeNotifier {
  List<Perfil> perfiles = [];
  bool isLoading = false;

  PerfilProvider() {
    getPerfiles();
  }

  Future<void> updateAvatar(String firebaseId, String avatarPath) async {
    final urlUpdateAvatar = Uri.https(urlapi, 'perfil/usuario/$firebaseId');

    try {
      // Crear el JSON que será enviado al servidor
      final body = json.encode({
        'foto_perfil': avatarPath,
      });

      // Hacer la solicitud HTTP PUT
      final resp = await http.put(
        urlUpdateAvatar,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      // Manejo de la respuesta
      if (resp.statusCode == 200) {
        final index =
            perfiles.indexWhere((perfil) => perfil.firebaseId == firebaseId);
        if (index != -1) {
          // Actualizar el avatar localmente en la lista
          perfiles[index].fotoPerfil = avatarPath;
          notifyListeners(); // Notificar a los widgets dependientes
          print('Avatar actualizado correctamente para $firebaseId');
        } else {
          print('Perfil no encontrado localmente para firebaseId: $firebaseId');
        }
      } else {
        print(
            'Error al actualizar el avatar en el servidor: ${resp.statusCode}');
        print('Respuesta del servidor: ${resp.body}');
      }
    } catch (e) {
      print('Error de conexión al actualizar el avatar: $e');
    }
  }

  Future<Perfil?> getPerfil(String firebaseId) async {
    final urlGetPerfil = Uri.https(urlapi, 'perfil/usuario/$firebaseId');
    try {
      final resp = await http.get(urlGetPerfil, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        return Perfil.fromJson(json.decode(resp.body));
      } else if (resp.statusCode == 404) {
        print('Perfil no encontrado: Código de estado ${resp.statusCode}');
        return null;
      } else {
        print('Error al obtener perfil: Código de estado ${resp.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error de conexión al obtener perfil: $e');
      return null;
    }
  }

  Future<void> getPerfiles() async {
    isLoading = true;
    notifyListeners();

    final url1 = Uri.https(urlapi, 'perfil');
    try {
      final resp = await http.get(url1, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        perfiles = perfilFromJson(resp.body);
      } else {
        print('Error al obtener perfiles: Código de estado ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al obtener perfiles: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createPerfil(Perfil nuevoPerfil) async {
    final urlCreate = Uri.https(urlapi, 'perfil');
    try {
      // JSON de los datos enviados para asegurarnos de que todos los campos tienen valores
      final jsonData = json.encode(nuevoPerfil.toJson());
      print("Datos JSON enviados al servidor: $jsonData");

      final resp = await http.post(
        urlCreate,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonData,
      );

      if (resp.statusCode == 201) {
        final createdPerfil = Perfil.fromJson(json.decode(resp.body));
        perfiles.add(createdPerfil);
        notifyListeners();
      } else {
        print(
            'Error al crear perfil en el servidor: Código de estado ${resp.statusCode}');
        print('Respuesta del servidor: ${resp.body}');
      }
    } catch (e) {
      print('Error de conexión al crear el perfil: $e');
    }
  }

  Future<void> deletePerfil(int idPerfil) async {
    final urlDelete = Uri.https(urlapi, 'perfil/$idPerfil');
    try {
      final resp = await http.delete(urlDelete);
      if (resp.statusCode == 200) {
        perfiles.removeWhere((perfil) => perfil.idPerfil == idPerfil);
        notifyListeners();
      } else {
        print('Error al eliminar perfil en el servidor: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al eliminar el perfil: $e');
    }
  }

  Future<void> updatePerfil(Perfil updatedPerfil) async {
    final urlUpdate = Uri.https(urlapi, 'perfil/${updatedPerfil.idPerfil}');
    try {
      final resp = await http.put(
        urlUpdate,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(updatedPerfil.toJson()),
      );

      if (resp.statusCode == 200) {
        final index = perfiles
            .indexWhere((perfil) => perfil.idPerfil == updatedPerfil.idPerfil);
        if (index != -1) {
          perfiles[index] = updatedPerfil;
          notifyListeners();
        }
      } else {
        print(
            'Error al actualizar el perfil en el servidor: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al actualizar el perfil: $e');
    }
  }
}
