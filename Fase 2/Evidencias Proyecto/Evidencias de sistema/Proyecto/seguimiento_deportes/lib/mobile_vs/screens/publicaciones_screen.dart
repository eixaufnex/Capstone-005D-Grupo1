import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seguimiento_deportes/core/providers/publicaciones_provider.dart';
import 'package:seguimiento_deportes/core/providers/rutina_provider.dart';
import 'package:seguimiento_deportes/core/services/rutina_ejercicio_service.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';
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
  int _selectedIndex =
      2; // Posición de la pantalla de publicaciones en el navbar

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PublicacionesProvider>(context, listen: false)
          .getPublicaciones(currentUserId);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => RutinaScreen()));
    } else if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => GraficosScreen()));
    } else if (index == 4) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PerfilScreen()));
    }
  }

  void _addPublicacion() async {
    final provider = Provider.of<PublicacionesProvider>(context, listen: false);
    final TextEditingController contenidoController = TextEditingController();

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.current.publicacion1),
          content: Text(S.current.publicacion2),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _addConsejo(provider, contenidoController);
              },
              child: Text(S.current.consejo),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                _publicarRutina();
              },
              child: Text(S.current.publicacion4),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.current.cancelar),
            ),
          ],
        );
      },
    );
  }

  void _addConsejo(PublicacionesProvider provider,
      TextEditingController contenidoController) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.current.consejo),
          content: TextField(
            controller: contenidoController,
            maxLines: 3,
            decoration: InputDecoration(hintText: S.current.consejo1),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.current.cancelar),
            ),
            TextButton(
              onPressed: () async {
                if (contenidoController.text.isNotEmpty) {
                  await provider.createPublicacion(
                    currentUserId,
                    descripcion: contenidoController.text,
                  );
                  Navigator.pop(context);
                }
              },
              child: Text(S.current.agregar),
            ),
          ],
        );
      },
    );
  }

  void _publicarRutina() async {
    String? firebaseId = FirebaseAuth.instance.currentUser?.uid;
    if (firebaseId == null) {
      print("Usuario no autenticado");
      return;
    }

    final ApiService apiService = ApiService();
    final data = await apiService.getRutinasAndEjerciciosByUser(firebaseId);

    if (data != null) {
      Map<int, Map<String, dynamic>> rutinasMap = {};

      for (var item in data) {
        int idRutina = item['id_rutina'];
        if (!rutinasMap.containsKey(idRutina)) {
          rutinasMap[idRutina] = {
            'id_rutina': idRutina,
            'nombre_rutina': item['nombre_rutina'],
            'emoji': item['emoji'],
            'tipo_rutina': item['tipo_rutina'],
            'ejercicios': []
          };
        }

        // Agregar ejercicios asegurando que no se repitan
        var ejercicios = rutinasMap[idRutina]?['ejercicios'] as List<dynamic>;
        if (!ejercicios.any(
            (e) => e['id_lista_ejercicio'] == item['id_lista_ejercicio'])) {
          ejercicios.add({
            'id_lista_ejercicio': item['id_lista_ejercicio'],
            'nombre_ejercicio': item['nombre_ejercicio'],
          });
        }
      }

      final rutinas = rutinasMap.values.toList();


      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.current.publicacion3),
            content: SizedBox(
              width: double.maxFinite,
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: rutinas.map((rutina) {
                    final ejercicios = (rutina['ejercicios'] as List<dynamic>)
                        .map((e) => e['nombre_ejercicio'])
                        .toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => _confirmarCompartirRutina(rutina),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${rutina['nombre_rutina']} (${rutina['tipo_rutina']})",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              ...ejercicios
                                  .map((ejercicio) => Text("- $ejercicio")),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(S.current.cerrar),
              ),
            ],
          );
        },
      );
    } else {
      print("Error al obtener las rutinas y ejercicios");
    }
  }

  void _confirmarCompartirRutina(Map<String, dynamic> rutina) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.current.publicacion5),
          content: Text(
              "${S.current.publicacion6} \"${rutina['nombre_rutina']}\"?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(S.current.si),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      // Llamada para guardar la rutina como publicación
      await _guardarRutinaComoPublicacion(rutina);
    }
  }

  Future<void> _guardarRutinaComoPublicacion(
      Map<String, dynamic> rutina) async {
    String? firebaseId = FirebaseAuth.instance.currentUser?.uid;
    if (firebaseId == null) {
      print("Usuario no autenticado");
      return;
    }

    final provider = Provider.of<PublicacionesProvider>(context, listen: false);

    // Construir descripción con nombres y IDs de ejercicios
    final ejercicios = rutina['ejercicios'] as List<dynamic>;
    final descripcionEjercicios = ejercicios.map((e) {
      return "- ID: ${e['id_lista_ejercicio']}, Ejercicio: ${e['nombre_ejercicio']}";
    }).join("\n");

    final descripcionCompleta =
        "${S.current.publicacion7} ${rutina['nombre_rutina']} (${rutina['tipo_rutina']})\n\n${S.current.ejercicios}:\n$descripcionEjercicios";

    try {
      await provider.createPublicacion(
        firebaseId,
        descripcion: descripcionCompleta,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "${S.current.publicacion8} \"${rutina['nombre_rutina']}\" ${S.current.publicacion9}")),
      );
    } catch (e) {
      print("Error al guardar la rutina como publicación: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.current.publicacion10)),
      );
    }
  }

  // Ajustes al código para manejar emojis predeterminados
  void _addRecommendedRoutine(int index, String nombreRutina, String emoji,
      String tipoRutina, List<Map<String, String>> ejercicios) async {
    String firebaseId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (firebaseId.isEmpty) {
      print('Error: No hay usuario autenticado');
      return;
    }

    final rutinaProvider = Provider.of<RutinaProvider>(context, listen: false);

    // Crear la rutina en la base de datos con emoji por defecto si no hay ninguno
    int? rutinaId = await rutinaProvider.postRutina(
      nombreRutina,
      "🏋️", // Emoji por defecto
      firebaseId,
      tipoRutina: tipoRutina,
    );

    if (rutinaId != null) {
      // Guardar los ejercicios en la rutina
      bool success = await rutinaProvider.apiService
          .saveEjerciciosToRutina(rutinaId, ejercicios);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.current.publicacion11)),
        );
      } else {
        print('Error al agregar los ejercicios a la rutina');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.current.publicacion12)),
        );
      }
    } else {
      print('Error al crear la rutina');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.current.publicacion13)),
      );
    }
  }

  void _addRutina(dynamic publicacion, int index) async {
    // Mostrar diálogo de confirmación
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.current.publicacion14),
          content:
              Text(S.current.publicacion15),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Opción No
              child: Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Opción Sí
              child: Text(S.current.si),
            ),
          ],
        );
      },
    );

    // Si el usuario confirma, proceder con la lógica de guardado
    if (confirm == true) {
      // Extraer información de la publicación
      final nombreRutina = _extraerNombreRutina(publicacion.descripcion ?? "");
      final tipoRutina = _extraerTipoRutina(publicacion.descripcion ?? "");
      final idsEjercicios =
          _extraerIdsEjercicios(publicacion.descripcion ?? "");

      // Emoji predeterminado directamente configurado
      const emoji = "🏋️";

      // Crear lista de ejercicios con IDs y nombres
      final ejercicios = idsEjercicios.map((id) {
        return {'id': id.toString(), 'nombre': 'Ejercicio $id'};
      }).toList();

      // Llamar a _addRecommendedRoutine para guardar en la BD
      _addRecommendedRoutine(
          index, nombreRutina, emoji, tipoRutina, ejercicios);
    }
  }

  String _extraerNombreRutina(String descripcion) {
    final regex = RegExp(r"Rutina compartida: (.+?) \(");
    final match = regex.firstMatch(descripcion);
    return match?.group(1)?.trim() ?? "Nombre no encontrado";
  }

  String _extraerTipoRutina(String descripcion) {
    final regex = RegExp(r"\((.+)\)");
    final match = regex.firstMatch(descripcion);
    return match?.group(1) ?? "Tipo no encontrado";
  }

  List<int> _extraerIdsEjercicios(String descripcion) {
    final regex = RegExp(r"- ID: (\d+),");
    return regex
        .allMatches(descripcion)
        .map((match) => int.parse(match.group(1) ?? "0"))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.publi,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<PublicacionesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.publicaciones.isEmpty) {
            return Center(child: Text(S.current.no_publi));
          }
          return ListView.builder(
            itemCount: provider.publicaciones.length,
            itemBuilder: (context, index) {
              final publicacion = provider.publicaciones[index];
              final isLiked =
                  provider.likedPublications[publicacion.idPublicacion] ??
                      false;

              // Verificar si la publicación es una rutina (según alguna propiedad o convención)
              final esRutina =
                  publicacion.descripcion?.startsWith("Rutina compartida:") ??
                      false;

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title:
                      Text(publicacion.descripcion ?? S.current.no_descripcion),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${S.current.fecha}: ${publicacion.fechaCreacion}"),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLiked ? Colors.red : Colors.grey),
                            onPressed: () {
                              provider.toggleLike(
                                  publicacion.idPublicacion, currentUserId);
                            },
                          ),
                          Text('${publicacion.likes} ${S.current.like}'),

                          // Botón "Guardar rutina +" solo si es rutina
                          if (esRutina)
                            TextButton.icon(
                              icon: Icon(Icons.add, color: Colors.green),
                              label: Text(
                                S.current.publicacion16,
                                style: TextStyle(color: Colors.green),
                              ),
                              onPressed: () {
                                _addRutina(
                                    publicacion, index); // Llama a _addRutina
                              },
                            ),

                          Spacer(),

                          // Botón eliminar si el usuario es el dueño de la publicación
                          if (publicacion.firebaseId == currentUserId)
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final confirmDelete = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(S.current.eliminar_publi),
                                    content: Text(S.current.eliminar_publi1),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text(S.current.cancelar),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: Text(S.current.eliminar),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirmDelete == true) {
                                  Provider.of<PublicacionesProvider>(context,
                                          listen: false)
                                      .deletePublicacion(
                                          publicacion.idPublicacion);
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: S.current.home),
              BottomNavigationBarItem(
                  icon: Icon(Icons.view_list_rounded), label: S.current.rutina),
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.stacked_line_chart_rounded),
                  label: S.current.progreso),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: S.current.perfil),
            ],
          ),
        ),
      ),
    );
  }
}
