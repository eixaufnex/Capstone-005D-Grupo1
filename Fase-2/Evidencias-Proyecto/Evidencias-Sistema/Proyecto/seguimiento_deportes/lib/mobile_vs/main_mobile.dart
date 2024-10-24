import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/login_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/register_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';

class MobileMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Usuario_provider()),
        // ChangeNotifierProvider(create: (_) => Usuario_provider()), es para agregar otro changenotifier
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        routes: {
          'login': (_) => LoginScreen(),
          'registro': (_) => RegisterScreen(),
          'home': (_) => HomeScreen(),
          'rutinas': (_) => RutinaScreen(),
          'list_ejercicios': (_) => Lista_EjercicioScreen(),
          'perfil': (_) => PerfilScreen(),
          'publicaciones': (_) => PublicacionesScreen(),
          // 'idioma' : (_) => IdiomaScreen(),
        },
        initialRoute: 'login', // Después cambiar a pantalla de introducción
      ),
    );
  }
}
