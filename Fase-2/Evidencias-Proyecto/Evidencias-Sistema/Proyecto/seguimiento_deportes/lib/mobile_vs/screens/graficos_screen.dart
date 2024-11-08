import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
            _buildLineChartSection(),
            const SizedBox(height: 20),
            _buildBarChartSection(),
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
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
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
              const BottomNavigationBarItem(
                icon: Icon(Icons.stacked_line_chart_rounded),
                label: 'Progreso',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Perfil',
              ),
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
                  color: Colors.blue, // Cambiado para usar un solo color
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
          'Dias ',
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
}
