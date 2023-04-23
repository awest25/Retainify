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
  Future<UserNote> retrieveUserNote(UserNoteBox, int index) {
    final userNote = userNoteListBox.getAt(index)!; 
    return userNote;
  }
  // Write into HiveDb
  // ...List.
  void add(NotionPage page, List<String> questions) {
    final userNote = UserNote(
      createdNote: scheduledDate, 
      notes: [
        for(int i=0; i<cohere.length; i++)
        {
          Note(
            pageName: page.name,
            pageId: page.id, 
            dateImported: DateTime.now(), 
            questionAnswer: [
              for (int i=0; i<cohere.length; i++){
              Question(
                question: "Insert AI Generated Question",
                answer: "Insert AI generated Answer", 
              );
            },
            ]
            );
        }
      ], 
      user: 
      );
    userNoteList.add(UserNote);
  }

  Future<List<String>> addNotionPageToDB(NotionPage page) async {
    // get the list of questions
    String notes = await fetchTextFromPage(page.id);
    String questions = await generateQuestions(notes); 
    return questions.split('\n');
  }

  Future<List<String>> addNotesToDB(String text) async
  {
    // List<Question> questions;
    String questionString = await generateQuestions(text); 
    return questionString.split('\n');
  }