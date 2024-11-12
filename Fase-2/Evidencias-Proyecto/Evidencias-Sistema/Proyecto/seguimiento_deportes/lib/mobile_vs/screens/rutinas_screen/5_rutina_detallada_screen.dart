import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/models/rutina_detallada.dart';
import 'package:seguimiento_deportes/core/providers/rutina_detallada_provider.dart';

class Series {
  int reps;
  int weight;
  int rpe;

  Series({this.reps = 0, this.weight = 0, this.rpe = 1});
}

class RutinaDetalladaScreen extends StatefulWidget {
  final int rutinaId;
  final int idListaEjercicio;

  const RutinaDetalladaScreen({
    Key? key,
    required this.rutinaId,
    required this.idListaEjercicio,
  }) : super(key: key);

  @override
  _RutinaDetalladaScreenState createState() => _RutinaDetalladaScreenState();
}

class _RutinaDetalladaScreenState extends State<RutinaDetalladaScreen> {
  int sets = 1;
  List<Series> seriesList = [];
  final TextEditingController _commentsController = TextEditingController();
  double e1rm = 0;
  int tonelaje = 0;
  late int startTime; // Almacena el tiempo de entrada en segundos

  @override
  void initState() {
    super.initState();
    seriesList = List.generate(sets, (index) => Series());
    startTime = DateTime.now().millisecondsSinceEpoch; // Registrar tiempo de inicio
  }

  void _updateSets(int value) {
    setState(() {
      sets = value;
      if (seriesList.length < sets) {
        seriesList.addAll(List.generate(sets - seriesList.length, (_) => Series()));
      } else if (seriesList.length > sets) {
        seriesList = seriesList.sublist(0, sets);
      }
      _calculateMetrics();
    });
  }

  void _calculateMetrics() {
    double maxE1RM = 0;
    int totalTonelaje = 0;

    for (var series in seriesList) {
      double currentE1RM = series.weight * (1 + series.reps / 30.0);
      maxE1RM = currentE1RM > maxE1RM ? currentE1RM : maxE1RM;
      totalTonelaje += series.reps * series.weight;
    }

    setState(() {
      e1rm = maxE1RM;
      tonelaje = totalTonelaje;
    });
  }

  Future<void> _saveSeriesData() async {
    final provider = Provider.of<RutinaDetalladaProvider>(context, listen: false);

    // Calcular el tiempo en segundos desde que se ingresó a la pantalla
    int endTime = DateTime.now().millisecondsSinceEpoch;
    int tiempoPermanencia = ((endTime - startTime) / 1000).round(); // Tiempo en segundos

    for (int i = 0; i < seriesList.length; i++) {
      final series = seriesList[i];
      final rutinaDetallada = RutinaDetallada(
        idRutinaDetallada: 0,
        series: i + 1,
        repeticiones: series.reps,
        peso: series.weight.toDouble(),
        rpe: series.rpe,
        tiempoEjercicio: tiempoPermanencia, // Guardar el tiempo de permanencia en descanso
        fechaRutina: DateTime.now(),
        diasRutina: "Día",
        comentarios: _commentsController.text,
        idRutina: widget.rutinaId,
        idListaEjercicio: widget.idListaEjercicio,
      );

      await provider.postRutinaDetallada(rutinaDetallada);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Datos guardados exitosamente para el ejercicio específico')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            'Progreso',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(text: "Rutina Actual"),
              Tab(text: "Historial de Progreso"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCurrentRoutineTab(),
            _buildHistoryTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentRoutineTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCounterRow('Series', sets, _updateSets),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: sets,
            itemBuilder: (context, index) {
              return _buildSeriesBlock(index);
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Observaciones',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _commentsController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Añade tus sensaciones en la rutina',
              fillColor: Colors.orange[200],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildCalculationsSection(),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: _saveSeriesData,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Guardar', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculationsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCalculationCard(Icons.show_chart, 'E1RM', e1rm.toStringAsFixed(1)),
        _buildCalculationCard(Icons.fitness_center, 'Tonelaje', tonelaje.toString()),
      ],
    );
  }

  Widget _buildCalculationCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Consumer<RutinaDetalladaProvider>(
      builder: (context, provider, child) {
        final historial = provider.rutinasDetalladas
            .where((rutina) =>
                rutina.idRutina == widget.rutinaId &&
                rutina.idListaEjercicio == widget.idListaEjercicio)
            .toList();

        if (historial.isEmpty) {
          return Center(child: Text("No hay historial disponible."));
        }

        final Map<String, List<RutinaDetallada>> groupedByDate = {};
        for (var rutina in historial) {
          final dateKey = DateFormat('dd/MM/yyyy').format(rutina.fechaRutina);
          if (groupedByDate.containsKey(dateKey)) {
            groupedByDate[dateKey]!.add(rutina);
          } else {
            groupedByDate[dateKey] = [rutina];
          }
        }

        return ListView(
          children: groupedByDate.entries.map((entry) {
            final date = entry.key;
            final routinesOnDate = entry.value;
            final comentario = routinesOnDate.first.comentarios;

            return ExpansionTile(
              title: Text("Progreso del: $date"),
              subtitle: comentario != null && comentario.isNotEmpty
                  ? Text("Comentarios: $comentario")
                  : null,
              children: routinesOnDate.map((rutina) {
                return ListTile(
                  title: Text("Serie ${rutina.series}"),
                  subtitle: Text("Reps: ${rutina.repeticiones}, Peso: ${rutina.peso} kg, RPE: ${rutina.rpe}"),
                );
              }).toList(),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSeriesBlock(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Serie ${index + 1}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Reps',
                      initialValue: seriesList[index].reps.toString(),
                      onChanged: (value) {
                        setState(() {
                          seriesList[index].reps = int.tryParse(value) ?? 0;
                          _calculateMetrics();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTextField(
                      label: 'Peso (kg)',
                      initialValue: seriesList[index].weight.toString(),
                      onChanged: (value) {
                        setState(() {
                          seriesList[index].weight = int.tryParse(value) ?? 0;
                          _calculateMetrics();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildCompactCounter(
                      label: 'RPE',
                      value: seriesList[index].rpe,
                      onChanged: (newValue) => setState(() => seriesList[index].rpe = newValue),
                      min: 1,
                      max: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required ValueChanged<String> onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildCompactCounter({
    required String label,
    required int value,
    required ValueChanged<int> onChanged,
    int min = 0,
    int max = 999,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                if (value > min) onChanged(value - 1);
              },
              icon: const Icon(Icons.remove, size: 18, color: Colors.grey),
              constraints: const BoxConstraints.tightFor(width: 24, height: 24),
              padding: EdgeInsets.zero,
            ),
            Text('$value', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: () {
                if (value < max) onChanged(value + 1);
              },
              icon: const Icon(Icons.add, size: 18, color: Colors.grey),
              constraints: const BoxConstraints.tightFor(width: 24, height: 24),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCounterRow(String label, int value, ValueChanged<int> onChanged, {int min = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (value > min) onChanged(value - 1);
                },
                icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
              ),
              Text('$value', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                onPressed: () {
                  onChanged(value + 1);
                },
                icon: const Icon(Icons.add_circle_outline, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
