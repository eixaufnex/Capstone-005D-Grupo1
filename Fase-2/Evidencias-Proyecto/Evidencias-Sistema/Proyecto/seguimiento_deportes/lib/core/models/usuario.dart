import 'dart:convert';

List<Usuario> usuarioFromJson(String str) => List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
    int idUsuario;
    String email;
    String userPassword;
    String rol;
    int estado;
    DateTime fechaRegistro;

    Usuario({
        required this.idUsuario,
        required this.email,
        required this.userPassword,
        required this.rol,
        required this.estado,
        required this.fechaRegistro,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["id_usuario"],
        email: json["email"],
        userPassword: json["user_password"],
        rol: json["rol"],
        estado: json["estado"],
        fechaRegistro: DateTime.parse(json["fecha_registro"]),
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "email": email,
        "user_password": userPassword,
        "rol": rol,
        "estado": estado,
        "fecha_registro": fechaRegistro.toIso8601String(),
    };
}
