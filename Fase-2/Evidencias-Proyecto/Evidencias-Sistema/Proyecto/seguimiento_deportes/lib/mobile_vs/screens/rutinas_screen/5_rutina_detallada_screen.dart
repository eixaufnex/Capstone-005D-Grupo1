import 'package:flutter/material.dart';

class Series {
  int reps;
  int weight;
  int rpe;

  Series({this.reps = 8, this.weight = 50, this.rpe = 7});
}

class RutinaDetalladaScreen extends StatefulWidget {
  const RutinaDetalladaScreen({super.key});

  @override
  _RutinaDetalladaScreenState createState() => _RutinaDetalladaScreenState();
}

class _RutinaDetalladaScreenState extends State<RutinaDetalladaScreen> {
  int sets = 1;
  List<Series> seriesList = [];
  final TextEditingController _commentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    seriesList = List.generate(sets, (index) => Series());
  }

  void _updateSets(int value) {
    setState(() {
      sets = value;
      if (seriesList.length < sets) {
        seriesList.addAll(List.generate(sets - seriesList.length, (_) => Series()));
      } else if (seriesList.length > sets) {
        seriesList = seriesList.sublist(0, sets);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutina Detallada', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'anadir');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCounterRow('Series', sets, _updateSets),
            Expanded(
              child: ListView.builder(
                itemCount: sets,
                itemBuilder: (context, index) {
                  return _buildSeriesBlock(index);
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Comentarios',
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
            Center(
              child: ElevatedButton(
                onPressed: _saveRoutine,
                child: const Text('Guardar', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCompactCounter('Reps', seriesList[index].reps, (value) => setState(() => seriesList[index].reps = value)),
                  _buildCompactCounter('Peso', seriesList[index].weight, (value) => setState(() => seriesList[index].weight = value), unit: 'kg'),
                  _buildCompactCounter('RPE', seriesList[index].rpe, (value) => setState(() => seriesList[index].rpe = value), min: 1, max: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactCounter(String label, int value, ValueChanged<int> onChanged, {String unit = '', int min = 0, int max = 999}) {
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

  void _saveRoutine() {
    final comments = _commentsController.text;
    for (var i = 0; i < seriesList.length; i++) {
      print('Serie ${i + 1}: Reps: ${seriesList[i].reps}, Peso: ${seriesList[i].weight}, RPE: ${seriesList[i].rpe}');
    }
    print('Comentarios: $comments');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rutina guardada con éxito')),
    );
  }
}
