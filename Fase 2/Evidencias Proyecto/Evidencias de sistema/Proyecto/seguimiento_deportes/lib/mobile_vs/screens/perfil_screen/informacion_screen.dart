import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seguimiento_deportes/core/providers/perfil_provider.dart';
import 'package:seguimiento_deportes/core/models/perfil.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';

class InformacionScreen extends StatefulWidget {
  const InformacionScreen({Key? key}) : super(key: key);

  @override
  _InformacionScreenState createState() => _InformacionScreenState();
}

class _InformacionScreenState extends State<InformacionScreen> {
  bool isLoading = true;
  String? firebaseId;

  @override
  void initState() {
    super.initState();
    _fetchAuthenticatedUserProfile();
  }

  Future<void> _fetchAuthenticatedUserProfile() async {
    setState(() => isLoading = true);

    // Obtener el usuario autenticado
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      firebaseId = user.uid; // Obtiene el UID del usuario autenticado en Firebase
      print("UID del usuario autenticado: $firebaseId");

      // Cargar perfiles desde el provider
      await Provider.of<PerfilProvider>(context, listen: false).getPerfiles();
    } else {
      print("No hay un usuario autenticado.");
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final perfilProvider = Provider.of<PerfilProvider>(context);

    // Buscar el perfil del usuario específico usando `firebaseId`
    final perfil = perfilProvider.perfiles.firstWhere(
      (p) => p.firebaseId == firebaseId,
      orElse: () => Perfil(
        idPerfil: 0,
        nombre: 'N/A',
        apellido: 'N/A',
        edad: 0,
        peso: 0.0,
        estatura: 0.0,
        genero: 'N/A',
        tipoNivel: 'N/A',
        biografia: 'N/A',
        firebaseId: 'N/A',
      ),
    );

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(S.current.info_usuario)),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (perfil.firebaseId == 'N/A') {
      return Scaffold(
        appBar: AppBar(title: Text(S.current.info_usuario)),
        body: Center(child: Text(S.current.no_info)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.info_usuario,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.grey[900]),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
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
            padding: EdgeInsets.symmetric(horizontal: 20),
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
            child: Column(
              children: [
                SizedBox(height: kToolbarHeight + 40),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow(S.current.nombre_completo, "${perfil.nombre} ${perfil.apellido}"),
                      Divider(color: Colors.grey[300], thickness: 1),
                      _buildInfoRow(S.current.label_age, "${perfil.edad} ${S.current.anios}"),
                      Divider(color: Colors.grey[300], thickness: 1),
                      _buildInfoRow(S.current.genero, perfil.genero),
                      Divider(color: Colors.grey[300], thickness: 1),
                      _buildInfoRow(S.current.peso, "${perfil.peso} kg"),
                      Divider(color: Colors.grey[300], thickness: 1),
                      _buildInfoRow(S.current.Estatura, "${perfil.estatura} cm"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 60,
                        spreadRadius: 30,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}