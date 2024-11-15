import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seguimiento_deportes/core/providers/publicaciones_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/graficos_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/perfil_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/1_rutinas_screen.dart';

class PublicacionesScreen extends StatefulWidget {
  const PublicacionesScreen({Key? key}) : super(key: key);

  @override
  State<PublicacionesScreen> createState() => _PublicacionesScreenState();
}

class _PublicacionesScreenState extends State<PublicacionesScreen> {
  late String currentUserId;
  int _selectedIndex = 2; // Posición de la pantalla de publicaciones en el navbar

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PublicacionesProvider>(context, listen: false).getPublicaciones(currentUserId);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else if (index == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RutinaScreen()));
    } else if (index == 3) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GraficosScreen()));
    } else if (index == 4) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PerfilScreen()));
    }
  }

  void _addPublicacion() async {
    final TextEditingController contenidoController = TextEditingController();
    final provider = Provider.of<PublicacionesProvider>(context, listen: false);

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Agregar Consejo"),
          content: TextField(
            controller: contenidoController,
            maxLines: 3,
            decoration: InputDecoration(hintText: "Escribe tu consejo aquí..."),
          ),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
            TextButton(
              onPressed: () async {
                if (contenidoController.text.isNotEmpty) {
                  await provider.createPublicacion(currentUserId, descripcion: contenidoController.text);
                  Navigator.pop(context);
                }
              },
              child: Text("Agregar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Publicaciones',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,),
      body: Consumer<PublicacionesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.publicaciones.isEmpty) {
            return Center(child: Text("No hay publicaciones disponibles."));
          }
          return ListView.builder(
            itemCount: provider.publicaciones.length,
            itemBuilder: (context, index) {
              final publicacion = provider.publicaciones[index];
              final isLiked = provider.likedPublications[publicacion.idPublicacion] ?? false;

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(publicacion.descripcion ?? "Sin descripción"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Fecha: ${publicacion.fechaCreacion}"),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
                                color: isLiked ? Colors.red : Colors.grey),
                            onPressed: () {
                              provider.toggleLike(publicacion.idPublicacion, currentUserId);
                            },
                          ),
                          Text('${publicacion.likes} Likes'),
                          Spacer(),
                          if (publicacion.firebaseId == currentUserId)
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final confirmDelete = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Eliminar Publicación"),
                                    content: const Text("¿Estás seguro de que deseas eliminar esta publicación?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: const Text("Cancelar"),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: const Text("Eliminar"),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirmDelete == true) {
                                  Provider.of<PublicacionesProvider>(context, listen: false)
                                      .deletePublicacion(publicacion.idPublicacion);
                                }
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPublicacion,
        child: Icon(Icons.add),
      ),
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
              BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.view_list_rounded), label: 'Rutinas'),
              //Publicaciones
              BottomNavigationBarItem(
                icon: Transform.translate(
                  offset: Offset(0, 10),
                  child: Image.asset(
                    'assets/logoicon.png',
                    width: 45,
                    height: 45,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.stacked_line_chart_rounded), label: 'Progreso'),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Perfil'),
            ],
          ),
        ),
      ),
    );
  }
}