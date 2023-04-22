import 'package:flutter/material.dart';
import 'package:retainify/screens/NotesScreen.dart';

class ReviewScreen extends StatefulWidget {
  final List<String> questions;

  const ReviewScreen({super.key, required this.questions});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int currentQuestionIndex = 0;
  String? currentAnswer;
  var txtField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.questions[currentQuestionIndex],
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: txtField,
              onChanged: (value) {
                setState(() {
                  currentAnswer = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Type your answer here',
              ),
            ),
            const SizedBox(height: 16.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              IconButton(
                iconSize: 50,
                icon: const Icon(Icons.arrow_left),
                onPressed: () {
                  // Save the current answer
                  // TODO: Implement this functionality

                  // Move to the next question
                  setState(() {
                    currentQuestionIndex--;
                    currentAnswer = '';
                    txtField.text = '';
                  });
                },
              ),
              IconButton(
                iconSize: 50,
                icon: const Icon(Icons.arrow_right),
                onPressed: () {
                  // Save the current answer
                  // TODO: Implement this functionality

                  // Move to the next question
                  setState(() {
                    currentQuestionIndex++;
                    currentAnswer = '';
                    txtField.text = '';
                  });
                },
              ),
            ])
          ],
        ),
      ),
    );
  }
}
