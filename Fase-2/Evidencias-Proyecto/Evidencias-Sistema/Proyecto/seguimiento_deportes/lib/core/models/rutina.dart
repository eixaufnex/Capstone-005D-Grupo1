import 'dart:convert';

// Función para convertir un string JSON a una lista de objetos Rutina
List<Rutina> rutinaFromJson(String str) => List<Rutina>.from(
    json.decode(str).map((x) => Rutina.fromJson(x)));

// Función para convertir una lista de objetos Rutina a un string JSON
String rutinaToJson(List<Rutina> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rutina {
  final int idRutina;
  final String nombreRutina;
  final String emoji;
  final String firebaseId;
  final String? tipoRutina; // Tipo opcional, puede ser null

  Rutina({
    required this.idRutina,
    required this.nombreRutina,
    required this.emoji,
    required this.firebaseId,
    this.tipoRutina,
  });

  // Crear un objeto Rutina a partir de un Map
  factory Rutina.fromJson(Map<String, dynamic> json) => Rutina(
        idRutina: json["id_rutina"],
        nombreRutina: json["nombre_rutina"],
        emoji: json["emoji"],
        firebaseId: json["firebase_id"],
        tipoRutina: json["tipo_rutina"] ?? null, // Maneja null de manera explícita
      );

  // Convertir el objeto Rutina a un Map
  Map<String, dynamic> toJson() => {
        "id_rutina": idRutina,
        "nombre_rutina": nombreRutina,
        "emoji": emoji,
        "firebase_id": firebaseId,
        "tipo_rutina": tipoRutina ?? null, // Si es null, se manejará correctamente
      };
}
