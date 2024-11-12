import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  final TextEditingController txtCorreo = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();
  final TextEditingController txtUsername = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0.9,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    txtCorreo.dispose();
    txtPassword.dispose();
    txtConfirmPassword.dispose();
    txtUsername.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[100]!,
              Colors.grey[300]!,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: size.height * 0.4,
                padding: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 80,
                      spreadRadius: 10,
                      offset: Offset(0, -50),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _animationController.value,
                          child: child,
                        );
                      },
                      child: Image.asset('assets/logo1.png', height: 200),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 270),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: txtCorreo,
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff939393), width: 2),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 2),
                                  ),
                                  hintText: 'Correo@gmail.com',
                                  hintStyle: TextStyle(fontSize: 12),
                                  labelText: 'E-mail',
                                  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                                  prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
                                ),
                                validator: (value) {
                                  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                                  RegExp regExp = RegExp(pattern);
                                  return regExp.hasMatch(value ?? '') ? null : '  El valor ingresado no es un correo';
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: txtUsername,
                                autocorrect: false,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff939393), width: 2),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 2),
                                  ),
                                  hintText: 'Nombre de Usuario',
                                  labelText: 'Nombre de Usuario',
                                  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                                  prefixIcon: Icon(Icons.person_outline, color: Colors.black),
                                ),
                                validator: (value) {
                                  return (value != null && value.isNotEmpty) ? null : '  Ingresa un nombre de usuario';
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: txtPassword,
                                autocorrect: false,
                                style: TextStyle(fontSize: 14),
                                obscureText: true,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff939393), width: 2),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 2),
                                  ),
                                  hintText: '********',
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                                  prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                                ),
                                validator: (value) {
                                  return (value != null && value.length >= 6) ? null : '  6 o más caracteres';
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: txtConfirmPassword,
                                autocorrect: false,
                                style: TextStyle(fontSize: 14),
                                obscureText: true,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff939393), width: 2),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 2),
                                  ),
                                  hintText: '********',
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                                  prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                                ),
                                validator: (value) {
                                  return (value != null && value.length >= 6) ? null : '  6 o más caracteres';
                                },
                              ),
                              SizedBox(height: 20),
                              MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                disabledColor: Colors.grey,
                                color: Colors.black,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
                                  child: Text('Continuar', style: TextStyle(color: Colors.white)),
                                ),
                                onPressed: () async {
                                  if (txtCorreo.text.isEmpty || txtPassword.text.isEmpty || txtConfirmPassword.text.isEmpty || txtUsername.text.isEmpty) {
                                    _showError('Por favor, complete todos los campos.');
                                    return;
                                  }
                                  if (txtPassword.text != txtConfirmPassword.text) {
                                    _showError('Las contraseñas no coinciden.');
                                    return;
                                  }
                                  if (!_isValidEmail(txtCorreo.text)) {
                                    _showError('El email no es válido.');
                                    return;
                                  }
                                  // Intenta crear el usuario y verifica si el correo está en uso
                                  bool usuarioCreado = await usuarioProvider.postUsuario(
                                    txtCorreo.text,
                                    txtPassword.text,
                                    txtUsername.text,
                                  );
                                  if (usuarioCreado) {
                                    Navigator.pushReplacementNamed(context, 'datos');
                                  } else {
                                    _showError('El correo ya está en uso.');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: '¿Ya tienes una cuenta?'),
                        TextSpan(
                          text: ' Iniciar Sesión',
                          style: TextStyle(
                            color: Colors.blue[700],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'VitalityConnect',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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

  bool _isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}