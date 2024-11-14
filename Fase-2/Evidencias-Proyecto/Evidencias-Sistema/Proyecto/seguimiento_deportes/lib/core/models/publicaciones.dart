import 'dart:convert';

// Convierte una cadena JSON a una lista de objetos Publicacion
List<Publicacion> publicacionFromJson(String str) =>
    List<Publicacion>.from(json.decode(str).map((x) => Publicacion.fromJson(x)));

// Convierte un objeto Publicacion a una cadena JSON
String publicacionToJson(Publicacion data) => json.encode(data.toJson());

class Publicacion {
  int idPublicacion;
  String firebaseId;
  String? descripcion;
  int likes;
  DateTime fechaCreacion;
  String usuario;
  bool userLiked; // Agregado para manejar los "likes" del usuario

  Publicacion({
    required this.idPublicacion,
    required this.firebaseId,
    this.descripcion,
    required this.likes,
    required this.fechaCreacion,
    required this.usuario,
    this.userLiked = false, // Valor por defecto para evitar nulos
  });

  // Convierte de JSON a un objeto Publicacion
  factory Publicacion.fromJson(Map<String, dynamic> json) => Publicacion(
        idPublicacion: json["id_publicacion"],
        firebaseId: json["firebase_id"],
        descripcion: json["descripcion"],
        likes: json["likes"],
        fechaCreacion: DateTime.parse(json["fecha_creacion"]),
        usuario: json["usuario"] ?? "Usuario desconocido",
        userLiked: json["userLiked"] ?? false, // Valor predeterminado si no está presente
      );

  // Convierte de un objeto Publicacion a JSON
  Map<String, dynamic> toJson() => {
        "id_publicacion": idPublicacion,
        "firebase_id": firebaseId,
        "descripcion": descripcion,
        "likes": likes,
        "fecha_creacion": fechaCreacion.toIso8601String(),
        "usuario": usuario,
        "userLiked": userLiked,
      };
}