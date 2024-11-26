import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seguimiento_deportes/core/services/rutina_ejercicio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:seguimiento_deportes/core/models/publicaciones.dart';
import 'package:seguimiento_deportes/core/constants.dart'; // Donde está urlapi

const urlapi = url;

class PublicacionesProvider with ChangeNotifier {
  List<Publicacion> publicaciones = [];
  List<Map<String, dynamic>> rutinas = []; // Rutinas con ejercicios
  List<Map<String, dynamic>> soloRutinas = []; // Solo rutinas sin ejercicios
  bool isLoading = false;
  Map<int, bool> likedPublications = {}; // Estado de likes por publicación

  // Obtener rutinas y ejercicios del usuario autenticado
  Future<void> getRutinasAndEjercicios(String firebaseId) async {
    isLoading = true;
    notifyListeners();

    try {
      final result =
          await ApiService().getRutinasAndEjerciciosByUser(firebaseId);
      if (result != null) {
        rutinas = result; // Asegúrate de que result tenga el formato esperado
      } else {
        rutinas = [];
      }
    } catch (e) {
      print('Error al obtener rutinas y ejercicios: $e');
      rutinas = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }



  // Obtener publicaciones del servidor
  Future<void> getPublicaciones(String userId) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(urlapi, 'publicacion');
    try {
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        publicaciones = publicacionFromJson(resp.body);

        // Verifica si el usuario ha dado like y actualiza el estado
        await loadLikesFromPreferences(userId);
      } else {
        print('Error al obtener publicaciones: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al obtener publicaciones: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Cargar likes de publicaciones desde preferencias locales
  Future<void> loadLikesFromPreferences(String userId) async {
    final prefs = await SharedPreferences.getInstance();

    likedPublications = {};
    for (var publicacion in publicaciones) {
      final key = 'like_${userId}_${publicacion.idPublicacion}';
      likedPublications[publicacion.idPublicacion] =
          prefs.getBool(key) ?? false;
    }
  }

  // Alternar estado de like en una publicación
  Future<void> toggleLike(int idPublicacion, String userId) async {
    final alreadyLiked = likedPublications[idPublicacion] ?? false;
    final url = Uri.https(urlapi, 'publicacion/$idPublicacion/${alreadyLiked ? 'unlike' : 'like'}');

    try {
      final resp = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        likedPublications[idPublicacion] = !alreadyLiked;

        // Guardar estado de "me gusta" en preferencias
        await saveLikeToPreferences(
            idPublicacion, userId, likedPublications[idPublicacion]!);

        // Actualiza el contador de likes en el objeto
        final index = publicaciones
            .indexWhere((pub) => pub.idPublicacion == idPublicacion);
        if (index != -1) {
          publicaciones[index].likes += alreadyLiked ? -1 : 1;
        }
      } else {
        print('Error al cambiar estado de like: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al cambiar estado de like: $e');
    } finally {
      notifyListeners();
    }
  }

  // Guardar estado de likes en SharedPreferences
  Future<void> saveLikeToPreferences(
      int idPublicacion, String userId, bool liked) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'like_${userId}_$idPublicacion';
    prefs.setBool(key, liked);
  }

  // Crear una nueva publicación
  Future<void> createPublicacion(String firebaseId,
      {String? descripcion}) async {
    final url = Uri.https(urlapi, 'publicacion');
    final body = {
      "firebase_id": firebaseId,
      "descripcion": descripcion ?? "",
    };

    try {
      final resp = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(body),
      );

      if (resp.statusCode == 201) {
        final nuevaPublicacion = Publicacion.fromJson(jsonDecode(resp.body));
        publicaciones.insert(0, nuevaPublicacion);
      } else {
        print('Error al crear publicación: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error al crear publicación: $e');
    } finally {
      notifyListeners();
    }
  }

  // Eliminar una publicación
  Future<void> deletePublicacion(int idPublicacion) async {
    final urlDelete = Uri.https(urlapi, 'publicacion/$idPublicacion');
    try {
      final resp = await http.delete(urlDelete);
      if (resp.statusCode == 200) {
        publicaciones.removeWhere((obj) => obj.idPublicacion == idPublicacion);
      } else {
        print('Error al eliminar publicación: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error al eliminar publicación: $e');
    } finally {
      notifyListeners();
    }
  }
}
