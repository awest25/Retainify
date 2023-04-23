import 'package:flutter/material.dart';
import 'package:retainify/notion_api.dart';
import 'package:retainify/screens/NotesScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:retainify/hivedb.dart';
import 'package:retainify/notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:retainify/cohere_api.dart';

// Read HiveDB.
Future<UserNote> retrieveUserNote(userNoteBox, int index) async {
  final userNote = await userNoteBox.getAt(index);
  return userNote!;
}

// Write into HiveDb
// ...List.
void add(NotionPage page, List<String> questions, User user) {
  List<Question> questionAnswerList = questions
      .map((question) => Question(
            question: question,
            answer: "Insert AI generated Answer",
          ))
      .toList();

  final userNote = UserNote(
    createdNote: DateTime.now(),
    notes: [
      for (int i = 0; i < questionAnswerList.length; i++)
        Note(
          pageName: page.name,
          pageId: page.id,
          dateImported: DateTime.now(),
          createdTime: DateTime.now(),
          questionAnswer: questionAnswerList,
        )
    ],
    user: user,
  );
}
