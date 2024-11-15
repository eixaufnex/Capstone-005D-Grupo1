import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/datos_screen_google.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final txtCorreo = TextEditingController();
  final txtPassword = TextEditingController();
  String? _errorMessage;
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
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (txtCorreo.text.isEmpty || txtPassword.text.isEmpty) {
      _showDialog('Campos vacíos', 'Por favor, complete todos los campos.');
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: txtCorreo.text.trim(),
        password: txtPassword.text.trim(),
      );
      Navigator.pushReplacementNamed(context, 'home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
      _showDialog('Intentelo de nuevo!', _errorMessage ?? 'Email o Password incorrectos.');
    }
  }

  Future<void> _signInWithGoogle() async {
    final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);

    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _showDialog('Inicio de sesión cancelado', 'El usuario canceló el inicio de sesión.');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final firebaseId = userCredential.user?.uid;

      if (firebaseId == null) {
        _showDialog('Error', 'No se pudo obtener el ID de usuario.');
        return;
      }

      // Verificar si el usuario ya existe en la base de datos
      final usuarioExiste = await usuarioProvider.checkIfUserExists(firebaseId);
      if (usuarioExiste) {
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DatosGoogleScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      _showDialog('Error de autenticación', e.message ?? 'Ocurrió un error al iniciar sesión con Google.');
    } catch (e) {
      _showDialog('Error', 'Error al iniciar sesión con Google. Por favor, inténtelo de nuevo.');
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

  Future<void> _signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Navigator.pushReplacementNamed(context, 'login');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[100]!, Colors.grey[300]!],
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.4,
              padding: EdgeInsets.only(top: 70),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 30,
                    spreadRadius: 1,
                    offset: Offset(0, 20),
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
                    child: Image.asset('assets/logo1.png', height: 210),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(height: 300),
                Text(
                  S.current.Log_In,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              controller: txtCorreo,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffC0C0C0), width: 1.5),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87, width: 1.5),
                                ),
                                hintText: S.current.emailsample,
                                hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                                labelText: S.current.Email,
                                labelStyle: TextStyle(color: Colors.black87, fontSize: 14),
                                prefixIcon: Icon(Icons.email_outlined, color: Colors.black54),
                              ),
                              validator: (value) {
                                String pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regExp = RegExp(pattern);
                                return regExp.hasMatch(value ?? '') ? null : '  Ingrese un correo válido';
                              },
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              autocorrect: false,
                              controller: txtPassword,
                              style: TextStyle(fontSize: 14),
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffC0C0C0), width: 1.5),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87, width: 1.5),
                                ),
                                hintText: S.current.Password,
                                hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                                labelText: S.current.Password,
                                labelStyle: TextStyle(color: Colors.black87, fontSize: 14),
                                prefixIcon: Icon(Icons.lock_outline, color: Colors.black54),
                              ),
                              validator: (value) {
                                return (value != null && value.length >= 6) ? null : '  Mínimo 6 caracteres';
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  color: Colors.black87,
                  onPressed: _login,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                    child: Text(S.current.Enter, style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.current.Dont_have_an_account, style: TextStyle(color: Colors.black87)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'registro');
                      },
                      child: Text(
                        S.current.Sing_Up,
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  S.current.Or_log_in_with_Google,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black87)),
                      color: Colors.white,
                      child: Image.asset('assets/google-logo.png', height: 32),
                      onPressed: _signInWithGoogle,
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'VitalityConnect',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8,
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