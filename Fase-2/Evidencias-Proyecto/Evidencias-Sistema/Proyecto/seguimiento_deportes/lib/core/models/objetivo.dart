import 'dart:convert';

// Funciones para manejar la conversión de JSON a Objetivo y viceversa
List<Objetivo> objetivoFromJson(String str) =>
    List<Objetivo>.from(json.decode(str).map((x) => Objetivo.fromJson(x)));

String objetivoToJson(List<Objetivo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Objetivo {
  int idObjetivo;
  String tipoObjetivo;
  String nombreObjetivo;
  String? descripcionObjetivo;
  int valorInicial;
  int valorActual;
  int valorObjetivo;
  DateTime fechaLimite;
  String alcanzado;
  String firebaseId;

  Objetivo({
    required this.idObjetivo,
    required this.tipoObjetivo,
    required this.nombreObjetivo,
    this.descripcionObjetivo,
    required this.valorInicial,
    required this.valorActual,
    required this.valorObjetivo,
    required this.fechaLimite,
    required this.alcanzado,
    required this.firebaseId,
  });

  // Método para crear un Objetivo a partir de un JSON
  factory Objetivo.fromJson(Map<String, dynamic> json) => Objetivo(
        idObjetivo: json["id_objetivo"], // Usar el nombre exacto del campo
        tipoObjetivo: json["tipo_objetivo"],
        nombreObjetivo: json["nombre_objetivo"],
        descripcionObjetivo: json["descripcion_objetivo"],
        valorInicial: json["valor_inicial"] ?? 0,
        valorActual: json["valor_actual"] ?? 0,
        valorObjetivo: json["valor_objetivo"] ?? 0,
        fechaLimite: DateTime.parse(json["fecha_limite"]),
        alcanzado: json["alcanzado"],
        firebaseId: json["firebase_id"],
      );

  // Método para convertir un Objetivo a JSON
  Map<String, dynamic> toJson() => {
        "id_objetivo": idObjetivo, // Asegurar que el JSON utilice el nombre correcto
        "tipo_objetivo": tipoObjetivo,
        "nombre_objetivo": nombreObjetivo,
        "descripcion_objetivo": descripcionObjetivo,
        "valor_inicial": valorInicial,
        "valor_actual": valorActual,
        "valor_objetivo": valorObjetivo,
        "fecha_limite": fechaLimite.toIso8601String(),
        "alcanzado": alcanzado,
        "firebase_id": firebaseId,
      };
}
