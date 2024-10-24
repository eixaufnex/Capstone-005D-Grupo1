//esto funciona

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Nombre de Usuario'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    // Validar que las contraseñas coincidan
    if (_passwordController.text != _confirmPasswordController.text) {
      // Mostrar un mensaje de error si las contraseñas no coinciden
      _showError('Las contraseñas no coinciden');
      return;
    }

    // Validar el formato del email
    if (!_isValidEmail(_emailController.text)) {
      _showError('El email no es válido');
      return;
    }

    // Obtener el proveedor de usuarios
    final usuarioProvider = Provider.of<Usuario_provider>(context, listen: false);

    // Intentar registrar al usuario
    bool success = await usuarioProvider.postUsuario(
      _emailController.text,
      _passwordController.text,
      _usernameController.text,
    );

    if (success) {
      // Navegar a la pantalla principal o mostrar un mensaje de éxito
      Navigator.pop(context); // Regresa a la pantalla anterior
      _showSuccess('Registro exitoso');
    } else {
      // Manejar el fallo del registro
      _showError('Error en el registro');
    }
  }

  // Método para mostrar errores
  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  // Método para mostrar mensajes de éxito
  void _showSuccess(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Éxito'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  // Método para validar el email (opcional)
  bool _isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}



