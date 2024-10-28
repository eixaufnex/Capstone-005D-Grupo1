import 'dart:convert';

List<Usuario> usuarioFromJson(String str) => List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
    int idUsuario;
    String firebase_id;
    String username;
    String rol;
    int estado;
    DateTime fechaRegistro;

    Usuario({
        required this.idUsuario,
        required this.firebase_id,
        required this.username,
        required this.rol,
        required this.estado,
        required this.fechaRegistro,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["id_usuario"],
        firebase_id: json["firebase_id"],
        username: json["username"],
        rol: json["rol"],
        estado: json["estado"],
        fechaRegistro: DateTime.parse(json["fecha_registro"]),
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "firebase_id": firebase_id,
        "username": username,
        "rol": rol,
        "estado": estado,
        "fecha_registro": fechaRegistro.toIso8601String(),
    };
}
