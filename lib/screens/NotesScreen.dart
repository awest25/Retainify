import 'package:flutter/material.dart';
import 'package:retainify/components/CustomIcons.dart';
import "package:retainify/screens/ReviewScreen.dart";
import 'package:intl/intl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import "package:retainify/screens/NewNoteNotion.dart";
import "package:retainify/global_styles.dart";
import 'package:retainify/screens/NewNoteScreen.dart';
// import file that defines retrieveFromDB()

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  // List<_tile> retrieveTileList(int index) {
  //  List<_tile> tileList; 
  //   UserNote tile = retrieveUserNote(0);
  //   for (int i = 0; i < tile.notes.length(); i++)
  //   {
  //     tileList.add(context, tile.notes.pageName, tile.notes.pageId);
  //   }
  //   return tileList;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      var tileList = retrieveTileList();
        appBar: AppBar(title: const Text("Notes")),
        // TODO: populate the body with info from the database (Note title, DateTime it was imported)
        body: Container(
            child: ListView(children: [ // children: retrieveTileList()
          // _tile(context, "Physics - Velocity and Displacement",
          //     DateTime(2023, 04, 01)),
          // _tile(context, "Math - Pythagorean Theorem", DateTime(2023, 03, 20)),
          // _tile(context, "US History - The Jackson Era", DateTime(2023, 03, 16))
          tileList;
        ])),// For each page in the database, add to a list of tiles and display them here dynamically
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.edit),
                label: "New Note",
                labelStyle: body,
                // TODO: make this redirect to the NewNoteScreen
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewNoteScreen()));
                }),
            SpeedDialChild(
                child: const Icon(CustomIcons.notion_logo),
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

Widget _tile(BuildContext context, String title, DateTime importDate) {
  // date and time calculations
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('MMMM d, yyyy');
  final String nextDate;
  String nextDateStr;
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

  return Card(
    child: ExpansionTile(
        title: Text(title, style: header1),
        trailing: CircularProgressIndicator(value: percent),
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Next Retainify', style: header2),
                      Text(nextDate, style: header2),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Center(
                          child: FilledButton(
                              // TODO: fix button onPressed method to send context in order to populate the correct questions
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ReviewScreen(
                                              questions: [
                                                'Who was the first President of the United States?',
                                                'Who was the second President of the United States?',
                                                'Who was the third President of the United States?',
                                                'Who was the fourth President of the United States?',
                                                'Who was the fifth President of the United States?',
                                              ],
                                            )));
                              },
                              child: const Text("Review"))))
                ],
              ))
        ]),
  );
}
