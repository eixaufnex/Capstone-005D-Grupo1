// //esto funciona

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';

// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Registro'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Contraseña'),
//               obscureText: true,
//             ),
//             TextField(
//               controller: _confirmPasswordController,
//               decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
//               obscureText: true,
//             ),
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Nombre de Usuario'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _register,
//               child: Text('Registrarse'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _register() async {
//     // Validar que las contraseñas coincidan
//     if (_passwordController.text != _confirmPasswordController.text) {
//       // Mostrar un mensaje de error si las contraseñas no coinciden
//       _showError('Las contraseñas no coinciden');
//       return;
//     }

//     // Validar el formato del email
//     if (!_isValidEmail(_emailController.text)) {
//       _showError('El email no es válido');
//       return;
//     }

//     // Obtener el proveedor de usuarios
//     final usuarioProvider = Provider.of<Usuario_provider>(context, listen: false);

//     // Intentar registrar al usuario
//     bool success = await usuarioProvider.postUsuario(
//       _emailController.text,
//       _passwordController.text,
//       _usernameController.text,
//     );

//     if (success) {
//       // Navegar a la pantalla principal o mostrar un mensaje de éxito
//       Navigator.pop(context); // Regresa a la pantalla anterior
//       _showSuccess('Registro exitoso');
//     } else {
//       // Manejar el fallo del registro
//       _showError('Error en el registro');
//     }
//   }

//   // Método para mostrar errores
//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Cerrar'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Método para mostrar mensajes de éxito
//   void _showSuccess(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Éxito'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Cerrar'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Método para validar el email (opcional)
//   bool _isValidEmail(String email) {
//     String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
//     RegExp regExp = RegExp(pattern);
//     return regExp.hasMatch(email);
//   }
// }




/*


import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:seguimiento_deportes/core/models/usuario.dart';
import 'package:seguimiento_deportes/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

const urlapi = url;

class Usuario_provider with ChangeNotifier {
  List<Usuario> usuarios = [];

  Usuario_provider() {
    getUsuarios();
  }

  getUsuarios() async {
    final url1 = Uri.http(urlapi, 'usuario');
    final resp = await http.get(url1, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
    final response = usuarioFromJson(resp.body);

    usuarios = response;
    notifyListeners();
  }


  // Método para crear un nuevo usuario
Future<bool> postUsuario(String email, String password, String username) async {
  final url = Uri.http(urlapi, 'usuario');

  try {
    // Crear usuario en Firebase
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Obtener el ID de Firebase
    String firebaseId = userCredential.user!.uid;

    // Enviar el username y el firebaseId a tu servidor SQL
    final resp = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        'firebase_id': firebaseId,
        'username': username,
      }),
    );

    // Manejo de errores
    if (resp.statusCode == 201) {
      // Usuario creado correctamente
      print('Usuario creado exitosamente');
      return true;
    } else if (resp.statusCode == 400) {
      // Manejo del error si el correo ya existe
      print('Error: El correo ya está en uso');
      return false;
    } else {
      // Manejo de otros errores
      final errorResponse = jsonDecode(resp.body);
      print('Error al crear el usuario: ${errorResponse['message'] ?? errorResponse}');
      return false; 
    }
  } catch (e) {
    print('Error de conexión: $e');
    return false;
  }
}

}


*/