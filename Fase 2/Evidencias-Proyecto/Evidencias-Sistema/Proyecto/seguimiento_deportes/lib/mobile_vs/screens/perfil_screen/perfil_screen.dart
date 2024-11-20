import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/graficos_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/informacion_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/1_rutinas_screen.dart';

// Notificador para actualizar el avatar en otras pantallas
final ValueNotifier<String> avatarNotifier = ValueNotifier<String>('assets/av9.png');

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 4;
  String? userEmail;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  String selectedAvatar = 'assets/av9.png'; // Avatar por defecto
  String? userId; // Almacena el UID del usuario actual

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userEmail = user?.email;
    userId = user?.uid; // Obtener UID del usuario actual

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _loadAvatarSelection(); // Cargar el avatar guardado del usuario actual desde Firebase
  }

  // Función para cargar el avatar del usuario actual desde Firebase
  Future<void> _loadAvatarSelection() async {
    if (userId == null) return;
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      setState(() {
        selectedAvatar = userDoc['avatarUrl'] ?? 'assets/av9.png';
      });
      avatarNotifier.value = selectedAvatar; // Notificar el avatar inicial
    }
  }

  // Función para guardar la selección de avatar en Firebase
  Future<void> _saveAvatarSelection(String avatarPath) async {
    if (userId == null) return;
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'avatarUrl': avatarPath,
    }, SetOptions(merge: true));
    avatarNotifier.value = avatarPath; // Notificar cambios de avatar
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RutinaScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PublicacionesScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GraficosScreen()),
      );
    }
  }

  // Mostrar opciones de avatar en un ModalBottomSheet
  void _showAvatarOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Image.asset('assets/av9.png', width: 40, height: 40),
              title: Text('Avatar 1'),
              onTap: () {
                setState(() {
                  selectedAvatar = 'assets/av9.png';
                });
                _saveAvatarSelection('assets/av9.png'); // Guardar y notificar selección
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Image.asset('assets/av10.webp', width: 40, height: 40),
              title: Text('Avatar 2'),
              onTap: () {
                setState(() {
                  selectedAvatar = 'assets/av10.webp';
                });
                _saveAvatarSelection('assets/av10.webp'); // Guardar y notificar selección
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              alignment: Alignment.center,
              child: Text(
                'Perfil',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: GestureDetector(
                        onTap: () => _showAvatarOptions(),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.grey.shade700),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(selectedAvatar),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Correo',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.black87),
                    ),
                    Text(
                      userEmail ?? 'correo@gmail.com',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 180,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InformacionScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          side: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Ver Información',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            perfil_widget(
              title: "Idioma",
              icon: Icons.language,
              onPress: () {
                Navigator.pushReplacementNamed(context, 'idioma');
              },
            ),
            perfil_widget(
              title: "Notificaciones",
              icon: Icons.notifications,
              onPress: () {
                Navigator.pushReplacementNamed(context, 'notificaciones');
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
              title: "Unidades",
              icon: Icons.build_rounded,
              onPress: () {
                Navigator.pushReplacementNamed(context, 'unidades');
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
              title: "Acerca de...",
              icon: Icons.info,
              onPress: () {
                Navigator.pushReplacementNamed(context, 'about');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.black87,
            unselectedItemColor: Colors.grey.shade600,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.view_list_rounded),
                label: 'Rutinas',
              ),
              BottomNavigationBarItem(
                icon: Transform.translate(
                  offset: Offset(0, 8),
                  child: Icon(Icons.add_circle, size: 45, color: Colors.black87),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.stacked_line_chart_rounded),
                label: 'Progreso',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Clase perfil_widget para los elementos de perfil en el ListView
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
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.shade300,
        ),
        child: Icon(icon, color: Colors.black87),
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.apply(color: textColor ?? Colors.black87, fontWeightDelta: 2),
      ),
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