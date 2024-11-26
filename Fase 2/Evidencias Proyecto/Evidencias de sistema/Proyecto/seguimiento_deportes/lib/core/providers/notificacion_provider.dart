import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:seguimiento_deportes/core/constants.dart';
import 'dart:math'; 
const urlapi = url; 

// Método para obtener un mensaje motivacional aleatorio según el tipo de notificación
Future<String> getMensajeMotivacional(String tipoNotificacion) async {
  final uri = Uri.https(urlapi, 'notificacion', {'tipo_notificacion': tipoNotificacion});

  try {
    final response = await http.get(uri, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    // Verificamos si la respuesta fue exitosa
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
    

      // Filtrar los mensajes por tipo
      final List<String> mensajes = data
          .where((item) => item['tipo_notificacion'] == tipoNotificacion)
          .map<String>((item) => item['mensaje_notificacion'].toString())
          .toList();

      // Seleccionar un mensaje aleatorio
      if (mensajes.isNotEmpty) {
        final random = Random();
        final randomIndex = random.nextInt(mensajes.length);
        return mensajes[randomIndex];
      } else {
        return 'No hay mensajes disponibles para el tipo de notificación: $tipoNotificacion';
      }
    } else {
      print('Error al obtener el mensaje: ${response.statusCode}');
      return 'Error al obtener el mensaje';
    }
  } catch (e) {
    print('Error de conexión: $e');
    return 'Error de conexión';
  }
}