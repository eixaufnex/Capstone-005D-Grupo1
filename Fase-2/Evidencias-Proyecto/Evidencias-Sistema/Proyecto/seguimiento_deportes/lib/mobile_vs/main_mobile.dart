// main_mobile.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/idioma_provider.dart';
import 'package:seguimiento_deportes/core/providers/perfil_provider.dart';
import 'package:seguimiento_deportes/core/providers/publicaciones_provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/core/providers/rutina_provider.dart';
import 'package:seguimiento_deportes/core/providers/ejercicio_provider.dart';
import 'package:seguimiento_deportes/core/providers/rutina_detallada_provider.dart';
import 'package:seguimiento_deportes/core/providers/objetivo_provider.dart';
import 'package:seguimiento_deportes/core/providers/logro_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/datos_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/datos_screen_google.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/login_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/register_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/glosario_screen.dart';
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
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/1_rutinas_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/2_creacion_rutina_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/3_seleccion_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/4_rutina_extend_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/5_rutina_detallada_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/6_seleccion_extend_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/graficos_screen.dart';

class MobileMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => RutinaProvider()),
        ChangeNotifierProvider(create: (_) => EjercicioProvider()),
        ChangeNotifierProvider(create: (_) => RutinaDetalladaProvider()),
        ChangeNotifierProvider(create: (_) => ObjetivoProvider()),
        ChangeNotifierProvider(create: (_) => LogroProvider()),
        ChangeNotifierProvider(create: (_) => PerfilProvider()),
        ChangeNotifierProvider(create: (_) => PublicacionesProvider()),
        ChangeNotifierProvider(create: (_) => IdiomaProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VitalityConnect',
        initialRoute: 'login',
        onGenerateRoute: (RouteSettings settings) {
          final args = settings.arguments as Map<String, dynamic>? ?? {};

          switch (settings.name) {
            case 'creacion':
              return MaterialPageRoute(
                builder: (_) => CreacionRutinaScreen(
                  rutinaId: args['rutinaId'] ?? 0,
                  nombreRutina: args['nombreRutina'] ?? 'Rutina sin nombre',
                  tipoRutina: args['tipoRutina'] ?? 'Tipo no especificado',
                ),
              );
            case 'seleccion':
              return MaterialPageRoute(
                builder: (_) => SeleccionScreen(
                  rutinaId: args['rutinaId'] ?? 0,
                  tipoRutina: args['tipoRutina'] ?? 'Tipo no especificado',
                  ejerciciosSeleccionados:
                      args['ejerciciosSeleccionados'] ?? [],
                ),
              );
            case 'rutina_extend':
              return MaterialPageRoute(
                builder: (_) => RutinaExtendScreen(
                  rutinaId: args['rutinaId'] ?? 0,
                  nombreRutina: args['nombreRutina'] ?? 'Rutina sin nombre',
                  tipoRutina: args['tipoRutina'] ?? 'Tipo no especificado',
                ),
              );
            case 'seleccion_extend':
              return MaterialPageRoute(
                builder: (_) => SeleccionExtendScreen(
                  rutinaId: args['rutinaId'] ?? 0,
                  tipoRutina: args['tipoRutina'] ?? 'Tipo no especificado',
                  ejerciciosSeleccionados:
                      args['ejerciciosSeleccionados'] ?? [],
                ),
              );
            case 'rutina_detalle':
              return MaterialPageRoute(
                builder: (_) => RutinaDetalladaScreen(
                  rutinaId: args['rutinaId'] ?? 0,
                  idListaEjercicio: args['idListaEjercicio'] ?? 0,
                       
                ),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => LoginScreen(),
              );
          }
        },
        routes: {
          'login': (_) => LoginScreen(),
          'registro': (_) => RegisterScreen(),
          'datos': (_) => DatosScreen(),
          'datos_google': (_) => DatosGoogleScreen(),
          'home': (_) => HomeScreen(),
          'rutinas': (_) => RutinaScreen(),
          'list_ejercicios': (_) => Lista_EjercicioScreen(),
          'perfil': (_) => PerfilScreen(),
          'publicaciones': (_) => PublicacionesScreen(),
          'notificaciones': (_) => NotificacionesScreen(),
          'idioma': (_) => IdiomaScreen(),
          'unidades': (_) => UnidadesScreen(),
          'tema': (_) => TemaScreen(),
          'privacidad': (_) => PrivacidadDatosScreen(),
          'sugerencias': (_) => SugerenciasScreen(),
          'about': (_) => AcercaScreen(),
          'objetivos': (_) => ObjetivosScreen(),
          'logros': (_) => LogrosScreen(),
          'graficos': (_) => GraficosScreen(),
          'glosario': (_) => GlosarioScreen(),
        },
      ),
    );
  }
}
