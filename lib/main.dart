import 'package:flutter/material.dart';
import 'package:retainify/screens/NotesScreen.dart';

void main() {
  runApp(const Retainify());
}

class Retainify extends StatelessWidget {
  const Retainify({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotesScreen(),
    );
  }
}
