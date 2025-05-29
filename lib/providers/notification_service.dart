import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/language_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> scheduleDailyNotification(LanguageProvider langProvider) async {
  // 1️⃣ Obtener mensajes del idioma seleccionado
  List<Map<String, String>> messages = langProvider.getNotificationMessages();
  if (messages.isEmpty) {
    print('⚠️ No hay mensajes configurados.');
    return;
  }

  // 2️⃣ Obtener índice de la última notificación enviada
  final prefs = await SharedPreferences.getInstance();
  int index = prefs.getInt('notification_index') ?? 0;

  // 3️⃣ Configurar el mensaje
  final msg = messages[index % messages.length];
  final title = msg['title'] ?? langProvider.translate('app_name');
  final body = msg['body'] ?? langProvider.translate('notification_body');

  // 4️⃣ Configurar hora: 12:00 PM
  final now = tz.TZDateTime.now(tz.local);
  final scheduleTime =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 12, 0);
  final nextTime = scheduleTime.isBefore(now)
      ? scheduleTime.add(Duration(days: 1))
      : scheduleTime;

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    nextTime,
    NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Notificación diaria a las 12:00 PM',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  // 6️⃣ Guardar índice para la próxima notificación
  prefs.setInt('notification_index', (index + 1) % messages.length);
  print('🔔 Notificación programada: $title - $body');
}

Future<void> scheduleNotificationEveryMinute(
    LanguageProvider langProvider) async {
  final prefs = await SharedPreferences.getInstance();
  int notificationIndex = prefs.getInt('notification_index') ?? 0;

  List<Map<String, String>> messages = langProvider.getNotificationMessages();
  if (messages.isEmpty) {
    print('⚠️ No hay mensajes configurados en el idioma seleccionado.');
    return;
  }

  Map<String, String> currentMessage =
      messages[notificationIndex % messages.length];
  String title = currentMessage['title'] ?? langProvider.translate('app_name');
  String body =
      currentMessage['body'] ?? langProvider.translate('notification_body');

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    tz.TZDateTime.now(tz.local).add(Duration(minutes: 1)), // 🔥 Cada minuto
    NotificationDetails(
      android: AndroidNotificationDetails(
        'repeating_channel_id',
        'repeating_channel_name',
        channelDescription: 'Notificaciones cada minuto',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  );

  // 🔄 Guarda el siguiente mensaje
  notificationIndex = (notificationIndex + 1) % messages.length;
  await prefs.setInt('notification_index', notificationIndex);

  print('🔔 Notificación $notificationIndex programada: $title - $body');
}
