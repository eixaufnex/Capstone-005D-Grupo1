import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:seguimiento_deportes/web_vs/screens/menu_screen.dart';
import 'package:seguimiento_deportes/web_vs/screens/register_screen.dart';
import 'package:seguimiento_deportes/web_vs/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es obligatoria.';
    }
    return null;
  }

  Future<void> _login() async {
    try {
      // Asegúrate de incluir el esquema HTTP o HTTPS
      final response = await http.post(
        Uri.parse('http://192.168.164.40:3000/api/login'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': _email, 'password': _password}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['success']) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MenuScreen()),
          );
        } else {
          _showMessage(responseData['message']);
        }
      } else {
        final responseData = jsonDecode(response.body);
        _showMessage(responseData['message'] ?? 'Error desconocido');
      }
    } catch (error) {
      _showMessage('Error de conexión, intenta nuevamente.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/logo1.png',
                    width: 25,
                    height: 25,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Text('Volver a Inicio', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
              SizedBox(height: 40),
              _buildLoginForm(),
              SizedBox(height: 20),
              _buildRegisterMessage(),
              SizedBox(height: 40),
              _buildSocialIcons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Center(
      child: Container(
        width: 350,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset('assets/logo1.png', height: 100),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
              validator: _validateEmail,
              onChanged: (value) => _email = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
              validator: _validatePassword,
              onChanged: (value) => _password = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _login();
                }
              },
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterMessage() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("¿No tienes cuenta? "),


          // TE DEJE ESTO COMENTADO
          // TextButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => RegistrerScreen()),
          //     );
          //   },
          //   child: Text(
          //     'Regístrate',
          //     style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logo1.png', width: 40, height: 40),
          SizedBox(width: 20),
          _buildGoogleIcon(),
          SizedBox(width: 20),
          _buildTwitterIcon(),
        ],
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return Container(
      width: 40,
      height: 40,
      child: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Color(0xff4285F4),
              Color(0xffEA4335),
              Color(0xffFBBC05),
              Color(0xff34A853),
            ],
            tileMode: TileMode.clamp,
          ).createShader(bounds),
          child: Text(
            'G',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTwitterIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'X',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
