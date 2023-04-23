import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:retainify/screens/NotesScreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../notifications.dart';

class NewNoteScreen extends StatelessWidget {
  const NewNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusNode contentFocusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(title: const Text("New Note")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your note title',
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(contentFocusNode);
                },
              ),
            ),
            TextField(
              focusNode: contentFocusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Paste or enter your note content',
              ),
              maxLines: 10,
              onSubmitted: (text) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotesScreen(),
                  ),
                );
              },
            ),
            const SizedBox(
                height:
                    8.0), // Add spacing between the text field and the button
            ElevatedButton(
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotesScreen(),
                    ),
                    (Route<dynamic> route) => false);

                DateTime now = DateTime.now();

                Duration oneMinute =
                    const Duration(minutes: 1); // For debugging

                Duration oneDay = const Duration(days: 1);
                Duration sevenDays = const Duration(days: 7);
                Duration sixteenDays = const Duration(days: 16);
                Duration thirtyFiveDays = const Duration(days: 35);

                DateTime scheduledDate0 = now.add(oneMinute);
                DateTime scheduledDate1 = now.add(oneDay);
                DateTime scheduledDate2 = now.add(sevenDays);
                DateTime scheduledDate3 = now.add(sixteenDays);
                DateTime scheduledDate4 = now.add(thirtyFiveDays);

                String title = 'Time to Review!';
                String body1 =
                    'This is your first review session for the topic!';
                String body2 =
                    'This is your second review session for the topic!';
                String body3 =
                    'This is your third review session for the topic!';
                String body4 =
                    'This is your final review session for the topic!';

                // Load the timezone data
                tz.initializeTimeZones();

                // Get the current device's timezone
                String deviceTimeZone;
                try {
                  deviceTimeZone =
                      await FlutterNativeTimezone.getLocalTimezone();
                } catch (e) {
                  deviceTimeZone = 'Etc/UTC';
                }

                WidgetsFlutterBinding.ensureInitialized();
                initNotifications();
                scheduleNotification(scheduledDate0, 0, title, body1); // 1min
                scheduleNotification(scheduledDate1, 1, title, body1); // 1day
                scheduleNotification(scheduledDate2, 2, title, body2); // 7days
                scheduleNotification(scheduledDate3, 3, title, body3); // 16days
                scheduleNotification(scheduledDate4, 4, title, body4); // 35days
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
