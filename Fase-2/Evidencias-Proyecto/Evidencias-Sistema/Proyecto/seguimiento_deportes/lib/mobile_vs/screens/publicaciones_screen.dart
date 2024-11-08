import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/graficos_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/perfil_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/1_rutinas_screen.dart';

class PublicacionesScreen extends StatefulWidget {
  const PublicacionesScreen({super.key});

  @override
  State<PublicacionesScreen> createState() => _PublicacionesScreenState (); //cambiar el tema idioma
}

class _PublicacionesScreenState  extends State<PublicacionesScreen> {
  int _selectedIndex = 2;

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
  }  //Direccionar a graficos
  else if (index == 3){
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  GraficosScreen()),
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
      
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('PUBLICACIONES'),
              background: Container(
                color: Colors.white,
                child: Center(
                  child: Text('',
                  style: TextStyle(color: Colors.white, fontSize: 30)
                  ),
                ),
              ),
            ),
          ),


          SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(8.0), // Padding alrededor del GridView
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(), // Evita el scroll interno
                  shrinkWrap: true, // Ajusta el tamaño del GridView al contenido
                  crossAxisCount: 1, // Dos columnas
                  mainAxisSpacing: 40.0, // Espacio vertical entre los bloques
                  crossAxisSpacing: 8.0, // Espacio horizontal entre los bloques
                  children: [
                    Colors.grey,
                    Colors.grey,
                    Colors.grey,
                    Colors.grey,
                    Colors.grey,
                    Colors.grey,
                    Colors.grey,

                  ].map((color) => Container(
                    height: 60, // Mantener la altura de cada bloque
                    color: color,
                  )).toList(),
                ),
              ),
            ),
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
              ),//Rendimiento
              BottomNavigationBarItem(
                icon: Icon(Icons.stacked_line_chart_rounded),
                label: 'Progreso',
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


