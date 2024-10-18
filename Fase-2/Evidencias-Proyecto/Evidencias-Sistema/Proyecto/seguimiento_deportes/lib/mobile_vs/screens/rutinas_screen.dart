import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';

class RutinaScreen extends StatefulWidget {
  const RutinaScreen({super.key});

  @override
  State<RutinaScreen> createState() => _RutinaScreenState ();
}

class _RutinaScreenState  extends State<RutinaScreen> {
  int _selectedIndex = 1;

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
  }   //Direccionar a Publicaciones
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

      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding( padding: const EdgeInsets.only(top: 50)),
            const Text('Selecciona tu rutina',
            
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
            ),
            const  SizedBox(height: 20,),
            //lista 1
            ListTile(
              leading: const Icon(Icons.sports_gymnastics_sharp),
              title: const Text('Rutina 1'),
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proximamente')),
                );
              },
            ),
            //lista 2
            ListTile(
              leading: const Icon(Icons.sports_kabaddi_rounded),
              title: const Text('Rutina 2'),
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proximamente')),
                );
              },
            ),
            //lista 3
            ListTile(
              leading: const Icon(Icons.fitness_center_outlined),
              title: const Text('Rutina 3'),
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proximamente')),
                );
              },
            ),
            //lista 4
            ListTile(
              leading: const Icon(Icons.sports_gymnastics_sharp),
              title: const Text('Rutina 4'),
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proximamente')),
                );
              },
            ),
            //lista 5
            ListTile(
              leading: const Icon(Icons.sports_kabaddi_rounded),
              title: const Text('Rutina 5'),
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proximamente')),
                );
              },
            ),
            //lista 6
            ListTile(
              leading: const Icon(Icons.fitness_center_outlined),
              title: const Text('Rutina 6'),
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proximamente')),
                );
              },
            ),
            //lista 7
            ListTile(
              leading: const Icon(Icons.sports_gymnastics_sharp),
              title: const Text('Rutina 7'),
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proximamente')),
                );
              },
            ),
            //lista 8
            ListTile(
              leading: const Icon(Icons.sports_kabaddi_rounded),
              title: const Text('Rutina 8'),
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proximamente')),
                );
              },
            ),
            //lista 9
            ListTile(
              leading: const Icon(Icons.fitness_center_outlined),
              title: const Text('Rutina 9'),
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proximamente')),
                );
              },
            ),

          ],
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


