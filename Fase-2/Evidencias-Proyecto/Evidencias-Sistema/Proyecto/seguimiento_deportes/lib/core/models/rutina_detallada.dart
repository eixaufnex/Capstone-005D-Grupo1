import 'dart:convert';

List<RutinaDetallada> rutinaDetalladaFromJson(String str) =>
    List<RutinaDetallada>.from(json.decode(str).map((x) => RutinaDetallada.fromJson(x)));

String rutinaDetalladaToJson(List<RutinaDetallada> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RutinaDetallada {
  int idRutinaDetallada;
  int series;
  int repeticiones;
  double peso;
  int descanso;
  DateTime fechaRutina;
  int idRutina; // Cambiado de idUsuario a idRutina
  int idListaEjercicio;

  RutinaDetallada({
    required this.idRutinaDetallada,
    required this.series,
    required this.repeticiones,
    required this.peso,
    required this.descanso,
    required this.fechaRutina,
    required this.idRutina, // Actualizado aquí también
    required this.idListaEjercicio,
  });

  factory RutinaDetallada.fromJson(Map<String, dynamic> json) => RutinaDetallada(
    idRutinaDetallada: json["id_rutina_detallada"],
    series: json["series"],
    repeticiones: json["repeticiones"],
    peso: (json["peso"] is int) ? (json["peso"] as int).toDouble() : json["peso"], // Cambiado para aceptar int y convertir a double
    descanso: json["descanso"],
    fechaRutina: DateTime.parse(json["fecha_rutina"]),
    idRutina: json["id_rutina"],
    idListaEjercicio: json["id_lista_ejercicio"],
);


  Map<String, dynamic> toJson() => {
        "id_rutina_detallada": idRutinaDetallada,
        "series": series,
        "repeticiones": repeticiones,
        "peso": peso,
        "descanso": descanso,
        "fecha_rutina": fechaRutina.toIso8601String(),
        "id_rutina": idRutina, // Actualizado aquí
        "id_lista_ejercicio": idListaEjercicio,
      };
}
