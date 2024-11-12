import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/models/ejercicio.dart';
import 'package:seguimiento_deportes/core/models/rutina.dart';
import 'package:seguimiento_deportes/core/providers/rutina_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/1_rutinas_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/perfil_screen.dart';

class GraficosScreen extends StatefulWidget {
  const GraficosScreen({super.key});

  @override
  State<GraficosScreen> createState() => _GraficosScreenState();
}

class _GraficosScreenState extends State<GraficosScreen> {
  int _selectedIndex = 3;
  String _selectedTab = 'Yearly';
  int? _selectedRoutineId;
  int? _selectedExerciseId;

  @override
  void initState() {
    super.initState();
    final rutinaProvider = Provider.of<RutinaProvider>(context, listen: false);
    rutinaProvider.initializeUserRutinas();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RutinaScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PublicacionesScreen()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PerfilScreen()),
      );
    }
  }

  void _showFilterDialog() {
    final rutinaProvider = Provider.of<RutinaProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Filtrar"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dropdown para seleccionar la rutina
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: "Seleccionar Rutina"),
                value: _selectedRoutineId,
                items: rutinaProvider.rutinas.map((Rutina rutina) {
                  return DropdownMenuItem<int>(
                    value: rutina.idRutina,
                    child: Text(rutina.nombreRutina),
                  );
                }).toList(),
                onChanged: (value) async {
                  setState(() {
                    _selectedRoutineId = value;
                    _selectedExerciseId = null; // Resetea el ejercicio seleccionado
                  });
                  if (value != null) {
                    await rutinaProvider.getEjerciciosDeRutina(value); // Carga los ejercicios de la rutina seleccionada
                  }
                },
              ),
              // Dropdown para seleccionar el ejercicio si se ha seleccionado una rutina
              if (_selectedRoutineId != null)
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: "Seleccionar Ejercicio"),
                  value: _selectedExerciseId,
                  items: rutinaProvider.ejerciciosDeRutina.map((Ejercicio ejercicio) {
                    return DropdownMenuItem<int>(
                      value: ejercicio.idListaEjercicio,
                      child: Text(ejercicio.nombreEjercicio),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedExerciseId = value;
                    });
                  },
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                // Aplica el filtro usando _selectedRoutineId y _selectedExerciseId
                if (_selectedRoutineId != null) {
                  rutinaProvider.getEjerciciosDeRutina(_selectedRoutineId!);
                }
                Navigator.of(context).pop();
              },
              child: const Text("Aplicar"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilteredExercisesList() {
    final rutinaProvider = Provider.of<RutinaProvider>(context);
    if (_selectedRoutineId != null && rutinaProvider.ejerciciosDeRutina.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ejercicios Filtrados:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...rutinaProvider.ejerciciosDeRutina.map((ejercicio) {
            return ListTile(
              title: Text(ejercicio.nombreEjercicio),
              onTap: () {
                setState(() {
                  _selectedExerciseId = ejercicio.idListaEjercicio;
                });
              },
            );
          }).toList(),
        ],
      );
    } else {
      return const SizedBox.shrink(); // Retorna un espacio vacío si no hay rutina seleccionada o ejercicios cargados
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gráficos',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton('Diario'),
                _buildTabButton('Mensual'),
                _buildTabButton('Anual'),
              ],
            ),
            const SizedBox(height: 20),
            _buildFilteredExercisesList(), // Muestra la lista de ejercicios filtrados
            const SizedBox(height: 20),
            _buildLineChartSection(),
            const SizedBox(height: 20),
            _buildBarChartSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTabButton(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: _selectedTab == title ? Colors.grey[300] : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _selectedTab == title ? Colors.blue : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildLineChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Revenue',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: true),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 1),
                    FlSpot(1, 3),
                    FlSpot(2, 2),
                    FlSpot(3, 5),
                    FlSpot(4, 3.1),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 4,
                  dotData: FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBarChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dias',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: true),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(toY: 5, color: Colors.blue)]),
                BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(toY: 1, color: Colors.blue)]),
                BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(toY: 1.5, color: Colors.blue)]),
                BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(toY: 1, color: Colors.blue)]),
                BarChartGroupData(
                    x: 4,
                    barRods: [BarChartRodData(toY: 4, color: Colors.blue)]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Padding(
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list_rounded),
              label: 'Rutinas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, size: 45),
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
    );
  }
}
