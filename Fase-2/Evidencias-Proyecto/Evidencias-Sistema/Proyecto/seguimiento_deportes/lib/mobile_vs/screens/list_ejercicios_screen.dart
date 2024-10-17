import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen.dart';

class Lista_EjercicioScreen extends StatefulWidget {
  const Lista_EjercicioScreen({super.key});

  @override
  State<Lista_EjercicioScreen> createState() => _IdiomaScreenState();
}

class _IdiomaScreenState extends State<Lista_EjercicioScreen> {
  int _selectedIndex = 3;

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
  }  //Direccionar a Rutinas
  else if (index == 1){
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  RutinaScreen()),
    );
  } //Direccionar a Publicaciones
  else if (index == 2){
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  PublicacionesScreen()),
    );
  } //Direccionar a Perfil
  else if (index == 4){
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  PerfilScreen()),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El contenido principal de la pantalla va aquí
      body: Center(
        

        
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
                offset: Offset(0, 10), // Ajusta el valor según lo que necesites
                child: Icon(Icons.add_circle, size: 45)),
                label: '',
                backgroundColor: Colors.transparent,
              ),//Lista Ejercicios
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center_rounded),
                label: 'Ejercicios',
                backgroundColor: Colors.transparent,
              ),//Perfil
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


