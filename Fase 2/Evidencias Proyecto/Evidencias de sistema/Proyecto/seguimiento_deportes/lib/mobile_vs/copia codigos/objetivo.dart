import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/objetivo_provider.dart';
import 'package:seguimiento_deportes/core/models/objetivo.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/login_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/list_ejercicios_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/logros_screen.dart';


class ObjetivosScreen extends StatefulWidget {
  const ObjetivosScreen({super.key});

  @override
  _ObjetivosScreenState createState() => _ObjetivosScreenState();
}

class _ObjetivosScreenState extends State<ObjetivosScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String usuario = "Cargando...";

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String username = await Provider.of<UsuarioProvider>(context, listen: false)
          .getUsername(user.uid);
      setState(() {
        usuario = username;
      });
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final objetivoProvider = Provider.of<ObjetivoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Objetivos"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40, // Tamaño de la imagen
                      backgroundImage: AssetImage('assets/miguelito.jpeg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      usuario,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Lista de ejercicios'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Lista_EjercicioScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_events),
              title: Text('Logros'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LogrosScreen()));
              },
            ),
            
            
            SizedBox(height: 280),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[200],
                ),
                onPressed: () async {
                  await _signOut();
                },
                child: Text('Cerrar sesión', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            // Sección de filtrado
            TabBar(
              tabs: [
                Tab(text: "En progreso"),
                Tab(text: "Completadas"),
                Tab(text: "Sin comenzar"),
              ],
            ),
            Expanded(
              child: objetivoProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                      children: [
                        ListView.builder(
                          itemCount: objetivoProvider.objetivos.length,
                          itemBuilder: (context, index) {
                            final objetivo = objetivoProvider.objetivos[index];
                            final porcentaje = ((objetivo.valorActual - objetivo.valorInicial) /
                                    (objetivo.valorObjetivo - objetivo.valorInicial) *
                                    100)
                                .clamp(0, 100)
                                .toInt();

                            return Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Text(objetivo.nombreObjetivo),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Descripción: ${objetivo.descripcionObjetivo ?? "Sin descripción"}'),
                                    Text('Valor inicial: ${objetivo.valorInicial}'),
                                    Text('Valor actual: ${objetivo.valorActual}'),
                                    Text('Valor final: ${objetivo.valorObjetivo}'),
                                    Text('Progreso: $porcentaje%'),
                                    const SizedBox(height: 10),
                                    CircularProgressIndicator(value: porcentaje / 100),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        _showEditModal(context, objetivo);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () async {
                                        final confirmDelete = await showDialog<bool>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("Eliminar Objetivo"),
                                            content: const Text("¿Estás seguro de que deseas eliminar este objetivo?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.of(context).pop(false),
                                                child: const Text("Cancelar"),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.of(context).pop(true),
                                                child: const Text("Eliminar"),
                                              ),
                                            ],
                                          ),
                                        );
                                        if (confirmDelete == true) {
                                          objetivoProvider.deleteObjetivo(objetivo.idObjetivo);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Center(child: Text("Completadas")),
                        Center(child: Text("Sin comenzar")),
                      ],
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateObjetivoModal(context, objetivoProvider),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditModal(BuildContext context, Objetivo objetivo) {
    final valorActualController = TextEditingController(text: objetivo.valorActual.toString());

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Editar Valor Actual"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: valorActualController,
                  decoration: const InputDecoration(labelText: "Valor Actual"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                final nuevoValorActual = int.tryParse(valorActualController.text);
                if (nuevoValorActual != null) {
                  Provider.of<ObjetivoProvider>(context, listen: false)
                      .updateValorActual(objetivo.idObjetivo, nuevoValorActual);
                  Navigator.pop(dialogContext);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Por favor, ingresa un valor válido.")),
                  );
                }
              },
              child: const Text("Actualizar"),
            ),
          ],
        );
      },
    );
  }

  void _showCreateObjetivoModal(BuildContext context, ObjetivoProvider provider) {
    final nombreController = TextEditingController();
    final descripcionController = TextEditingController();
    final valorInicialController = TextEditingController();
    final valorActualController = TextEditingController();
    final valorObjetivoController = TextEditingController();
    DateTime? fechaLimite;
    String tipoObjetivo = 'Dieta';

    final user = FirebaseAuth.instance.currentUser;
    final firebaseId = user?.uid;

    if (firebaseId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Usuario no autenticado")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Crear nuevo objetivo"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: tipoObjetivo,
                  decoration: const InputDecoration(labelText: "Tipo de objetivo"),
                  items: [
                    'Dieta',
                    'Nuevos pesos',
                    'Nuevo porcentaje',
                    'Aumento de repeticiones',
                    'Reducción de tiempos'
                  ].map((tipo) => DropdownMenuItem(value: tipo, child: Text(tipo))).toList(),
                  onChanged: (value) => tipoObjetivo = value!,
                ),
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: "Título del objetivo"),
                ),
                TextField(
                  controller: descripcionController,
                  decoration: const InputDecoration(labelText: "Descripción"),
                ),
                TextField(
                  controller: valorInicialController,
                  decoration: const InputDecoration(labelText: "Valor inicial"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: valorActualController,
                  decoration: const InputDecoration(labelText: "Valor actual"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: valorObjetivoController,
                  decoration: const InputDecoration(labelText: "Valor final"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    fechaLimite = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                  },
                  child: Text(fechaLimite == null
                      ? "Seleccionar fecha límite"
                      : "Fecha límite: ${fechaLimite!.toLocal()}".split(' ')[0]),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                final nuevoObjetivo = Objetivo(
                  idObjetivo: 0,
                  tipoObjetivo: tipoObjetivo,
                  nombreObjetivo: nombreController.text,
                  descripcionObjetivo: descripcionController.text,
                  valorInicial: int.tryParse(valorInicialController.text) ?? 0,
                  valorActual: int.tryParse(valorActualController.text) ?? 0,
                  valorObjetivo: int.tryParse(valorObjetivoController.text) ?? 0,
                  fechaLimite: fechaLimite ?? DateTime.now(),
                  alcanzado: "no",
                  firebaseId: firebaseId,
                );

                provider.createObjetivo(nuevoObjetivo);
                Navigator.pop(context);
              },
              child: const Text("Guardar objetivo"),
            ),
          ],
        );
      },
    );
  }
}
















