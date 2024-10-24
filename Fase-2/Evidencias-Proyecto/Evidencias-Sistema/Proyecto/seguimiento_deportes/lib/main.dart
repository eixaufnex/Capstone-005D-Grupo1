import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase Core
import 'package:seguimiento_deportes/mobile_vs/main_mobile.dart';
import 'package:seguimiento_deportes/web_vs/main_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegúrate de que Flutter esté inicializado

  // Inicializa Firebase
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: kIsWeb ? WebMain() : MobileMain(),
    );
  }
}
