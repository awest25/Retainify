import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> scheduleNotification(
    DateTime scheduledDate, int id, String title, String body) async {
  // Ensure scheduledDate is in the future
  if (scheduledDate.isBefore(DateTime.now())) {
    throw ArgumentError('The scheduledDate must be in the future.');
  }

  // Create the notification details for Android
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'Retainify_reminder',
    'Retainify',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: true,
  );

  // Create the platform-specific notification details
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  // Schedule the notification
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    // Make sure the scheduledDate is in the device's local timezone
    tz.TZDateTime.from(scheduledDate, tz.local),
    notificationDetails,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

int generateUniqueId() {
  return DateTime.now().millisecondsSinceEpoch;
}
