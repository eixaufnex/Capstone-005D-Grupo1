import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importar Firebase Auth

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instancia de Firebase Auth
  final txtCorreo = TextEditingController();
  final txtPassword = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    // Limpia los controladores cuando el widget se elimine.
    txtCorreo.dispose();
    txtPassword.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // Verificar que los campos no estén vacíos
    if (txtCorreo.text.isEmpty || txtPassword.text.isEmpty) {
      _showDialog('Campos vacíos', 'Por favor, complete todos los campos.');
      return; // Salir de la función si hay campos vacíos
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: txtCorreo.text.trim(),
        password: txtPassword.text.trim(),
      );

      // Si el inicio de sesión es exitoso, redirigir al usuario
      Navigator.pushReplacementNamed(context, 'home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
      _showDialog('Intentelo de nuevo!', _errorMessage ?? 'Email o Password incorrectos.');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                  height: 370,
                  child: Column(
                    children: [
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            // EMAIL
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              controller: txtCorreo,
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
                              // validador de correo
                              validator: (value) {
                                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regExp = RegExp(pattern);
                                return regExp.hasMatch(value ?? '') ? null : '  El valor ingresado no es un correo';
                              },
                            ),

                            // PASSWORD
                            SizedBox(height: 0),
                            TextFormField(
                              autocorrect: false,
                              controller: txtPassword,
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
                              // validador de clave
                              validator: (value) {
                                return (value != null && value.length >= 6) ? null : '  6 o más caracteres';
                              },
                            ),

                            // Olvido su contraseña
                            SizedBox(height: 0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  '¿Olvidó su contraseña?',
                                  style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            // Botón Ingresar
                            SizedBox(height: 0),
                            MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              disabledColor: Colors.grey,
                              color: Colors.black,
                              onPressed: _login,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                                child: Text('Ingresar', style: TextStyle(color: Colors.white)),
                              ),
                            ),

                            // BOTON NO TIENES CUENTA?
                            SizedBox(height: 0),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, 'registro');
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(text: '¿No tienes cuenta?'),
                                    TextSpan(
                                      text: ' Regístrate',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //SEPARACION ----OR----
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      'OR',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center, 
                              children: [
                                // Botón Face
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color:Colors.black)),
                                  disabledColor: Colors.grey,
                                  color: Colors.white,
                                  minWidth: 50,
                                  height: 60,
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    child: Image.asset('assets/face-logo.png', height: 35),
                                  ),
                                  onPressed: () {
                                    
                                  },
                                ),
                                
                                //separacion entre botones
                                SizedBox(width: 8), 
                            
                                // Botón Google
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color:Colors.black)),
                                  disabledColor: Colors.grey,
                                  color: Colors.white,
                                  minWidth: 50,
                                  height: 60, 
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    child: Image.asset('assets/google-logo.png', height: 35), 
                                  ),
                                  onPressed: () {
                                    // Acción para el segundo botón
                                  },
                                ),
                                
                                //separacion entre botones
                                SizedBox(width: 8),
                            
                            
                                // Botón X
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color:Colors.black)),
                                  disabledColor: Colors.grey,
                                  color: Colors.white,
                                  minWidth: 50, 
                                  height: 60, 
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    child: Image.asset('assets/X-Logo.png', height: 35), 
                                  ),
                                  onPressed: () {
                                    
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
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
                        color: Colors.black,
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
                          color: Color(0xFFC0BABA),
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
}
