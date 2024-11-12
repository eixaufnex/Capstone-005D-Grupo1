import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seguimiento_deportes/core/models/perfil.dart';
import 'package:seguimiento_deportes/core/providers/perfil_provider.dart';
import 'package:seguimiento_deportes/core/providers/usuario_provider.dart';

class DatosGoogleScreen extends StatefulWidget {
  @override
  _DatosGoogleState createState() => _DatosGoogleState();
}

class _DatosGoogleState extends State<DatosGoogleScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController estaturaController = TextEditingController();
  String? selectedGender;
  String? selectedIntensity;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[100]!, Colors.grey[300]!],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            children: [
              SizedBox(height: size.height * 0.1),
              Text(
                "Completa los campos para una mejor experiencia de usuario",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              buildTextField(usernameController, "Nombre usuario", Icons.person),
              SizedBox(height: 20),
              buildTextField(nombreController, "Nombre", Icons.person),
              SizedBox(height: 20),
              buildTextField(apellidoController, "Apellido", Icons.person_outline),
              SizedBox(height: 20),
              buildNumericTextField(edadController, "Edad", Icons.cake),
              SizedBox(height: 20),
              buildNumericTextField(pesoController, "Peso (kg)", Icons.fitness_center),
              SizedBox(height: 20),
              buildNumericTextField(estaturaController, "Estatura (cm)", Icons.height),
              SizedBox(height: 20),
              buildDropdownField("Selecciona tu género", ["Hombre", "Mujer"], selectedGender, (value) {
                setState(() {
                  selectedGender = value;
                });
              }),
              SizedBox(height: 20),
              buildDropdownField("Nivel de intensidad", ["Principiante", "Medio", "Avanzado"], selectedIntensity, (value) {
                setState(() {
                  selectedIntensity = value;
                });
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _guardarDatos(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Guardar y continuar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "VitalityConnect",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffC0C0C0), width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white24,
      ),
    );
  }

  Widget buildNumericTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffC0C0C0), width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white24,
      ),
    );
  }

  Widget buildDropdownField(String label, List<String> items, String? value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffC0C0C0), width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white24,
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Future<void> _guardarDatos(BuildContext context) async {
    final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    final perfilProvider = Provider.of<PerfilProvider>(context, listen: false);
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("Error: el usuario no ha iniciado sesión.");
      return;
    }

    try {
      // Primero guardar firebase_id y username en la base de datos
      final username = usernameController.text;
      final firebaseId = user.uid;

      final usuarioGuardado = await usuarioProvider.guardarUsuario(firebaseId, username);
      if (!usuarioGuardado) {
        print("Error al guardar el usuario");
        return;
      }

      // Después guardar el perfil si el usuario fue guardado con éxito
      final edad = int.tryParse(edadController.text) ?? 0;
      final peso = double.tryParse(pesoController.text) ?? 0.0;
      final estatura = double.tryParse(estaturaController.text) ?? 0.0;

      final nuevoPerfil = Perfil(
        idPerfil: 0,
        nombre: nombreController.text,
        apellido: apellidoController.text,
        edad: edad,
        peso: peso,
        estatura: estatura,
        genero: selectedGender ?? 'Hombre',
        tipoNivel: selectedIntensity ?? 'Principiante',
        fotoPerfil: null,
        biografia: '',
        firebaseId: firebaseId,
      );

      await perfilProvider.createPerfil(nuevoPerfil);

      Navigator.pushReplacementNamed(context, 'home');
    } catch (e) {
      print("Error al guardar perfil: $e");
    }
  }
}