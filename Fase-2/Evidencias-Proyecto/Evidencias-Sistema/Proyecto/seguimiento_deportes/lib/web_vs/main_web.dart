import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/web_vs/screens/home_screen.dart';

class WebMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VitalityConnect',
      debugShowCheckedModeBanner: false, // Oculta el banner de debug
      home: HomeScreen(), // Cambia esto a la pantalla que desees mostrar
    );
  }
}
