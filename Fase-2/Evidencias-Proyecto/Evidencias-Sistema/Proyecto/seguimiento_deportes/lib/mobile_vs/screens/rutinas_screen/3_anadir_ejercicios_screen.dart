import 'package:flutter/material.dart';

class AnadirEjerciciosScreen extends StatefulWidget {
  const AnadirEjerciciosScreen({super.key});

  @override
  _AnadirEjerciciosScreenState createState() => _AnadirEjerciciosScreenState();
}

class _AnadirEjerciciosScreenState extends State<AnadirEjerciciosScreen> {
  // Lista de días y su estado de selección
  final List<String> days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
  final Map<String, bool> selectedDays = {
    'Lunes': false,
    'Martes': false,
    'Miércoles': false,
    'Jueves': false,
    'Viernes': false,
    'Sábado': false,
    'Domingo': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombre tipo ejercicio', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'home');
          },
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "los ejercicios de fuerza son... los ejercicios de fuerza son... los ejercicios de fuerza son...",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Nombre rutina',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4, // Ajusta el número de elementos según necesites
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5ECE3), // Fondo color crema
                          borderRadius: BorderRadius.circular(12), // Bordes redondeados
                        ),
                        child: const Icon(
                          Icons.fitness_center,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        index == 0 ? 'Press banca' : 'Sentadilla',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('03 Series | 12 Reps'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Acción de editar

                          Navigator.pushReplacementNamed(context, 'rutina_detalle');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color(0xFFF5ECE3), // Color del fondo del botón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Editar'),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Selecciona los días de la semana',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: days.map((day) {
                return FilterChip(
                  label: Text(day),
                  selected: selectedDays[day] ?? false,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedDays[day] = selected;
                    });
                  },
                  selectedColor: const Color(0xFFF5ECE3),
                  checkmarkColor: Colors.black,
                  labelStyle: TextStyle(color: selectedDays[day]! ? Colors.black : Colors.grey),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'seleccion');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFF5ECE3), // Color del fondo del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Agrega un nuevo ejercicio'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
