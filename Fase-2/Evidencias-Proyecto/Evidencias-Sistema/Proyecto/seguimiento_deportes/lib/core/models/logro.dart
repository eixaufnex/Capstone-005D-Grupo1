import 'dart:convert';

// Funciones de conversión para LogroObtenido
List<LogroObtenido> logroObtenidoFromJson(String str) =>
    List<LogroObtenido>.from(json.decode(str).map((x) => LogroObtenido.fromJson(x)));

String logroObtenidoToJson(List<LogroObtenido> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// Funciones de conversión para LogroGlobal
List<LogroGlobal> logroGlobalFromJson(String str) =>
    List<LogroGlobal>.from(json.decode(str).map((x) => LogroGlobal.fromJson(x)));

String logroGlobalToJson(List<LogroGlobal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// Clase LogroGlobal
class LogroGlobal {
  int idLogroGlobal;
  String nombreLogro;
  String descripcionLogro;

  LogroGlobal({
    required this.idLogroGlobal,
    required this.nombreLogro,
    required this.descripcionLogro,
  });

  factory LogroGlobal.fromJson(Map<String, dynamic> json) => LogroGlobal(
        idLogroGlobal: json["id_logro_global"],
        nombreLogro: json["nombre_logro"],
        descripcionLogro: json["descripcion_logro"],
      );

  Map<String, dynamic> toJson() => {
        "id_logro_global": idLogroGlobal,
        "nombre_logro": nombreLogro,
        "descripcion_logro": descripcionLogro,
      };
}

// Clase LogroObtenido (extiende LogroGlobal para reutilizar atributos)
class LogroObtenido extends LogroGlobal {
  DateTime? fechaObtencion;
  String? firebaseId;

  LogroObtenido({
    required int idLogroGlobal,
    required String nombreLogro,
    required String descripcionLogro,
    this.fechaObtencion,
    this.firebaseId,
  }) : super(
          idLogroGlobal: idLogroGlobal,
          nombreLogro: nombreLogro,
          descripcionLogro: descripcionLogro,
        );

  factory LogroObtenido.fromJson(Map<String, dynamic> json) => LogroObtenido(
        idLogroGlobal: json["id_logro_global"] ?? 0,
        nombreLogro: json["nombre_logro"] ?? "Logro desconocido",
        descripcionLogro: json["descripcion_logro"] ?? "Sin descripción",
        fechaObtencion: json["fecha_obtencion"] != null
            ? DateTime.parse(json["fecha_obtencion"])
            : null,
        firebaseId: json["firebase_id"] ?? "Sin ID",
      );

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      "fecha_obtencion": fechaObtencion?.toIso8601String(),
      "firebase_id": firebaseId,
    });
}

