import 'package:flutter/material.dart';
import 'package:retainify/components/CustomIcons.dart';
import 'package:retainify/hivedb.dart';
import "package:retainify/screens/ReviewScreen.dart";
import 'package:intl/intl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import "package:retainify/screens/NewNoteNotion.dart";
import "package:retainify/global_styles.dart";
import 'package:retainify/screens/NewNoteScreen.dart';
import 'package:hive/hive.dart';
import 'package:retainify/hive_box_provider.dart';
import 'package:retainify/screens/NewNoteScreen.dart';

List<Widget> generateTileList(BuildContext context) {
  List<Widget> tileList = [];
  HiveBoxProvider hiveBoxProvider = HiveBoxProvider();

  // Access the UserNote box using hiveBoxProvider instance
  Box<UserNote> userNoteBox = hiveBoxProvider.userNoteBox;

  // Loop through all UserNotes in the box
  for (UserNote userNote in userNoteBox.values) {
    // Loop through all Notes in the current UserNote
    for (Note note in userNote.notes) {
      // Create a _tile for each Note and add it to the tileList
      tileList
          .add(_tile(context, note.pageName, note.dateImported, note.pageId));
    }
  }
  return tileList;
}

List<String> generateQuestionList(String id) {
  List<String> outputQuestionList = [];
  HiveBoxProvider hiveBoxProvider = HiveBoxProvider();

  // Access the UserNote box using hiveBoxProvider instance
  Box<UserNote> userNoteBox = hiveBoxProvider.userNoteBox;

  for (UserNote userNote in userNoteBox.values) {
    for (Note note in userNote.notes) {
      if (note.pageId == id) {
        outputQuestionList
            .addAll(note.questionAnswer.map((qa) => qa.question).toList());
      }
    }
  }
  return outputQuestionList;
}

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> tileList = generateTileList(context);

    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(
          title: const Text("Retainify"),
        ),
        // TODO: populate the body with info from the database (Note title, DateTime it was imported)
        body: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView(children: [
                  SizedBox(height: 20),
                  Container(
                    child: Text("Notes", style: title),
                    padding: EdgeInsets.only(left: 15),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: tileList,
                  )
                ]))),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          foregroundColor: theme.colorScheme.onPrimary,
          backgroundColor: theme.colorScheme.primary,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.edit),
                foregroundColor: theme.colorScheme.primary,
                label: "New Note",
                labelStyle: body,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewNoteScreen()));
                }),
            SpeedDialChild(
                child: const Icon(CustomIcons.notion_logo),
                foregroundColor: theme.colorScheme.primary,
                label: "New Note from Notion",
                labelStyle: body,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewNoteNotion()));
                })
          ],
        ));
  }
}

Widget _tile(
    BuildContext context, String title, DateTime importDate, String id) {
  // date and time calculations
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('MMMM d, yyyy');
  final String nextDate;
  Duration durationSinceImport = now.difference(importDate);
  double percent = 0;

  if (durationSinceImport.inDays > 35) {
    percent = 1;
    nextDate = "Done";
  } else if (durationSinceImport.inDays > 16) {
    percent = (durationSinceImport.inDays - 16) / 35;
    nextDate = formatter.format(
        now.add(Duration(days: 35 - (durationSinceImport.inDays - 16))));
  } else if (durationSinceImport.inDays > 7) {
    percent = (durationSinceImport.inDays - 7) / 16;
    nextDate = formatter
        .format(now.add(Duration(days: 16 - (durationSinceImport.inDays - 7))));
  } else if (durationSinceImport.inDays > 1) {
    percent = (durationSinceImport.inDays - 1);
    nextDate = formatter
        .format(now.add(Duration(days: 7 - (durationSinceImport.inDays - 1))));
  } else {
    percent = 0.5;
    nextDate = formatter.format(now.add(const Duration(days: 1)));
  }

  return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Card(
        shape: curvedShape,
        elevation: 2,
        child: ExpansionTile(
            title: Text(title, style: header2),
            trailing: CircularProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey[300],
            ),
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Next Review', style: body),
                          Text(nextDate, style: body),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Center(
                              child: ElevatedButton(
                                  // TODO: fix button onPressed method to send context in order to populate the correct questions
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ReviewScreen(
                                                  questions:
                                                      generateQuestionList(id),
                                                )));
                                  },
                                  style: elevatedButtonStyle,
                                  child: const Text("Review"))))
                    ],
                  ))
            ]),
      ));
}
