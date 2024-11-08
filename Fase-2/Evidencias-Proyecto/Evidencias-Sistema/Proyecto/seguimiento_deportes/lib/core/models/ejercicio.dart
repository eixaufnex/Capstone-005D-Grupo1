import 'dart:convert';

List<Ejercicio> ejercicioFromJson(String str) => List<Ejercicio>.from(json.decode(str).map((x) => Ejercicio.fromJson(x)));

String ejercicioToJson(List<Ejercicio> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ejercicio {
  int idListaEjercicio;
  String nombreEjercicio;
  String? imagenEjercicio;
  String? emojiEjercicio;
  String tipoEjercicio;
  String dificultadEjercicio;
  int idGrupoMuscular;
  String grupoMuscular;

  Ejercicio({
    required this.idListaEjercicio,
    required this.nombreEjercicio,
    this.imagenEjercicio,
    this.emojiEjercicio,
    required this.tipoEjercicio,
    required this.dificultadEjercicio,
    required this.idGrupoMuscular,
    required this.grupoMuscular,
  });

  factory Ejercicio.fromJson(Map<String, dynamic> json) => Ejercicio(
        idListaEjercicio: json["id_lista_ejercicio"],
        nombreEjercicio: json["nombre_ejercicio"],
        imagenEjercicio: json["imagen_ejercicio"],
        emojiEjercicio: json["emoji_ejercicio"],
        tipoEjercicio: json["tipo_ejercicio"],
        dificultadEjercicio: json["dificultad_ejercicio"],
        idGrupoMuscular: json["id_grupo_muscular"],
        grupoMuscular: json["grupo_muscular"],
      );

  Map<String, dynamic> toJson() => {
        "id_lista_ejercicio": idListaEjercicio,
        "nombre_ejercicio": nombreEjercicio,
        "imagen_ejercicio": imagenEjercicio,
        "emoji_ejercicio": emojiEjercicio,
        "tipo_ejercicio": tipoEjercicio,
        "dificultad_ejercicio": dificultadEjercicio,
        "id_grupo_muscular": idGrupoMuscular,
        "grupo_muscular": grupoMuscular,
      };
}
