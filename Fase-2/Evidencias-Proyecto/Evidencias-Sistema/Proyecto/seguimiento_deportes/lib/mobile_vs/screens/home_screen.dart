import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState ();
}

class _HomeScreenState  extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });

  //Direccionar a Rutinas
  if (index == 1){
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
     

      

      






    //  body: CustomScrollView(
    //     slivers: [
    //       SliverAppBar(
    //         expandedHeight: 100.0,
    //         floating: false,
    //         pinned: true,
    //         flexibleSpace: FlexibleSpaceBar(
    //           title: Text('HOME'),
    //           background: Container(
    //             color: Colors.white,
    //             child: Center(
    //               child: Text('',
    //               style: TextStyle(color: Colors.white, fontSize: 30)
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),


    //       SliverToBoxAdapter(
    //           child: Container(
    //             padding: EdgeInsets.all(8.0), // Padding alrededor del GridView
    //             child: GridView.count(
    //               physics: NeverScrollableScrollPhysics(), // Evita el scroll interno
    //               shrinkWrap: true, // Ajusta el tamaño del GridView al contenido
    //               crossAxisCount: 2, // Dos columnas
    //               mainAxisSpacing: 8.0, // Espacio vertical entre los bloques
    //               crossAxisSpacing: 8.0, // Espacio horizontal entre los bloques
    //               children: [
    //                 Colors.red,
    //                 Colors.green,
    //                 Colors.yellow,
    //                 Colors.blue,
    //                 Colors.orange,
    //                 Colors.purple,
    //                 Colors.yellow,
    //                 Colors.blue,
    //                 Colors.orange,
    //                 Colors.purple,

    //               ].map((color) => Container(
    //                 height: 60, // Mantener la altura de cada bloque
    //                 color: color,
    //               )).toList(),
    //             ),
    //           ),
    //         ),
    //     ],

      
    //   ),
    
      
      


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


 Widget _colorBlock(Color color) {
    return Container(
      height: 100, // Altura del bloque
      color: color,
      margin: EdgeInsets.symmetric(vertical: 10), // Espacio entre bloques
      child: Center(
        child: Text(
          color.toString(),
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }