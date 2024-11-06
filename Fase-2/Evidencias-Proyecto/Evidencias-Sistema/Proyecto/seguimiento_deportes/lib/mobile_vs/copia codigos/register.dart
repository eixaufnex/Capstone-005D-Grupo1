import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController txtCorreo = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();
  final TextEditingController txtUsername = TextEditingController(); // Controlador para el nombre de usuario

  @override
  void dispose() {
    txtCorreo.dispose();
    txtPassword.dispose();
    txtConfirmPassword.dispose();
    txtUsername.dispose(); // Dispose del controlador de nombre de usuario
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final usuarioProvider = Provider.of<Usuario_provider>(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // ZONA DE LOGO
            Container(
              width: double.infinity,
              height: size.height * 0.35,
              padding: EdgeInsets.only(top: 50),
              child: Image.asset('assets/logo1.png', height: 455),
            ),
            // ZONA DE DATOS
            Column(
              children: [
                SizedBox(height: 355),
                Container(
                  padding: EdgeInsets.only(top: 0),
                  margin: EdgeInsets.symmetric(horizontal: 70),
                  width: double.infinity,
                  height: 400, // Ajustado para incluir el nuevo campo
                  child: Column(
                    children: [
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            // EMAIL
                            TextFormField(
                              controller: txtCorreo,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff939393), width: 2)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                                hintText: 'Correo@gmail.com',
                                hintStyle: TextStyle(fontSize: 12),
                                labelText: 'E-mail',
                                labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                                prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
                              ),
                              validator: (value) {
                                String pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regExp = RegExp(pattern);
                                return regExp.hasMatch(value ?? '')
                                    ? null
                                    : '  El valor ingresado no es un correo';
                              },
                            ),

                            // NOMBRE DE USUARIO
                            SizedBox(height: 10),
                            TextFormField(
                              controller: txtUsername,
                              autocorrect: false,
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff939393), width: 2)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                                hintText: 'Nombre de Usuario',
                                labelText: 'Nombre de Usuario',
                                labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                                prefixIcon: Icon(Icons.person_outline, color: Colors.black),
                              ),
                              validator: (value) {
                                return (value != null && value.isNotEmpty)
                                    ? null
                                    : '  Ingresa un nombre de usuario';
                              },
                            ),

                            // PASSWORD
                            SizedBox(height: 10),
                            TextFormField(
                              controller: txtPassword,
                              autocorrect: false,
                              style: TextStyle(fontSize: 12),
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff939393), width: 2)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                                hintText: '********',
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                                prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                              ),
                              validator: (value) {
                                return (value != null && value.length >= 6)
                                    ? null
                                    : '  6 o más caracteres';
                              },
                            ),

                            // RE-PASSWORD
                            SizedBox(height: 10),
                            TextFormField(
                              controller: txtConfirmPassword,
                              autocorrect: false,
                              style: TextStyle(fontSize: 12),
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff939393), width: 2)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                                hintText: '********',
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                                prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                              ),
                              validator: (value) {
                                return (value != null && value.length >= 6)
                                    ? null
                                    : '  6 o más caracteres';
                              },
                            ),

                            // Botón continuar
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
                                // Verificar que los campos no estén vacíos
                                if (txtCorreo.text.isEmpty || txtPassword.text.isEmpty || txtConfirmPassword.text.isEmpty || txtUsername.text.isEmpty) {
                                  _showError('Por favor, complete todos los campos.');
                                  return; // Salir de la función si hay campos vacíos
                                }

                                // Validar que las contraseñas coincidan
                                if (txtPassword.text != txtConfirmPassword.text) {
                                  _showError('Las contraseñas no coinciden.');
                                  return; // Salir si las contraseñas no coinciden
                                }

                                // Validar el formato del email
                                if (!_isValidEmail(txtCorreo.text)) {
                                  _showError('El email no es válido.');
                                  return;
                                }

                                // Intentar registrar al usuario
                                bool usuarioCreado = await usuarioProvider.postUsuario(
                                  txtCorreo.text,
                                  txtPassword.text,
                                  txtUsername.text,
                                );

                                if (usuarioCreado) {
                                  // Solo redirigir si el usuario fue creado exitosamente
                                  Navigator.pushReplacementNamed(context, 'home');
                                } else {
                                  // Mostrar alerta si el usuario ya existe
                                  _showError('El correo ya está en uso.');
                                }
                              },
                            ),

                            // BOTON YA TIENES UNA CUENTA?
                            SizedBox(height: 0),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, 'login');
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(text: '¿Ya tienes una cuenta?'),
                                    TextSpan(
                                      text: ' Iniciar Sesión',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // BOTON LOG IN
            Column(
              children: [
                SizedBox(height: 290),
                Padding(
                  padding: EdgeInsets.only(left: 62),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 0, left: 0),
                      width: 135, 
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xFFC0BABA),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Log In',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // BOTON SIGN UP
            Column(
              children: [
                SizedBox(height: 290),
                Padding(
                  padding: EdgeInsets.only(right: 62),
                  child: Align(
                    alignment: Alignment.centerRight, 
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'registro');
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 0, left: 0),
                        width: 135, 
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50), 
                            bottomRight: Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
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

  // Método para validar el email (opcional)
  bool _isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}




/*

            
             */