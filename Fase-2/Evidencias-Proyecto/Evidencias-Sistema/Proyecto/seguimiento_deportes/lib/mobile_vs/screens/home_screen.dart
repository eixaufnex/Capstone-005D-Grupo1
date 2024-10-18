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
      
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  
                // bienvenida
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hola, @usuario!', 
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                        Text('DD/MM/YYYY',
                        style: TextStyle(color: Colors.blue[700]),
              
                        ),
                        SizedBox(
                          height: 8,
              
                        )
                      ],
                    ),
              
                    //notificacion
                    Container(
                      decoration: BoxDecoration(color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(15)
                      ),
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.black,),
                    )
                    ],
                  ),
              
              
                  //Separacion entre bienvenida y busqueda
                  SizedBox(
                    height: 25,
                  ),
              
              
                  //barra de busqueda
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.search,
                        color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Busqueda...',
                        style: TextStyle(
                          color: Colors.white
                        ),)
                      ],
                    ),
                  ),
              
                  SizedBox(
                    height: 25,
                  ),
              
                  //Como te encuentras hoy 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('¿Cómo te sientes hoy?', 
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                        ),
                      ),
                      Icon(Icons.more_horiz)
                    ],
                  ),
              
                  SizedBox(
                    height: 25,
                  ),
              
                  //emojis 
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //triste
                      Column(
                        children: [
                          Emojis(emojis: '☹'),
                          SizedBox(height: 8,),
                          Text('Triste',
                          style: TextStyle(color: Colors.black),)
                        ],
                      ),
              
                      //normal
                      Column(
                        children: [
                          Emojis(emojis: '😐'),
                          SizedBox(height: 8,),
                          Text('Normal',
                          style: TextStyle(color: Colors.black),)
                        ],
                      ),
              
                     //bien
                      Column(
                        children: [
                          Emojis(emojis: '😊'),
                          SizedBox(height: 8,),
                          Text('Bien',
                          style: TextStyle(color: Colors.black),)
                        ],
                      ),
              
                      //super bien
                      Column(
                        children: [
                          Emojis(emojis: '🥳'),
                          SizedBox(height: 8,),
                          Text('Superbién',
                          style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 25,),

            Expanded(
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    color: Colors.grey[100],
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Recomendado', 
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              Icon(Icons.more_horiz)
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Expanded(
                            child: ListView(
                              children: [
                                Listarecomendaciones(),
                                Listarecomendaciones(),
                                Listarecomendaciones(),
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      

      






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


class Emojis extends StatelessWidget{

  final String emojis;

  const Emojis({
    Key? key,
    required this.emojis
  }) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.all(12),
      child: Center(
        child: Text(
          emojis,
          style: TextStyle(
            fontSize: 28
          
          ),
        ),
      ),
    );
  }
}



class Listarecomendaciones extends StatelessWidget{
  const Listarecomendaciones({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.red,
                    
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,),
                    ),
                ),
                SizedBox(width: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recomendación N°1', 
                      style: TextStyle( 
                        color: Colors.white, 
                        fontWeight:FontWeight.bold, 
                        fontSize: 16
                      ),
                    ),
                    Text(
                      '10 Ejercicios',  
                      style: TextStyle( 
                        color: Colors.white60, 
                        fontWeight:FontWeight.bold, 
                        fontSize: 14
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.more_horiz)
          ],
        )
      ),
    );
  }
  
}