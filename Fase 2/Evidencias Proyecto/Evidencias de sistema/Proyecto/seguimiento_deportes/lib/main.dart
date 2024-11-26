import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';
import 'package:seguimiento_deportes/mobile_vs/main_mobile.dart';
import 'package:seguimiento_deportes/web_vs/main_web.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  // Inicializa Firebase con las opciones adecuadas según la plataforma
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCpQRq_27guNrfTDBi_8GE_SSOdByUe-yk",
          authDomain: "seguimiento-deporte.firebaseapp.com",
          projectId: "seguimiento-deporte",
          storageBucket: "seguimiento-deporte.firebasestorage.app",
          messagingSenderId: "753728087063",
          appId: "1:753728087063:web:6b8459dc71abb6b9f56852",
          measurementId: "G-1BT75SKWSC"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VitalityConnect',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: kIsWeb ? WebMain() : MobileMain(),
    );
  }
}
