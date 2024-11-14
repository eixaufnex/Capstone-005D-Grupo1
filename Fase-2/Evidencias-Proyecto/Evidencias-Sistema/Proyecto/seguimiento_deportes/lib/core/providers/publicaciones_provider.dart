import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:seguimiento_deportes/core/models/publicaciones.dart';
import 'package:seguimiento_deportes/core/constants.dart'; // Donde está urlapi

const urlapi = url;

class PublicacionesProvider with ChangeNotifier {
  List<Publicacion> publicaciones = [];
  bool isLoading = false;
  Map<int, bool> likedPublications = {}; // Estado de likes de publicaciones por usuario

  Future<void> getPublicaciones(String userId) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(urlapi, '/publicacion');
    try {
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        publicaciones = publicacionFromJson(resp.body);

        // Verifica si el usuario ha dado like y actualiza el estado
        for (var publicacion in publicaciones) {
          likedPublications[publicacion.idPublicacion] = await hasUserLiked(userId, publicacion.idPublicacion);
        }

        notifyListeners();
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

  Future<bool> hasUserLiked(String userId, int idPublicacion) async {
    final url = Uri.http(urlapi, '/publicacion/$idPublicacion/has_liked/$userId');
    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (resp.statusCode == 200) {
      return jsonDecode(resp.body)['liked'];
    } else {
      print('Error al verificar estado de like: ${resp.statusCode}');
      return false;
    }
  }

  Future<void> toggleLike(int idPublicacion, String userId) async {
    final alreadyLiked = likedPublications[idPublicacion] ?? false;
    final url = Uri.http(urlapi, '/publicacion/$idPublicacion/${alreadyLiked ? 'unlike' : 'like'}');

    try {
      final resp = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (resp.statusCode == 200) {
        // Cambiar el estado de "like" en el mapa
        likedPublications[idPublicacion] = !alreadyLiked;

        // Actualiza el contador de likes directamente en el objeto de la lista
        final publicacionIndex = publicaciones.indexWhere((pub) => pub.idPublicacion == idPublicacion);
        if (publicacionIndex != -1) {
          publicaciones[publicacionIndex].likes += alreadyLiked ? -1 : 1;
        }

        notifyListeners();
      } else {
        print('Error al cambiar el estado de like: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al cambiar estado de like: $e');
    }
  }

  Future<void> createPublicacion(String firebaseId, {String? descripcion}) async {
    final url = Uri.http(urlapi, '/publicacion');
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
        notifyListeners();
      } else {
        print('Error al crear la publicación: ${resp.statusCode}');
        print('Respuesta del servidor: ${resp.body}');
      }
    } catch (e) {
      print('Error de conexión al crear publicación: $e');
    }
  }

  Future<void> deletePublicacion(int idPublicacion) async {
    final urlDelete = Uri.http(urlapi, '/publicacion/$idPublicacion');
    try {
      final resp = await http.delete(urlDelete);
      if (resp.statusCode == 200) {
        publicaciones.removeWhere((obj) => obj.idPublicacion == idPublicacion);
        notifyListeners();
      } else {
        print('Error al eliminar objetivo en el servidor: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error de conexión al eliminar el objetivo: $e');
    }
  }
}
