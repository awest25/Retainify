import 'package:flutter/material.dart';
import "package:retainify/components/NotesListItem.dart";
import "package:retainify/screens/ReviewScreen.dart";
import "package:retainify/components/NotesListItem.dart";
import 'package:intl/intl.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Notes")),
        body: Container(
            child: ListView(children: [
          _tile("Physics - Velocity and Displacement", 1),
          _tile("Math - Pythagorean Theorem", 4)
        ])));
  }
}

Widget _tile(String title, int daysSinceImport) {
  final header1 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  final header2 = TextStyle(fontSize: 18);
  double percent = 0;
  String nextDate = "";

// TODO do this logic for next deadline and percent until that date
  if (daysSinceImport > 35) {}

  return Card(
    child: ExpansionTile(
        title: Text(title, style: header1),
        trailing: CircularProgressIndicator(value: percent),
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Next Retainify', style: header2),
                  Text(nextDate, style: header2),
                ],
              ))
        ]),
  );
}

// child: Center(
//     child: TextButton(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const ReviewScreen()));
//         },
//         child: const Text("Go to Review Screen")))
