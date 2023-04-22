import 'package:flutter/material.dart';
import 'package:retainify/screens/NotesScreen.dart';

class ReviewScreen extends StatefulWidget {
  final String question;

  const ReviewScreen({super.key, required this.question});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.question,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Type your answer here',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save the user's answer and go to the next question
                String answer = _textEditingController.text;
                // TODO: Implement logic for saving answer and going to next question
              },
              child: const Text('Submit Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
