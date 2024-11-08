import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/core/providers/rutina_provider.dart';
import 'package:seguimiento_deportes/core/providers/ejercicio_provider.dart';
import 'package:seguimiento_deportes/core/providers/rutina_detallada_provider.dart';
import 'package:seguimiento_deportes/core/providers/objetivo_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/login_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/register_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/1_rutinas_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/logros_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/objetivos_screen.dart';
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
import 'package:seguimiento_deportes/mobile_vs/screens/graficos_screen.dart';

class MobileMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Usuario_provider()),
        ChangeNotifierProvider(create: (_) => Rutina_provider()),
        ChangeNotifierProvider(create: (_) => Ejercicio_Provider()),
        ChangeNotifierProvider(create: (_) => RutinaDetalladaProvider()),
        ChangeNotifierProvider(create: (_) => ObjetivoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VitalityConnect',
        initialRoute: 'login',
        onGenerateRoute: (settings) {
          if (settings.name == 'creacion') {
            final args = settings.arguments as int; // rutinaId
            return MaterialPageRoute(
              builder: (_) => CreacionRutinaScreen(rutinaId: args),
            );
          } else if (settings.name == 'anadir') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => AnadirEjerciciosScreen(
                rutinaId: args['rutinaId'],
                exerciseType: args['exerciseType'],
              ),
            );
          } else if (settings.name == 'seleccion') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => SeleccionScreen(
                rutinaId: args['rutinaId'],
                exerciseType: args['exerciseType'],
              ),
            );
          }

          // Default route handling
          switch (settings.name) {
            case 'login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case 'registro':
              return MaterialPageRoute(builder: (_) => RegisterScreen());
            case 'home':
              return MaterialPageRoute(builder: (_) => HomeScreen());
            case 'rutinas':
              return MaterialPageRoute(builder: (_) => RutinaScreen());
            case 'list_ejercicios':
              return MaterialPageRoute(builder: (_) => Lista_EjercicioScreen());
            case 'perfil':
              return MaterialPageRoute(builder: (_) => PerfilScreen());
            case 'publicaciones':
              return MaterialPageRoute(builder: (_) => PublicacionesScreen());
            case 'notificaciones':
              return MaterialPageRoute(builder: (_) => NotificacionesScreen());
            case 'idioma':
              return MaterialPageRoute(builder: (_) => IdiomaScreen());
            case 'unidades':
              return MaterialPageRoute(builder: (_) => UnidadesScreen());
            case 'tema':
              return MaterialPageRoute(builder: (_) => TemaScreen());
            case 'privacidad':
              return MaterialPageRoute(builder: (_) => PrivacidadDatosScreen());
            case 'sugerencias':
              return MaterialPageRoute(builder: (_) => SugerenciasScreen());
            case 'about':
              return MaterialPageRoute(builder: (_) => AcercaScreen());
            case 'rutina_detalle':
              return MaterialPageRoute(builder: (_) => RutinaDetalladaScreen());
            case 'objetivos':
              return MaterialPageRoute(builder: (_) => ObjetivosScreen());
            case 'logros':
              return MaterialPageRoute(builder: (_) => LogrosScreen());
            case 'graficos':
              return MaterialPageRoute(builder: (_) => GraficosScreen());
            default:
              return MaterialPageRoute(builder: (_) => LoginScreen());
          }
        },
      ),
    );
  }
}
