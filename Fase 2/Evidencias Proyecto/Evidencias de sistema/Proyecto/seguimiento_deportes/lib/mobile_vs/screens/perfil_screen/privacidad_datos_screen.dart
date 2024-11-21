import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';

class PrivacidadDatosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'perfil');
          },
        ),
        title: Text(
          S.current.privacidad_datos,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[900]),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Fondo con íconos translúcidos
          Positioned(
            top: 80,
            left: 20,
            child: Icon(Icons.fitness_center,
                color: Colors.grey[300]!.withOpacity(0.2), size: 100),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: Icon(Icons.accessibility_new,
                color: Colors.grey[300]!.withOpacity(0.2), size: 120),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[100]!,
                  Colors.grey[200]!,
                  Colors.grey[300]!,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: kToolbarHeight + 60), // Espacio adicional ajustado
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 600,
                    ),
                    child: SingleChildScrollView(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                            TextSpan(text: '${S.current.privacidad_datos1}\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos2}\n\n'),
                            
                            TextSpan(text: '${S.current.privacidad_datos3}\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos4}\n\n'),

                            TextSpan(text: '${S.current.privacidad_datos5}\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos6}\n\n'),
                            TextSpan(text: S.current.privacidad_datos7, style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos8}\n'),
                            TextSpan(text: S.current.privacidad_datos9, style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos10}\n'),
                            TextSpan(text: S.current.privacidad_datos11, style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos12}\n'),
                            TextSpan(text: S.current.privacidad_datos13, style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos14}\n'),
                            TextSpan(text: S.current.privacidad_datos15, style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos16}\n'),
                            TextSpan(text: S.current.privacidad_datos17, style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos18}\n'),
                            TextSpan(text: S.current.privacidad_datos19, style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos20}\n\n'),

                            TextSpan(text: '${S.current.privacidad_datos21}\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos22}\n\n'),
                            TextSpan(text: S.current.privacidad_datos23, style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos24}\n'),
                            TextSpan(text: S.current.privacidad_datos25, style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos26}\n'),
                            TextSpan(text: S.current.privacidad_datos27, style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos28}\n'),
                            TextSpan(text: S.current.privacidad_datos29, style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos30}\n'),
                            TextSpan(text: S.current.privacidad_datos31, style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos32}\n\n'),

                            TextSpan(text: '${S.current.privacidad_datos33}\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${S.current.privacidad_datos34}\n\n'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Texto VitalityConnect en la parte inferior
                  Text(
                    "VitalityConnect",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}