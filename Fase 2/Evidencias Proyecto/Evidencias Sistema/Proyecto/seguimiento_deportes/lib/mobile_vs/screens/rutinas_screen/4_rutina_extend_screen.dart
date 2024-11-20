import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/core/services/rutina_ejercicio_service.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/6_seleccion_extend_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/5_rutina_detallada_screen.dart';

class RutinaExtendScreen extends StatefulWidget {
  final int rutinaId;
  final String nombreRutina;
  final String tipoRutina;

  const RutinaExtendScreen({
    Key? key,
    required this.rutinaId,
    required this.nombreRutina,
    required this.tipoRutina,
  }) : super(key: key);

  @override
  _RutinaExtendScreenState createState() => _RutinaExtendScreenState();
}

class _RutinaExtendScreenState extends State<RutinaExtendScreen> {
  List<Map<String, String>> ejercicios = [];

  @override
  void initState() {
    super.initState();
    _fetchEjercicios();
  }

  Future<void> _fetchEjercicios() async {
    final fetchedEjercicios = await ApiService().getEjerciciosByRutina(widget.rutinaId);
    if (fetchedEjercicios != null) {
      setState(() {
        ejercicios = fetchedEjercicios
            .map<Map<String, String>>((ej) => {
                  'id': ej['id_lista_ejercicio'].toString(),
                  'nombre': ej['nombre_ejercicio'] ?? 'Sin nombre',
                })
            .toList();
      });
    }
  }

  Future<void> _deleteEjercicio(String ejercicioId) async {
    final confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar eliminación'),
        content: Text('¿Estás seguro que deseas eliminar este ejercicio?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Sí'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      final success = await ApiService().deleteEjercicioFromRutina(
        widget.rutinaId,
        int.parse(ejercicioId),
      );
      if (success) {
        setState(() {
          ejercicios.removeWhere((ej) => ej['id'] == ejercicioId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ejercicio eliminado exitosamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar el ejercicio')),
        );
      }
    }
  }

  Future<void> _navigateToSeleccionExtendScreen() async {
    final selectedEjercicios = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeleccionExtendScreen(
          rutinaId: widget.rutinaId,
          tipoRutina: widget.tipoRutina,
          ejerciciosSeleccionados: ejercicios,
        ),
      ),
    );

    if (selectedEjercicios != null) {
      setState(() {
        for (var ejercicio in selectedEjercicios) {
          ejercicios.add({
            'id': ejercicio['id'].toString(),
            'nombre': ejercicio['nombre'],
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.nombreRutina,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tipo rutina: ${widget.tipoRutina}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            ejercicios.isNotEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      itemCount: ejercicios.length,
                      itemBuilder: (context, index) {
                        final ejercicio = ejercicios[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 80,
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(Icons.fitness_center,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          ejercicio['nombre'] ?? 'Sin nombre',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'ID: ${ejercicio['id']}', // Muestra el ID del ejercicio
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        Text(
                                          '03 Series | 12 Reps',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon:
                                          Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RutinaDetalladaScreen(
                                              rutinaId: widget.rutinaId,
                                              idListaEjercicio: int.parse(ejercicio['id']!),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        _deleteEjercicio(ejercicio['id']!);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Text('No hay ejercicios en esta rutina.'),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _navigateToSeleccionExtendScreen,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 54, vertical: 12),
                ),
                child: Text('Agrega un nuevo ejercicio'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
