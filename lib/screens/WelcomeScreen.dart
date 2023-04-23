import 'package:flutter/material.dart';
import "package:retainify/global_styles.dart";
import 'package:retainify/components/CustomIcons.dart';
import 'package:retainify/screens/NotesScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController _integrationTokenController = TextEditingController();
  TextEditingController _databaseURLController = TextEditingController();
  String integrationToken = "";
  String databaseURL = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Icon(Icons.cloud_circle, color: Colors.red, size: 100),
          Text(
            "Retainify",
            style: title,
          ),
          Text(
            "Retain more, stress less.",
            style: header2,
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Card(
              elevation: 2,
              child: ExpansionTile(
                trailing: const Icon(
                  CustomIcons.notion_logo,
                  color: Colors.black,
                ),
                title: Text(
                  "Get Started with Notion",
                  style: header3,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Column(children: [
                      Text(
                        "1. Login to Notion and create a new integration 'Retainify'.\n\n2. Paste the Integration Token below:\n",
                        style: body,
                        textAlign: TextAlign.left,
                      ),
                      TextField(
                        controller: _integrationTokenController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Integration Token',
                        ),
                        onChanged: (text) {
                          integrationToken = text;
                        },
                      ),
                      Text(
                        "\n3. Navigate to the Notion Database with your notes.\n\n4. Paste the Database URL below:\n",
                        style: body,
                        textAlign: TextAlign.left,
                      ),
                      TextField(
                        controller: _databaseURLController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Database URL',
                        ),
                        onChanged: (text) {
                          databaseURL = text;
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: FilledButton(
                              // TODO: save integration token and database url to hive db
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NotesScreen()));
                              },
                              child: Text("Done")))
                    ]),
                  )
                ],
              ),
            ),
          )
        ]))));
  }
}
