import 'package:flutter/material.dart';
import 'package:retainify/screens/NotesScreen.dart';
import 'package:retainify/notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

void main() async {
  // DELETE THE FOLLOWING 5 LINES
  DateTime scheduledDate =
      DateTime(2023, 4, 22, 14, 21); // April 25, 2023 at 12:30 PM
  int notificationId = 1;
  String title = 'Scheduled Notification';
  String body = 'This is a scheduled notification for a specific day.';

  WidgetsFlutterBinding.ensureInitialized();

  // Load the timezone data
  tz.initializeTimeZones();

  // Get the current device's timezone
  String deviceTimeZone;
  try {
    deviceTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  } catch (e) {
    deviceTimeZone = 'Etc/UTC';
  }

  // Set the local location to the current device's timezone
  // tz.setLocalLocation(tz.getLocation(deviceTimeZone));

  // DELETE THE FOLLOWING 2 LINES
  print("Scheduling Notification for $scheduledDate");
  scheduleNotification(scheduledDate, notificationId, title, body);

  WidgetsFlutterBinding.ensureInitialized();
  initNotifications();
  runApp(const Retainify());
}

class Retainify extends StatelessWidget {
  const Retainify({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotesScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
