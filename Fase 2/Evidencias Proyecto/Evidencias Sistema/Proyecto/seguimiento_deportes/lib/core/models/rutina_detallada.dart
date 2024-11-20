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
  int rpe;
  int? tiempoEjercicio;
  DateTime fechaRutina;
  String? comentarios; // Campo opcional para comentarios
  int idRutina;
  int? idListaEjercicio; // Campo opcional para idListaEjercicio

  RutinaDetallada({
    required this.idRutinaDetallada,
    required this.series,
    required this.repeticiones,
    required this.peso,
    required this.rpe,
    required this.tiempoEjercicio,
    required this.fechaRutina,
    this.comentarios,
    required this.idRutina,
    this.idListaEjercicio,
  });

  // Constructor que convierte JSON en una instancia de RutinaDetallada
  factory RutinaDetallada.fromJson(Map<String, dynamic> json) => RutinaDetallada(
        idRutinaDetallada: json["id_rutina_detallada"],
        series: json["series"],
        repeticiones: json["repeticiones"],
        peso: json["peso"].toDouble(),
        rpe: json["rpe"],
        tiempoEjercicio: json["tiempo_ejercicio"], // Cambio aquí
        fechaRutina: DateTime.parse(json["fecha_rutina"]),
        comentarios: json["comentarios"], // Asignación directa, ya que es opcional
        idRutina: json["id_rutina"],
        idListaEjercicio: json["id_lista_ejercicio"], // Asignación directa, ya que es opcional
      );

  // Método que convierte una instancia de RutinaDetallada en JSON
  Map<String, dynamic> toJson() => {
        "id_rutina_detallada": idRutinaDetallada,
        "series": series,
        "repeticiones": repeticiones,
        "peso": peso,
        "rpe": rpe,
        "tiempo_ejercicio": tiempoEjercicio, // Cambio aquí
        "fecha_rutina": fechaRutina.toIso8601String(),
        "comentarios": comentarios, // Incluir el campo de comentarios
        "id_rutina": idRutina,
        if (idListaEjercicio != null) "id_lista_ejercicio": idListaEjercicio, // Solo incluir si no es nulo
      };
}
