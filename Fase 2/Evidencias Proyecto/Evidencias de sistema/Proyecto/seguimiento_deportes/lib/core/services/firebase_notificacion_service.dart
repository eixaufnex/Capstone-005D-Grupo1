




















// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class FirebaseNotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initialize() async {
//     // Solicitar permisos para Android
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('Permisos otorgados para notificaciones.');
//     } else {
//       print('Permisos denegados.');
//     }

//     // Configuración inicial para las notificaciones locales
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       // Nueva función para manejar las acciones al tocar notificaciones
//       onDidReceiveNotificationResponse: (NotificationResponse response) async {
//         print('Notificación seleccionada con payload: ${response.payload}');
//         // Manejar navegación o lógica específica aquí
//       },
//     );

//     // Configurar el manejo de notificaciones en primer plano
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _handleForegroundNotification(message);
//     });

//     // Manejar notificaciones cuando se abren desde segundo plano
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Notificación abierta: ${message.notification?.title}');
//       // Aquí puedes manejar la navegación a una pantalla específica
//     });

//     // Manejar notificaciones en segundo plano
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }

//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     print('Mensaje recibido en segundo plano: ${message.notification?.title}');
//   }

//   Future<void> _handleForegroundNotification(RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;

//     if (notification != null && android != null) {
//       _showNotification(
//         title: notification.title ?? 'Sin título',
//         body: notification.body ?? 'Sin mensaje',
//       );
//     }
//   }

//   Future<void> _showNotification(
//       {required String title, required String body}) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'high_importance_channel', // ID del canal
//       'Notificaciones importantes', // Nombre del canal
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await _flutterLocalNotificationsPlugin.show(
//       0, // ID único de la notificación
//       title,
//       body,
//       platformChannelSpecifics,
//     );
//   }

//   Future<void> printDeviceToken() async {
//     String? token = await _firebaseMessaging.getToken();
//     if (token != null) {
//       print('Token del dispositivo: $token');
//     } else {
//       print('No se pudo obtener el token.');
//     }
//   }
// }
