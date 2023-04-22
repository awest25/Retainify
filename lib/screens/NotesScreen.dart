import 'package:flutter/material.dart';
import "package:retainify/screens/ReviewScreen.dart";

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReviewScreen(
                                    question:
                                        'Who was the first President of the United States?',
                                  )));
                    },
                    child: const Text("Review Screen")))));
  }
}
