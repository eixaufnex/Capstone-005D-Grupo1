import 'dart:convert';

// Funciones para manejar la conversión de JSON a Perfil y viceversa
List<Perfil> perfilFromJson(String str) =>
    List<Perfil>.from(json.decode(str).map((x) => Perfil.fromJson(x)));

String perfilToJson(List<Perfil> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Perfil {
  int idPerfil;
  String nombre;
  String apellido;
  int edad;
  double peso;
  double estatura;
  String genero;
  String tipoNivel;
  String? fotoPerfil; // Puede ser nullable si se omite en algún caso
  String biografia;
  String firebaseId;

  Perfil({
    required this.idPerfil,
    required this.nombre,
    required this.apellido,
    required this.edad,
    required this.peso,
    required this.estatura,
    required this.genero,
    required this.tipoNivel,
    this.fotoPerfil,
    required this.biografia,
    required this.firebaseId, 
  });

  // Método para crear un Perfil a partir de un JSON con manejo seguro de valores nulos
  factory Perfil.fromJson(Map<String, dynamic> json) => Perfil(
        idPerfil: json["id_perfil"] ?? 0,
        nombre: json["nombre"] ?? '',
        apellido: json["apellido"] ?? '',
        edad: (json["edad"] as num?)?.toInt() ?? 0,
        peso: (json["peso"] as num?)?.toDouble() ?? 0.0,
        estatura: (json["estatura"] as num?)?.toDouble() ?? 0.0,
        genero: json["genero"] ?? '',
        tipoNivel: json["tipo_nivel"] ?? '',
        fotoPerfil: json["foto_perfil"],
        biografia: json["biografia"] ?? '',
        firebaseId: json["firebase_id"] ?? '',
      );

  // Método para convertir un Perfil a JSON
  Map<String, dynamic> toJson() => {
        "id_perfil": idPerfil,
        "nombre": nombre,
        "apellido": apellido,
        "edad": edad,
        "peso": peso,
        "estatura": estatura,
        "genero": genero,
        "tipo_nivel": tipoNivel,
        "foto_perfil": fotoPerfil,
        "biografia": biografia,
        "firebase_id": firebaseId,
      };
}