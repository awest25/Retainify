import 'package:flutter/material.dart';
import "package:retainify/global_styles.dart";

class NewNoteNotion extends StatefulWidget {
  const NewNoteNotion({super.key});

  @override
  _NewNoteNotion createState() => _NewNoteNotion();
}

class _NewNoteNotion extends State<NewNoteNotion> {
  String? _selectedValue = null;
  // TODO: query the notion database for a list of page titles which aren't already in our app database

  @override
  Widget build(BuildContext context) {
    final header1 = TextStyle(fontSize: 25);
    return Scaffold(
        appBar: AppBar(
          title: Text("New Note from Notion"),
        ),
        body: Center(
            child: Column(
          children: [
            SizedBox(height: 20),
            // TODO: populate titles from the results of the query
            DropdownMenu(
                width: MediaQuery.of(context).size.width * 0.85,
                label: Text("Select a Page"),
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: "zero", label: "zero"),
                  DropdownMenuEntry(value: "one", label: "one")
                ],
                onSelected: ((value) {
                  _selectedValue = value;
                })),
            SizedBox(height: 10),
            // TODO: PUSH to database based on selected dropdown entry
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Import"))
          ],
        )));
  }
}
