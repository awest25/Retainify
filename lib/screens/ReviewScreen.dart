import 'package:flutter/material.dart';
import 'package:retainify/screens/NotesScreen.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => const NotesScreen()));
            },
            child: const Text("Notes Screen")));
  }
}
