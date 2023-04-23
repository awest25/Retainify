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
        appBar: AppBar(),
        body: Center(
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text("Select Note from Notion", style: header2)),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                // TODO: populate titles from the results of the query
                child: DropdownMenu(
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "zero", label: "zero"),
                      DropdownMenuEntry(value: "one", label: "one")
                    ],
                    onSelected: ((value) {
                      _selectedValue = value;
                    })),
              ),
              // TODO: PUSH to database based on selected dropdown entry
              FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Import"))
            ]))));
  }
}
