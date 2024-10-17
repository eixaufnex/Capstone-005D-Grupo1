import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _IdiomaScreenState();
}

class _IdiomaScreenState extends State<PerfilScreen> {
  int _selectedIndex = 4;

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
  } //Direccionar a Ejercicios
  else if (index == 3){
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  Lista_EjercicioScreen()),
    );
  } 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //boton configurar
      appBar: AppBar(
        title: Text('CONFIGURACIÓN'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.login, color: Colors.black),
              onPressed: (){
                Navigator.pushReplacementNamed(context, 'login');
              },
            )
          )
        ],
        
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


