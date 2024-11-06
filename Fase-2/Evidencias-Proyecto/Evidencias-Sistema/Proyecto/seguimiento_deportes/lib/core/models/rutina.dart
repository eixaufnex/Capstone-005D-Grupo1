import 'dart:convert';

List<Rutina> rutinaFromJson(String str) => List<Rutina>.from(json.decode(str).map((x) => Rutina.fromJson(x)));

String rutinaToJson(List<Rutina> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rutina {
    int idRutina;
    String nombreRutina;
    String emoji;
    String firebase_id;

    Rutina({
        required this.idRutina,
        required this.nombreRutina,
        required this.emoji,
        required this.firebase_id,
    });

    factory Rutina.fromJson(Map<String, dynamic> json) => Rutina(
        idRutina: json["id_rutina"],
        nombreRutina: json["nombre_rutina"],
        emoji: json["emoji"],
        firebase_id: json["firebase_id"],
    );

    Map<String, dynamic> toJson() => {
        "id_rutina": idRutina,
        "nombre_rutina": nombreRutina,
        "emoji": emoji,
        "firebase_id": firebase_id,
    };
}
