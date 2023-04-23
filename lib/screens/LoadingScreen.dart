import 'package:flutter/material.dart';
import "package:retainify/global_styles.dart";

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text("Retainify"),
      ),
      body: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView(children: const [
                SizedBox(height: 20),
                Text(
                  "Loading...",
                  style: TextStyle(
                      fontSize: 35, color: Color.fromARGB(255, 133, 133, 133)),
                ),
              ]))),
    );
  }
}
