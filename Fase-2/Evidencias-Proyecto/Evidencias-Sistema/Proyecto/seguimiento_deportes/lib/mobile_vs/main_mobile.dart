import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/core/providers/rutina_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/login_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/register_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/1_rutinas_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/perfil_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/notificaciones_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/idioma_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/unidades_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/tema_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/privacidad_datos_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/sugerencias_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/acerca_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/2_creacion_rutina_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/3_anadir_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/5_rutina_detallada_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/4_seleccion_screen.dart';

class MobileMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Usuario_provider()),
        ChangeNotifierProvider(create: (_) => Rutina_provider()),
        // ChangeNotifierProvider(create: (_) => Usuario_provider()), es para agregar otro provider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VitalityConnect',
        routes: {
          'login': (_) => LoginScreen(),
          'registro': (_) => RegisterScreen(),
          'home': (_) => HomeScreen(),
          'rutinas': (_) => RutinaScreen(),
          'creacion': (_) => CreacionRutinaScreen(),
          'list_ejercicios': (_) => Lista_EjercicioScreen(),
          'perfil': (_) => PerfilScreen(),
          'publicaciones': (_) => PublicacionesScreen(),
          'notificaciones': (_) => NotificacionesScreen(),
          'idioma' : (_) => IdiomaScreen(),
          'unidades' : (_) => UnidadesScreen(),
          'tema' : (_) => TemaScreen(),
          'privacidad' : (_) => PrivacidadDatosScreen(),
          'sugerencias' : (_) => SugerenciasScreen(),
          'about' : (_) => AcercaScreen(),
          'anadir' : (_) => AnadirEjerciciosScreen(),
          'rutina_detalle' : (_) => RutinaDetalladaScreen(),
          'seleccion' : (_) => SeleccionScreen(),
        },
        initialRoute: 'login', // Después cambiar a pantalla de introducción
      ),
    );
  }
}
