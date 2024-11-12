import 'dart:convert';

List<Ejercicio> ejercicioFromJson(String str) =>
    List<Ejercicio>.from(json.decode(str).map((x) => Ejercicio.fromJson(x)));

String ejercicioToJson(List<Ejercicio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ejercicio {
  int idListaEjercicio;
  String nombreEjercicio;
  String? imagenEjercicio;
  String? emojiEjercicio;
  String tipoEjercicio;
  String dificultadEjercicio;
  int idGrupoMuscular;
  String grupoMuscular;
  EjercicioDetalle? detalle;
  bool isSelected; // Campo añadido para el control de selección

  Ejercicio({
    required this.idListaEjercicio,
    required this.nombreEjercicio,
    this.imagenEjercicio,
    this.emojiEjercicio,
    required this.tipoEjercicio,
    required this.dificultadEjercicio,
    required this.idGrupoMuscular,
    required this.grupoMuscular,
    this.detalle,
    this.isSelected = false, // Inicializa como no seleccionado por defecto
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
        detalle: (json["descripcion_ejercicio"] != null && json["instrucciones_ejercicio"] != null)
            ? EjercicioDetalle.fromJson({
                "descripcion_ejercicio": json["descripcion_ejercicio"],
                "instrucciones_ejercicio": json["instrucciones_ejercicio"],
              })
            : null,
        isSelected: json["isSelected"] ?? false, // Al leer JSON, usa el valor de isSelected si existe, sino, por defecto será `false`.
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
        if (detalle != null) ...detalle!.toJson(),
        "isSelected": isSelected, // Asegúrate de incluir `isSelected` en el JSON cuando lo conviertas
      };
}

class EjercicioDetalle {
  final String descripcion;
  final String instrucciones;

  EjercicioDetalle({
    required this.descripcion,
    required this.instrucciones,
  });

  factory EjercicioDetalle.fromJson(Map<String, dynamic> json) {
    return EjercicioDetalle(
      descripcion: json['descripcion_ejercicio'],
      instrucciones: json['instrucciones_ejercicio'],
    );
  }

  Map<String, dynamic> toJson() => {
        "descripcion_ejercicio": descripcion,
        "instrucciones_ejercicio": instrucciones,
      };
}
