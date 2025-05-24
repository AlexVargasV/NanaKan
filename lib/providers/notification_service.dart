import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../providers/language_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> showRepeatedNotification(LanguageProvider langProvider) async {
  List<Map<String, String>> messages = langProvider.getNotificationMessages();

  if (messages.isEmpty) {
    print('⚠️ No hay mensajes configurados en el idioma seleccionado.');
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  int notificationIndex = prefs.getInt('notification_index') ?? 0;

  Map<String, String> currentMessage =
      messages[notificationIndex % messages.length];
  String title = currentMessage['title'] ?? langProvider.translate('app_name');
  String body =
      currentMessage['body'] ?? langProvider.translate('notification_body');

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        'repeating_channel_id',
        'repeating_channel_name',
        channelDescription: 'Notificaciones rotativas cada minuto',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    payload: 'nanakan_payload',
  );

  notificationIndex = (notificationIndex + 1) % messages.length;
  await prefs.setInt('notification_index', notificationIndex);

  print('🔔 Notificación $notificationIndex mostrada: $title - $body');
}
