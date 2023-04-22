import 'package:flutter/material.dart';
import 'package:retainify/screens/NotesScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:retainify/hivedb.dart';

UserNote? userNote;

void initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter<UserNote>(UserNoteAdapter());
  Hive.registerAdapter<User>(UserAdapter());
  Hive.registerAdapter<Question>(QuestionAdapter());
  Hive.registerAdapter<Note>(NoteAdapter());
  var userNote = await Hive.openBox<UserNote>("UserNoteBox");
}

void main() {
  // Initializing Hive 
  initializeHive();
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
