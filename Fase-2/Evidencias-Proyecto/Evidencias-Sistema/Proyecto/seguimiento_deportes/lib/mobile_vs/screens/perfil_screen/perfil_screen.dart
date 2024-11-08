import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa Firebase Auth
import 'package:seguimiento_deportes/mobile_vs/screens/graficos_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/1_rutinas_screen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  int _selectedIndex = 4;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    // Obtener el correo del usuario actual
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      userEmail = user?.email; // Almacena el correo en la variable
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    //Direccionar a Home
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } //Direccionar a Rutinas
    else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RutinaScreen()),
      );
    } //Direccionar a Publicaciones
    else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PublicacionesScreen()),
      );
    } //Direccionar a graficos
    else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GraficosScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('assets/miguelito.jpeg'),
                ),
              ),
              const SizedBox(height: 10),
              Text('Nombre', style: Theme.of(context).textTheme.headlineSmall),
              Text(userEmail ?? 'correo@gmail.com',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall), // Muestra el correo del usuario
              const SizedBox(height: 20),
              SizedBox(
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pushReplacementNamed(context, 'editar_perfil');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF5ECE3),
                    side: BorderSide(
                      color: Colors.black12,
                      width: 1.5, 
                    ),
                    shape: StadiumBorder(),
                  ),
                  child: const Text('Editar perfil',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),

              //menu perfil
              perfil_widget(
                title: "Notificaciones",
                icon: Icons.notifications,
                onPress: () {
                  Navigator.pushReplacementNamed(context, 'notificaciones');
                },
              ),
              perfil_widget(
                title: "Idioma",
                icon: Icons.language,
                onPress: () {
                  Navigator.pushReplacementNamed(context, 'idioma');
                },
              ),
              perfil_widget(
                title: "Unidades",
                icon: Icons.build_rounded,
                onPress: () {
                  Navigator.pushReplacementNamed(context, 'unidades');
                },
              ),
              perfil_widget(
                title: "Tema    (Próximamente...)",
                icon: Icons.dark_mode,
                onPress: () {
                  Navigator.pushReplacementNamed(context, 'tema');
                },
              ),
              perfil_widget(
                title: "Preguntas frecuentes",
                icon: Icons.flag,
                onPress: () {
                  // Navigator.pushReplacementNamed(context, 'preguntas_frecuentes');
                },
              ),
              perfil_widget(
                title: "Privacidad de datos",
                icon: Icons.security,
                onPress: () {
                  Navigator.pushReplacementNamed(context, 'privacidad');
                },
              ),
              perfil_widget(
                title: "Sugerencias",
                icon: Icons.sentiment_satisfied_alt_rounded,
                onPress: () {
                  Navigator.pushReplacementNamed(context, 'sugerencias');
                },
              ),
              perfil_widget(
                title: "Acerca de...",
                icon: Icons.info,
                onPress: () {
                  Navigator.pushReplacementNamed(context, 'about');
                },
              ),
            ],
          ),
        ),
      ),

      // navbar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              //Home
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
                backgroundColor: Colors.transparent,
              ),
              //Rutinas
              BottomNavigationBarItem(
                icon: Icon(Icons.view_list_rounded),
                label: 'Rutinas',
                backgroundColor: Colors.transparent,
              ),
              //Publicaciones
              BottomNavigationBarItem(
                icon: Transform.translate(
                  offset:
                      Offset(0, 10), // Ajusta el valor según lo que necesites
                  child: Icon(Icons.add_circle, size: 45),
                ),
                label: '',
                backgroundColor: Colors.transparent,
              ), //Rendimiento
              BottomNavigationBarItem(
                icon: Icon(Icons.stacked_line_chart_rounded),
                label: 'Progreso',
                backgroundColor: Colors.transparent,
              ), //Perfil
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Perfil',
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class perfil_widget extends StatelessWidget {
  const perfil_widget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.green.withOpacity(0.1),
        ),
        child: Icon(icon, color: Colors.black),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodySmall?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Icon(Icons.arrow_forward_ios,
                  color: Colors.black.withOpacity(.6)),
            )
          : null,
    );
  }
}
