import 'package:flutter/material.dart';
import 'package:seguimiento_deportes/core/services/rutina_ejercicio_service.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/3_seleccion_screen.dart';

class CreacionRutinaScreen extends StatefulWidget {
  final int rutinaId;
  final String nombreRutina;
  final String tipoRutina;

  const CreacionRutinaScreen({
    Key? key,
    required this.rutinaId,
    required this.nombreRutina,
    required this.tipoRutina,
  }) : super(key: key);

  @override
  State<CreacionRutinaScreen> createState() => _CreacionRutinaScreenState();
}

class _CreacionRutinaScreenState extends State<CreacionRutinaScreen> {
  // Lista para almacenar los ejercicios seleccionados
  List<Map<String, String>> ejercicios = [];

  // Lista de íconos para alternar
  final List<IconData> iconosAlternados = [
    Icons.favorite,
    Icons.star,
    Icons.eco,
  ];

  // Índice para cambiar los íconos
  int iconoIndex = 0;

  // Navegar a la pantalla de selección de ejercicios
  Future<void> _navigateAndAddExercises() async {
    final selectedEjercicios = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeleccionScreen(
          rutinaId: widget.rutinaId,
          tipoRutina: widget.tipoRutina,
          ejerciciosSeleccionados: ejercicios, // Pasamos los ejercicios ya seleccionados
        ),
      ),
    );

    // Añadir los ejercicios seleccionados si se retorna algo
    if (selectedEjercicios != null) {
      setState(() {
        for (var ejercicio in selectedEjercicios) {
          ejercicios.add({
            'id': ejercicio['id'].toString(), // ID del ejercicio
            'nombre': ejercicio['nombre'], // Nombre real del ejercicio
          });
        }
      });
    }
  }

  // Acción del botón de guardar con alerta de confirmación
  void _confirmSaveRoutine() async {
    // Mostrar alerta de confirmación
    final shouldSave = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.current.estas_seguro_rutina),
          content: Text(S.current.deseas_guardar),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Opción "Sí"
              child: Text(S.current.si),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Opción "No"
              child: const Text('No'),
            ),
          ],
        );
      },
    );

    // Si el usuario elige "Sí", guarda la rutina
    if (shouldSave == true) {
      _saveRoutine();
    }
  }

  // Acción del botón de guardar
  void _saveRoutine() async {
    // Crear una cadena para almacenar la información de los ejercicios
    String ejercicioInfo = ejercicios
        .map((ejercicio) =>
            'rutinaid = ${widget.rutinaId}, ejercicioid = ${ejercicio['id']}')
        .join(' ; ');

    // Mostrar en la consola el formato solicitado
    print(ejercicioInfo);

    // Llamar al servicio para guardar los ejercicios en la API
    final success = await ApiService().saveEjerciciosToRutina(widget.rutinaId, ejercicios);

    // Mostrar mensaje según si la operación fue exitosa o no
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.current.rutina_guardada)),
      );
      // Redirigir a la pantalla de rutinas automáticamente después de guardar
      Navigator.pop(context);  // Regresa a la pantalla anterior (Rutinas)
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.current.rutina_guardada1)),
      );
    }
  }

  // Eliminar un ejercicio de la lista
  void _removeExercise(int index) {
    setState(() {
      ejercicios.removeAt(index); // Eliminar el ejercicio en el índice dado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tipoRutina,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Deshabilita el botón de "Volver"
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text(
                S.current.rellena_manera,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${S.current.id_rutina}: ${widget.rutinaId}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ejercicios.isEmpty
                  ? Center(
                      child: Text(
                        S.current.agrega_ejercicios,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]),
                      ),
                    )
                  : ListView.builder(
                      itemCount: ejercicios.length,
                      itemBuilder: (context, index) {
                        final ejercicio = ejercicios[index];
                        final icono = iconosAlternados[iconoIndex % iconosAlternados.length];
                        iconoIndex++; // Incrementar el índice para el próximo ícono

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5ECE3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                icono,
                                size: 40,
                                color: Colors.black,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${ejercicio['nombre']}', // Muestra el nombre
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Id: ${ejercicio['id']}', // Muestra el id
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                // Eliminar el ejercicio cuando se presiona el ícono de basurero
                                _removeExercise(index);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _confirmSaveRoutine,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFF5ECE3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(S.current.guardar),
                ),
                ElevatedButton(
                  onPressed: _navigateAndAddExercises,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFF5ECE3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(S.current.agrega_nuevo_ejercicio),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
