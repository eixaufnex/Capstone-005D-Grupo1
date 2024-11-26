import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:seguimiento_deportes/core/providers/objetivo_provider.dart';
import 'package:seguimiento_deportes/core/models/objetivo.dart';
import 'package:seguimiento_deportes/core/providers/perfil_provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';
import 'package:seguimiento_deportes/generated/l10n.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/auth_screen/login_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/home_screen/home_screen.dart';
import 'package:seguimiento_deportes/mobile_vs/screens/menu_screen/glosario_screen.dart';
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
    _fetchUserAvatar();
  }

  String avatarUrl = 'assets/av9.png';

  Future<void> _fetchUserAvatar() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final perfilProvider =
          Provider.of<PerfilProvider>(context, listen: false);
      final perfil = await perfilProvider.getPerfil(user.uid);
      if (perfil != null && perfil.fotoPerfil != null) {
        setState(() {
          avatarUrl = perfil.fotoPerfil!;
        });
      }
    }
  }

  Future<void> _fetchUsername() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String username =
          await Provider.of<UsuarioProvider>(context, listen: false)
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
        title: Text(
          S.current.objetivos1,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                      radius: 40,
                      backgroundImage: avatarUrl.startsWith('http')
                          ? NetworkImage(avatarUrl)
                          : AssetImage(avatarUrl)
                              as ImageProvider, // Mostrar desde la BD o local
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
              title: Text(S.current.home),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text(S.current.listaejercicio1),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Lista_EjercicioScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_events),
              title: Text(S.current.logros1),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogrosScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.menu_book_rounded),
              title: Text(S.current.glosario1),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GlosarioScreen()));
              },
            ),
            SizedBox(height: 260),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[200],
                ),
                onPressed: () async {
                  await _signOut();
                },
                child: Text(S.current.cerrarsesion,
                    style: TextStyle(color: Colors.black)),
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
              labelColor: Colors.purple, // Color para la pestaña seleccionada
              unselectedLabelColor:
                  Colors.black54, // Color para las pestañas no seleccionadas
              tabs: [
                Tab(text: S.current.En_progreso),
                Tab(text: S.current.Completadas),
                Tab(text: S.current.Sin_comenzar),
              ],
            ),
            Expanded(
              child: objetivoProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                      children: [
                        // Filtrar objetivos "En progreso"
                        ListView.builder(
                          itemCount:
                              objetivoProvider.objetivosEnProgreso.length,
                          itemBuilder: (context, index) {
                            final objetivo =
                                objetivoProvider.objetivosEnProgreso[index];
                            final porcentaje = ((objetivo.valorActual -
                                        objetivo.valorInicial) /
                                    (objetivo.valorObjetivo -
                                        objetivo.valorInicial) *
                                    100)
                                .clamp(0, 100)
                                .toInt();

                            return Card(
                              margin: const EdgeInsets.all(10),
                              color: Colors.yellow[50],
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      // Centra el título
                                      child: Text(
                                        objetivo.nombreObjetivo,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              20, // Tamaño de la fuente aumentado
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center, // Centra verticalmente el contenido
                                      children: [
                                        Expanded(
                                          // Usa Expanded para que los textos ocupen el espacio disponible
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${S.current.descripcion}: ${objetivo.descripcionObjetivo ?? S.current.sin_descripcion}'),
                                              Text(
                                                  '${S.current.valor_inicial}: ${objetivo.valorInicial}'),
                                              Text(
                                                  '${S.current.valor_actual}: ${objetivo.valorActual}'),
                                              Text(
                                                  '${S.current.valor_final}: ${objetivo.valorObjetivo}'),
                                              Text(
                                                  '${S.current.progreso}: $porcentaje%'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                20), // Más espacio entre el texto y el indicador
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 36.0,
                                              top:
                                                  8.0), // Espaciado a la derecha y arriba
                                          child: SizedBox(
                                            width:
                                                50, // Ancho deseado para el indicador
                                            height:
                                                50, // Alto deseado para el indicador
                                            child: CircularProgressIndicator(
                                              value: porcentaje / 100,
                                              strokeWidth:
                                                  8, // Grosor del indicador
                                              color: Colors
                                                  .purple, // Color del indicador
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            _showEditModal(context, objetivo);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () async {
                                            final confirmDelete =
                                                await showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                    "Eliminar Objetivo"),
                                                content: const Text(
                                                    "¿Estás seguro de que deseas eliminar este objetivo?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child:
                                                        const Text("Cancelar"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child:
                                                        const Text("Eliminar"),
                                                  ),
                                                ],
                                              ),
                                            );
                                            if (confirmDelete == true) {
                                              objetivoProvider.deleteObjetivo(
                                                  objetivo.idObjetivo);
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
                        ),
                        // Filtrar objetivos "Completadas"
                        ListView.builder(
                          itemCount:
                              objetivoProvider.objetivosCompletados.length,
                          itemBuilder: (context, index) {
                            final objetivo =
                                objetivoProvider.objetivosCompletados[index];

                            return Card(
                              margin: const EdgeInsets.all(10),
                              color: Colors.green[50],
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Centra el contenido horizontalmente
                                  children: [
                                    Center(
                                      // Centra el título
                                      child: Text(
                                        objetivo.nombreObjetivo,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              20, // Tamaño de la fuente aumentado
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center, // Centra verticalmente el contenido
                                      children: [
                                        Expanded(
                                          // Usa Expanded para que los textos ocupen el espacio disponible
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${S.current.descripcion}: ${objetivo.descripcionObjetivo ?? S.current.sin_descripcion}'),
                                              Text(
                                                  '${S.current.valor_inicial}: ${objetivo.valorInicial}'),
                                              Text(
                                                  '${S.current.valor_actual}: ${objetivo.valorActual}'),
                                              Text(
                                                  '${S.current.valor_final}: ${objetivo.valorObjetivo}'),
                                              Text(
                                                  '${S.current.progreso}: 100%'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                20), // Más espacio entre el texto y el indicador
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 36.0,
                                              top:
                                                  8.0), // Espaciado a la derecha y arriba
                                          child: SizedBox(
                                            width:
                                                50, // Ancho deseado para el indicador
                                            height:
                                                50, // Alto deseado para el indicador
                                            child: CircularProgressIndicator(
                                              value: 1.0,
                                              strokeWidth:
                                                  8, // Grosor del indicador
                                              color: Colors
                                                  .green, // Color del indicador
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            _showEditModal(context, objetivo);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () async {
                                            final confirmDelete =
                                                await showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                    "Eliminar Objetivo"),
                                                content: const Text(
                                                    "¿Estás seguro de que deseas eliminar este objetivo?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child:
                                                        const Text("Cancelar"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child:
                                                        const Text("Eliminar"),
                                                  ),
                                                ],
                                              ),
                                            );
                                            if (confirmDelete == true) {
                                              objetivoProvider.deleteObjetivo(
                                                  objetivo.idObjetivo);
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
                        ),
                        // Filtrar objetivos "Sin comenzar"
                        ListView.builder(
                          itemCount:
                              objetivoProvider.objetivosSinComenzar.length,
                          itemBuilder: (context, index) {
                            final objetivo =
                                objetivoProvider.objetivosSinComenzar[index];

                            return Card(
                              margin: const EdgeInsets.all(10),
                              color: Colors.red[50],
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Centra el contenido horizontalmente
                                  children: [
                                    Center(
                                      // Centra el título
                                      child: Text(
                                        objetivo.nombreObjetivo,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              20, // Tamaño de la fuente aumentado
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center, // Centra verticalmente el contenido
                                      children: [
                                        Expanded(
                                          // Usa Expanded para que los textos ocupen el espacio disponible
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${S.current.descripcion}: ${objetivo.descripcionObjetivo ?? S.current.sin_descripcion}'),
                                              Text(
                                                  '${S.current.valor_inicial}: ${objetivo.valorInicial}'),
                                              Text(
                                                  '${S.current.valor_actual}: ${objetivo.valorActual}'),
                                              Text(
                                                  '${S.current.valor_final}: ${objetivo.valorObjetivo}'),
                                              Text('${S.current.progreso}: 0%'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 36.0, top: 8.0),
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CircularProgressIndicator(
                                              value: 0.0,
                                              strokeWidth: 8,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            _showEditModal(context, objetivo);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () async {
                                            final confirmDelete =
                                                await showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(S
                                                    .current.eliminar_objetivo),
                                                content: Text(
                                                    S.current.estas_seguro),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child: Text(
                                                        S.current.cancelar),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: Text(
                                                        S.current.eliminar),
                                                  ),
                                                ],
                                              ),
                                            );
                                            if (confirmDelete == true) {
                                              objetivoProvider.deleteObjetivo(
                                                  objetivo.idObjetivo);
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
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF5ECE3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black12,
            width: 2,
          ),
        ),
        padding: EdgeInsets.all(4), // Espacio entre el borde y el botón
        child: FloatingActionButton(
          onPressed: () => _showCreateObjetivoModal(context, objetivoProvider),
          backgroundColor: Color(0xFFF5ECE3), // Color interno del botón
          child: const Icon(Icons.add),
          elevation: 0, // Eliminar sombra si lo prefieres
        ),
      ),
    );
  }

  void _showEditModal(BuildContext context, Objetivo objetivo) {
    final valorActualController =
        TextEditingController(text: objetivo.valorActual.toString());

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(S.current.Editar_valor),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: valorActualController,
                  decoration:
                      InputDecoration(labelText: S.current.valor_actual),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(S.current.cancelar),
            ),
            ElevatedButton(
              onPressed: () {
                final nuevoValorActual =
                    int.tryParse(valorActualController.text);
                if (nuevoValorActual != null) {
                  Provider.of<ObjetivoProvider>(context, listen: false)
                      .updateValorActual(objetivo.idObjetivo, nuevoValorActual);
                  Navigator.pop(dialogContext);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.current.valor_valido)),
                  );
                }
              },
              child: Text(S.current.Actualizar),
            ),
          ],
        );
      },
    );
  }

  void _showCreateObjetivoModal(
      BuildContext context, ObjetivoProvider provider) {
    final nombreController = TextEditingController();
    final descripcionController = TextEditingController();
    final valorInicialController = TextEditingController();
    final valorActualController = TextEditingController();
    final valorObjetivoController = TextEditingController();
    DateTime? fechaLimite;
    String tipoObjetivo = S.current.Dieta;

    final user = FirebaseAuth.instance.currentUser;
    final firebaseId = user?.uid;

    if (firebaseId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.current.error_usuario)),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.current.crear_objetivo),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: tipoObjetivo,
                  decoration:
                      InputDecoration(labelText: S.current.tipo_objetivo),
                  items: [
                    S.current.Dieta,
                    S.current.nuevos_pesos,
                    S.current.nuevos_porcentaje,
                    S.current.Aumento_rep,
                    S.current.Reduccion_tiempo
                  ]
                      .map((tipo) =>
                          DropdownMenuItem(value: tipo, child: Text(tipo)))
                      .toList(),
                  onChanged: (value) => tipoObjetivo = value!,
                ),
                TextField(
                  controller: nombreController,
                  decoration:
                      InputDecoration(labelText: S.current.Titulo_objetivo),
                ),
                TextField(
                  controller: descripcionController,
                  decoration: InputDecoration(labelText: S.current.descripcion),
                ),
                TextField(
                  controller: valorInicialController,
                  decoration:
                      InputDecoration(labelText: S.current.valor_inicial),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: valorActualController,
                  decoration:
                      InputDecoration(labelText: S.current.valor_actual),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: valorObjetivoController,
                  decoration: InputDecoration(labelText: S.current.valor_final),
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
                      ? S.current.seleccionar_fecha
                      : "${S.current.fecha_limite}: ${fechaLimite!.toLocal()}"
                          .split(' ')[0]),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.current.cancelar),
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
                  valorObjetivo:
                      int.tryParse(valorObjetivoController.text) ?? 0,
                  fechaLimite: fechaLimite ?? DateTime.now(),
                  alcanzado: "no",
                  firebaseId: firebaseId,
                );

                provider.createObjetivo(nuevoObjetivo);
                Navigator.pop(context);
              },
              child: Text(S.current.guardar_objetivo),
            ),
          ],
        );
      },
    );
  }
}
