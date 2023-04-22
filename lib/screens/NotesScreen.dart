import 'package:flutter/material.dart';
import "package:retainify/screens/ReviewScreen.dart";

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReviewScreen()));
            },
            child: const Text("Review Screen")));
  }
}
