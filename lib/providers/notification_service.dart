import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> showRepeatedNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'repeating_channel_id',
    'repeating_channel_name',
    channelDescription: 'Notificaciones repetidas cada minuto',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.periodicallyShow(
    0,
    'Nana Kan',
    'Tu mejor aplicación',
    RepeatInterval.everyMinute, // ⏱ Cada minuto
    platformDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    payload: 'mensaje_nanakantest',
  );
}
