import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
//con htpps
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('icono_notificacion');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
Future<void> showNotificacion1() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    1,
    'Aprobado de notificación de prueba',
    'Esta es una notificación de prueba para mostrar en el canal. Los quiero mucho.',
    notificationDetails,
  );
}

Future<void> showNotificacionConImagen() async {
  const String imageUrl =
      'https://img.autoabc.lv/Nissan-Tiida/Nissan-Tiida_2007_Sedans_17111110541_1_m.jpg';

  // Descargar la imagen y guardarla en el almacenamiento local
  final http.Response response = await http.get(Uri.parse(imageUrl));
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/imagen_notificacion.jpg';
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);

  final BigPictureStyleInformation bigPictureStyleInformation =
      BigPictureStyleInformation(
    FilePathAndroidBitmap(filePath),
    contentTitle: 'Notificación con Imagen',
    summaryText: 'Esta notificación incluye una imagen de internet',
  );

  final AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: bigPictureStyleInformation,
  );

  final NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    2,
    'Notificación con Imagen',
    'Esta es una notificación que incluye una imagen desde internet.',
    notificationDetails,
  );
}
