import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:retainify/global_styles.dart';
import 'package:retainify/screens/NotesScreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../notifications.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({super.key});

  @override
  _NewNoteScreen createState() => _NewNoteScreen();
}

class _NewNoteScreen extends State<NewNoteScreen> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  String notesTitle = '';
  String notes = '';

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode contentFocusNode = FocusNode();

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(title: const Text("New Note")),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: _titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Note Title'),
                ),
                onChanged: (text) {
                  notesTitle = text;
                },
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(contentFocusNode);
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                focusNode: contentFocusNode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your note content',
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
            ),
            const SizedBox(
                height:
                    8.0), // Add spacing between the text field and the button
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);

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
                    'This is your first review session for the topic "$notesTitle"!';
                String body2 =
                    'This is your second review session for the topic "$notesTitle"!';
                String body3 =
                    'This is your third review session for the topic "$notesTitle"!';
                String body4 =
                    'This is your final review session for the topic "$notesTitle"!';

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
              style: elevatedButtonStyle,
            ),
          ],
        ),
      ),
    );
  }
}
