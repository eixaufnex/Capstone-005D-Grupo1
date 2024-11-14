import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/rutinas_screen/1_rutinas_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/publicaciones_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/perfil_screen/perfil_screen.dart';
import 'package:seguimiento_deportes/core/services/rutina_ejercicio_service.dart';

class GraficosScreen extends StatefulWidget {
  const GraficosScreen({super.key});

  @override
  State<GraficosScreen> createState() => _GraficosScreenState();
}

class _GraficosScreenState extends State<GraficosScreen> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> rutinas = [];
  String? firebaseId;
  String? selectedRutina;
  String? selectedEjercicio;

  int _selectedIndex = 3;
  String _selectedTab = 'Diario';

  @override
  void initState() {
    super.initState();
    _getFirebaseIdAndFetchData();
  }

  Future<void> _getFirebaseIdAndFetchData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        firebaseId = user.uid;
      });
      await _fetchRutinasAndEjercicios();
    } else {
      print("Usuario no autenticado");
    }
  }

  Future<void> _fetchRutinasAndEjercicios() async {
    if (firebaseId == null) return;

    final data = await apiService.getRutinasAndEjerciciosByUser(firebaseId!);

    if (data != null) {
      Map<int, Map<String, dynamic>> rutinasMap = {};

      for (var item in data) {
        int idRutina = item['id_rutina'];
        if (!rutinasMap.containsKey(idRutina)) {
          rutinasMap[idRutina] = {
            'id_rutina': idRutina,
            'nombre_rutina': item['nombre_rutina'],
            'ejercicios': []
          };
        }

        rutinasMap[idRutina]?['ejercicios'].add({
          'id_lista_ejercicio': item['id_lista_ejercicio'],
          'nombre_ejercicio': item['nombre_ejercicio'],
          'series': item['series'],
          'repeticiones': item['repeticiones'],
          'peso': item['peso'],
          'rpe': item['rpe'],
          'tiempo_ejercicio': item['tiempo_ejercicio'],
          'fecha_rutina': item['fecha_rutina'],
        });
      }

      setState(() {
        rutinas = rutinasMap.values.toList();
      });
    } else {
      print("Error al obtener las rutinas y ejercicios");
    }
  }

  List<BarChartGroupData> _getBarChartGroups() {
    if (_selectedTab == 'Diario') {
      Map<int, List<double>> tiempoPorDia = {
        0: [],
        1: [],
        2: [],
        3: [],
        4: [],
        5: [],
        6: []
      };

      for (var rutina in rutinas) {
        if (rutina['id_rutina'] == int.tryParse(selectedRutina ?? '')) {
          var ejercicios = rutina['ejercicios'] as List<dynamic>;

          for (var ejercicio in ejercicios) {
            if (selectedEjercicio == null ||
                ejercicio['nombre_ejercicio'] == selectedEjercicio) {
              DateTime fecha = DateTime.parse(ejercicio['fecha_rutina']);
              double tiempo = ejercicio['tiempo_ejercicio']?.toDouble() ?? 0;
              int diaSemana = fecha.weekday - 1;
              tiempoPorDia[diaSemana]?.add(tiempo);
            }
          }
        }
      }

      return tiempoPorDia.entries.map((entry) {
        double promedio = entry.value.isNotEmpty
            ? double.parse(
                (entry.value.reduce((a, b) => a + b) / entry.value.length)
                    .toStringAsFixed(2))
            : 0.0;
        return BarChartGroupData(
          x: entry.key,
          barRods: [BarChartRodData(toY: promedio)],
        );
      }).toList();
    } else if (_selectedTab == 'Mensual') {
      Map<int, List<double>> tiempoPorMes = {
        1: [],
        2: [],
        3: [],
        4: [],
        5: [],
        6: [],
        7: [],
        8: [],
        9: [],
        10: [],
        11: [],
        12: []
      };

      for (var rutina in rutinas) {
        if (rutina['id_rutina'] == int.tryParse(selectedRutina ?? '')) {
          var ejercicios = rutina['ejercicios'] as List<dynamic>;

          for (var ejercicio in ejercicios) {
            if (selectedEjercicio == null ||
                ejercicio['nombre_ejercicio'] == selectedEjercicio) {
              DateTime fecha = DateTime.parse(ejercicio['fecha_rutina']);
              double tiempo = ejercicio['tiempo_ejercicio']?.toDouble() ?? 0;
              int mes = fecha.month;
              tiempoPorMes[mes]?.add(tiempo);
            }
          }
        }
      }

      return tiempoPorMes.entries.map((entry) {
        double promedio = entry.value.isNotEmpty
            ? double.parse(
                (entry.value.reduce((a, b) => a + b) / entry.value.length)
                    .toStringAsFixed(2))
            : 0.0;
        return BarChartGroupData(
          x: entry.key,
          barRods: [BarChartRodData(toY: promedio)],
        );
      }).toList();
    } else {
      return [];
    }
  }

  List<FlSpot> _getLineChartSpots() {
    Map<int, List<double>> pesoPorDiaOMes = (_selectedTab == 'Diario')
        ? {0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 6: []}
        : {
            1: [],
            2: [],
            3: [],
            4: [],
            5: [],
            6: [],
            7: [],
            8: [],
            9: [],
            10: [],
            11: [],
            12: []
          };

    for (var rutina in rutinas) {
      if (rutina['id_rutina'] == int.tryParse(selectedRutina ?? '')) {
        var ejercicios = rutina['ejercicios'] as List<dynamic>;

        for (var ejercicio in ejercicios) {
          if (selectedEjercicio == null ||
              ejercicio['nombre_ejercicio'] == selectedEjercicio) {
            DateTime fecha = DateTime.parse(ejercicio['fecha_rutina']);
            double peso = ejercicio['peso']?.toDouble() ?? 0;
            int index =
                (_selectedTab == 'Diario') ? fecha.weekday - 1 : fecha.month;
            pesoPorDiaOMes[index]?.add(peso);
          }
        }
      }
    }

    return pesoPorDiaOMes.entries.map((entry) {
      double promedio = entry.value.isNotEmpty
          ? double.parse(
              (entry.value.reduce((a, b) => a + b) / entry.value.length)
                  .toStringAsFixed(2))
          : 0.0;
      return FlSpot(entry.key.toDouble(), promedio);
    }).toList();
  }

  Widget _buildBarChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rendimiento Físico',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 190,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 25,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        if (_selectedTab == 'Diario') {
                          const days = [
                            'Lun',
                            'Mar',
                            'Mié',
                            'Jue',
                            'Vie',
                            'Sáb',
                            'Dom'
                          ];
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(days[value.toInt() % 7]),
                          );
                        } else if (_selectedTab == 'Mensual') {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text((value.toInt() + 1).toString()),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                barGroups: _getBarChartGroups(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Progreso de Entrenamiento',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 198,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 25,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        if (_selectedTab == 'Diario') {
                          const days = [
                            'Lun',
                            'Mar',
                            'Mié',
                            'Jue',
                            'Vie',
                            'Sáb',
                            'Dom'
                          ];
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(days[value.toInt() % 7]),
                          );
                        } else if (_selectedTab == 'Mensual') {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text((value.toInt() + 1).toString()),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: _getLineChartSpots(),
                    isCurved: true,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Filtrar"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedRutina,
                hint: const Text("Seleccionar Rutina"),
                onChanged: (value) {
                  setState(() {
                    selectedRutina = value;
                    selectedEjercicio = null;
                  });
                },
                items: rutinas.map((rutina) {
                  return DropdownMenuItem<String>(
                    value: rutina['id_rutina'].toString(),
                    child: Text(rutina['nombre_rutina']),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                value: selectedEjercicio,
                hint: const Text("Seleccionar Ejercicio"),
                onChanged: (value) {
                  setState(() {
                    selectedEjercicio = value;
                  });
                },
                items: (rutinas.firstWhere(
                        (rutina) =>
                            rutina['id_rutina'].toString() == selectedRutina,
                        orElse: () => {'ejercicios': []})['ejercicios'] as List)
                    .map((ejercicio) => ejercicio['nombre_ejercicio'])
                    .toSet()
                    .map((nombreEjercicio) => DropdownMenuItem<String>(
                          value: nombreEjercicio,
                          child: Text(nombreEjercicio),
                        ))
                    .toList(),
              )
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
                Navigator.of(context).pop();
              },
              child: const Text("Aplicar"),
            ),
          ],
        );
      },
    );
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
              ],
            ),
            const SizedBox(height: 20),
            _buildBarChartSection(),
            const SizedBox(height: 20),
          ],
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
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.view_list_rounded), label: 'Rutinas'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle, size: 45), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.stacked_line_chart_rounded),
                  label: 'Progreso'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Perfil'),
            ],
          ),
        ),
      ),
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
}
