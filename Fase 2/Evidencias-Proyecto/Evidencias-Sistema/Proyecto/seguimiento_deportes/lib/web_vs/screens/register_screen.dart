// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:seguimiento_deportes/web_vs/screens/home_screen.dart'; 
// import 'package:seguimiento_deportes/core/models/usuario.dart';

// class RegistrerScreen extends StatefulWidget {
//   @override
//   _RegistrerScreenState createState() => _RegistrerScreenState();
// }

// class _RegistrerScreenState extends State<RegistrerScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? _password;
//   bool _isPasswordValid = true;
//   String _email = '';
//   String _firstName = '';
//   String _lastName = '';

//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'El correo electrónico es obligatorio.';
//     }
//     if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
//       return 'Introduce un correo electrónico válido.';
//     }
//     return null; 
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'La contraseña es obligatoria.';
//     }
//     if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) {
//       _isPasswordValid = false; 
//       return 'Contraseña no válida.';
//     }
//     _isPasswordValid = true; 
//     return null; 
//   }

//   Future<void> _registerUser() async {
//     Usuario nuevoUsuario = Usuario(
//       idUsuario: 0,
//       email: _email,
//       userPassword: _password!,
//       rol: 'usuario',
//       estado: 1,
//       fechaRegistro: DateTime.now(),
//     );

//     try {
//       final response = await http.post(
//         Uri.parse('http://localhost:3000/api/register'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode({
//           'email': nuevoUsuario.email,
//           'password': nuevoUsuario.userPassword,
//           'rol': nuevoUsuario.rol,
//           'estado': nuevoUsuario.estado,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         if (responseData['success']) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Registro exitoso')),
//           );

//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HomeScreen()),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(responseData['message'] ?? 'Error desconocido')),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error al registrar, intenta nuevamente.')),
//         );
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error de conexión, intenta nuevamente.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(right: 10),
//                     child: Image.asset(
//                       'assets/logo1.png',
//                       width: 25,
//                       height: 25,
//                     ),
//                   ),
//                   Text(
//                     'VitalityConnect.',
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Spacer(),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       'Regresar',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 40),

//               Center(
//                 child: Container(
//                   width: 350,
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 5,
//                         blurRadius: 7,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(bottom: 20),
//                         child: Image.asset(
//                           'assets/logo1.png',
//                           height: 80,
//                         ),
//                       ),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Nombre',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'El nombre es obligatorio.';
//                           }
//                           return null;
//                         },
//                         onChanged: (value) {
//                           _firstName = value;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Apellido',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'El apellido es obligatorio.';
//                           }
//                           return null;
//                         },
//                         onChanged: (value) {
//                           _lastName = value;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Correo electrónico',
//                         ),
//                         validator: _validateEmail,
//                         onChanged: (value) {
//                           _email = value;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Contraseña',
//                         ),
//                         obscureText: true,
//                         validator: _validatePassword,
//                         onChanged: (value) {
//                           _password = value;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             _registerUser();
//                           }
//                         },
//                         child: Text('Registrarse'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
