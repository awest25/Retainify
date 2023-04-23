import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:retainify/cohere_api.dart';
import "package:retainify/global_styles.dart";
import 'package:retainify/hivedb.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../notifications.dart';
import '../notion_api.dart';
import 'package:retainify/dbfunc.dart';
import 'package:retainify/hive_box_provider.dart';
import 'package:hive/hive.dart';

class NewNoteNotion extends StatefulWidget {
  final VoidCallback onImportCompleted;
  NewNoteNotion({required this.onImportCompleted, super.key});

  @override
  _NewNoteNotion createState() => _NewNoteNotion();
}

class _NewNoteNotion extends State<NewNoteNotion> {
  String? _selectedValue = null;
  String? _selectedName = null;
  // TODO: query the notion database for a list of page titles which aren't already in our app database

  String databaseId = 'fe6780fd2f71484c97f87999290cc9d0';
  List<NotionPage> pages = <NotionPage>[];
  List<String> pageTitles = <String>[];
  List<DropdownMenuItem> dropdownMenuItems = <DropdownMenuItem>[];

  Future<List<NotionPage>> getPages() async {
    pages = await fetchPagesFromNotion(databaseId);
    List<String> pageTitles = [];
    for (var page in pages) {
      pageTitles.add(page.name);
    }

    dropdownMenuItems = pageTitles.map((String value) {
      return DropdownMenuItem(
        value: value,
        child: Text(value, overflow: TextOverflow.ellipsis),
      );
    }).toList();

    print(dropdownMenuItems);

    return pages;
  }

  @override
  void initState() {
    super.initState();
    getPages();
  }

  @override
  Widget build(BuildContext context) {
    HiveBoxProvider hiveBoxProvider = HiveBoxProvider();
    Box<UserNote> userNoteBox = hiveBoxProvider.userNoteBox;

    final header1 = const TextStyle(fontSize: 25);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text("New Note from Notion", style: title),
                padding: const EdgeInsets.only(left: 15),
              ),
              const SizedBox(height: 20),
              Card(
                shape: curvedShape,
                elevation: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      FutureBuilder<List<NotionPage>>(
                        future: getPages(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child:
                                  Text('Error: ${snapshot.error.toString()}'),
                            );
                          }

                          dropdownMenuItems = snapshot.data!
                              .map((page) => DropdownMenuItem(
                                    value: page.id,
                                    child: Text(page.name),
                                  ))
                              .toList();

                          return DropdownButton(
                            value: _selectedValue,
                            items: dropdownMenuItems,
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value as String?;
                                _selectedName = snapshot.data!
                                    .firstWhere((element) =>
                                        element.id == _selectedValue)
                                    .name;
                              });
                            },
                            hint: const Text("Select a Page"),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      // TODO: PUSH to database based on selected dropdown entry
                      ElevatedButton(
                        onPressed: () async {
                          String selectedID = _selectedValue!;
                          String selectedName = _selectedName!;

                          print("About add new note");
                          String rawText = await fetchTextFromPage(selectedID);
                          String questionString =
                              await generateQuestions(rawText);
                          List<Question> questionList =
                              await stringToQuestionList(questionString);
                          // Store string to database
                          saveQuestionListToDB(
                              selectedName, questionList, userNoteBox);
                          // Call callback function
                          widget.onImportCompleted();
                          Navigator.pop(context);
                        },
                        child: const Text("Import"),
                        style: elevatedButtonStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
