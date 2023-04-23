import 'package:flutter/material.dart';
import 'package:retainify/screens/NotesScreen.dart';
import 'package:retainify/hivedb.dart';
import 'package:retainify/hive_box_provider.dart';
import 'package:retainify/cohere_api.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<List<Question>> stringToQuestionList(String rawInput) async {
  String questionString = await generateQuestions(rawInput);
  // remove trailing newlines
  questionString = questionString.trimRight();
  List<String> questionList = questionString.split('\n');
  // Filter out blank questions
  questionList = questionList.where((question) => question.trim().isNotEmpty).toList();
  List<Question> questionAnswerList = questionList
      .map((question) => Question(
            question: question,
            answer: "thereisnoanswer",
          ))
      .toList();
  return questionAnswerList;
}

class NewNoteScreen extends StatelessWidget {
  const NewNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusNode contentFocusNode = FocusNode();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    HiveBoxProvider hiveBoxProvider = HiveBoxProvider();
    Box<UserNote> userNoteBox = hiveBoxProvider.userNoteBox;

    return Scaffold(
      appBar: AppBar(title: const Text("New Note")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your note title',
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(contentFocusNode);
                },
              ),
            ),
            TextField(
              controller: contentController,
              focusNode: contentFocusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Paste or enter your note content',
              ),
              maxLines: 10,
              onSubmitted: (text) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotesScreen(),
                  ),
                );
              },
            ),
            const SizedBox(
                height:
                    8.0), // Add spacing between the text field and the button
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text;
                String content = contentController.text;

                if (title.isNotEmpty && content.isNotEmpty) {
                  List<Question> questionList =
                      await stringToQuestionList(content);

                  UserNote newUserNote = UserNote(
                    notes: [
                      Note(
                        pageName: title,
                        pageId: DateTime.now().toString(),
                        createdTime: DateTime.now(),
                        questionAnswer: questionList,
                        dateImported: DateTime.now(),
                      ),
                    ],
                    createdNote: DateTime.now(),
                    user: User(databaseId: "testUser"),
                  );

                  userNoteBox.add(newUserNote);

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesScreen(),
                      ),
                      (Route<dynamic> route) => false);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
