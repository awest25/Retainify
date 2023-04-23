import 'package:flutter/material.dart';
import 'package:retainify/screens/NotesScreen.dart';
import 'package:retainify/screens/WelcomeScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:retainify/hivedb.dart';
import 'package:retainify/notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:retainify/dbfunc.dart';
import 'package:retainify/hive_box_provider.dart';

final HiveBoxProvider hiveBoxProvider = HiveBoxProvider();

// UserNote? userNote;

Future<void> initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter<UserNote>(UserNoteAdapter());
  Hive.registerAdapter<User>(UserAdapter());
  Hive.registerAdapter<Question>(QuestionAdapter());
  Hive.registerAdapter<Note>(NoteAdapter());
  // var userNote = await Hive.openBox<UserNote>("UserNoteBox");
}

void main() async {
  print("Running main");
  // Load the timezone data
  tz.initializeTimeZones();

  print("Initializing Hive");
  await initializeHive();
  await hiveBoxProvider.initialize();
  print("Finished initializing Hive");
  WidgetsFlutterBinding.ensureInitialized();
  initNotifications();
  runApp(const Retainify());
}

class Retainify extends StatelessWidget {
  const Retainify({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("Running Retainify");
    return MaterialApp(
      // home: NotesScreen(),
      home: const WelcomeScreen(),
      theme: ThemeData(
        fontFamily: "OpenSans",
        // textTheme: const TextTheme(
        //   bodyMedium: TextStyle(
        //     fontFamily: 'Open Sans',
        //     fontSize: 16,
        //     color: Colors.black,
        //   ),
        // ),
        primarySwatch: Colors.blue,
      ),
    );
  }
}
