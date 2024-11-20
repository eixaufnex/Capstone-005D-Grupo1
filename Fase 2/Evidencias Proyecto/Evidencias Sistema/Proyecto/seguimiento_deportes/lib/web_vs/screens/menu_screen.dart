import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:seguimiento_deportes/web_vs/screens/home_screen.dart'; // Asegúrate de importar la pantalla de inicio

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo electrónico es obligatorio.';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      return 'Introduce un correo electrónico válido.';
    }
    return null; // Si es válido
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es obligatoria.';
    }
    return null; // Si es válido
  }

  Future<void> _validateUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.10:3000/api/login'), // Cambia a tu dirección IP
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Si el servidor devuelve un 200, el usuario está validado
        final responseData = jsonDecode(response.body);
        if (responseData['success']) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()), // Navega a la pantalla de inicio
          );
        } else {
          // Mensaje si el inicio de sesión falla
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['message'])),
          );
        }
      } else {
        // Si el servidor devuelve un error
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Error desconocido')),
        );
      }
    } catch (error) {
      // Manejo de excepciones
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión, intenta nuevamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
                validator: _validateEmail,
                onChanged: (value) {
                  _email = value; // Guardar el email
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Contraseña'),
                validator: _validatePassword,
                onChanged: (value) {
                  _password = value; // Guardar la contraseña
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _validateUser(_email, _password); // Llama a la función de validación
                  }
                },
                child: Text('Validar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
