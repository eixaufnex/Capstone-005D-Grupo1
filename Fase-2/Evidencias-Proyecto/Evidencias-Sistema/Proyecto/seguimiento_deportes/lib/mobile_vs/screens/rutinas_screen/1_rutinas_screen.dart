//screen 1

//rutinas_Screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/rutina_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/graficos_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/2_creacion_rutina_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/perfil_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/4_rutina_extend_screen.dart';

class RutinaScreen extends StatefulWidget {
  const RutinaScreen({Key? key}) : super(key: key);

  @override
  State<RutinaScreen> createState() => _RutinaScreenState();
}

class _RutinaScreenState extends State<RutinaScreen> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    Provider.of<RutinaProvider>(context, listen: false).getRutinaXUsuario(
      FirebaseAuth.instance.currentUser!.uid,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Manejo de la navegación
    Widget? destination;
    switch (index) {
      case 0:
        destination = HomeScreen();
        break;
      case 2:
        destination = PublicacionesScreen();
        break;
      case 3:
        destination = GraficosScreen();
        break;
      case 4:
        destination = PerfilScreen();
        break;
    }

    if (destination != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => destination!),
      );
    }
  }

  void _showCreateRutinaDialog() {
    String nombreRutina = '';
    String selectedEmoji = '🏋️';
    String selectedTipoRutina = 'Fuerza';
    List<String> emojis = [
      '🏋️',
      '🤸',
      '🏃',
      '💪',
      '🏊',
      '🚴',
      '🧘',
      '⛹️',
      '🏌️',
      '🤾'
    ];
    List<String> tiposRutina = [
      'Fuerza',
      'Cardiovascular',
      'Deporte en equipo',
      'Elongación',
      'Flexibilidad'
    ];

    final rutinaProvider = Provider.of<RutinaProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(child: Text('Crea tu nueva rutina')),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      nombreRutina = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Nombre de tu Rutina',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Elige tu Icono',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: emojis.map((emoji) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedEmoji = emoji;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: selectedEmoji == emoji
                              ? Colors.grey[300]
                              : Colors.transparent,
                          child: Text(emoji, style: TextStyle(fontSize: 24)),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text('Tipo de Rutina',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedTipoRutina,
                    isExpanded: true,
                    onChanged: (newValue) {
                      setState(() {
                        selectedTipoRutina = newValue!;
                      });
                    },
                    items: tiposRutina.map((tipo) {
                      return DropdownMenuItem(
                        value: tipo,
                        child: Text(tipo),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (nombreRutina.isNotEmpty) {
                  int? rutinaId = await rutinaProvider.postRutina(
                    nombreRutina,
                    selectedEmoji,
                    FirebaseAuth.instance.currentUser!.uid,
                    tipoRutina: selectedTipoRutina,
                  );
                  if (rutinaId != null) {
                    Navigator.of(context).pop(); // Cierra el diálogo

                    // Navega a CreacionRutinaScreen pasando el rutinaId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreacionRutinaScreen(
                          rutinaId: rutinaId,
                          nombreRutina: nombreRutina,
                          tipoRutina: selectedTipoRutina,
                        ),
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Rutina creada exitosamente')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al crear la rutina')),
                    );
                  }
                }
              },
              child: Text('Crear', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> tileColors = [Colors.white, Colors.grey.shade200];
    final rutinaProvider = Provider.of<RutinaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Selecciona tu rutina',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 90),
        child: rutinaProvider.rutinas.isEmpty
            ? Center(
                child: Text(
                  "No tienes rutinas creadas",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              )
            : ListView.builder(
                itemCount: rutinaProvider.rutinas.length,
                itemBuilder: (context, index) {
                  final rutina = rutinaProvider.rutinas[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: tileColors[index % 2],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading:
                          Text(rutina.emoji, style: TextStyle(fontSize: 24)),
                      title: Text(rutina.nombreRutina),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RutinaExtendScreen(
                              rutinaId: rutina.idRutina,
                              nombreRutina: rutina.nombreRutina,
                              tipoRutina: rutina.tipoRutina ?? 'Null',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
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
                  offset: Offset(0, 10),
                  child: Icon(Icons.add_circle, size: 45),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateRutinaDialog,
        label: Text('Crear rutina', style: TextStyle(color: Colors.white)),
        icon: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
