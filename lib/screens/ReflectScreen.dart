import 'package:flutter/material.dart';
import 'package:retainify/global_styles.dart';
import 'package:retainify/screens/NotesScreen.dart';

class ReflectScreen extends StatefulWidget {
  const ReflectScreen({Key? key}) : super(key: key);

  @override
  _ReflectScreenState createState() => _ReflectScreenState();
}

class _ReflectScreenState extends State<ReflectScreen> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(),
        body: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(children: [
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Reflect", style: title),
                    padding: EdgeInsets.only(left: 15),
                  ),
                  SizedBox(height: 20),
                  Card(
                    shape: curvedShape,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          const Text(
                            'How well did you remember the content?',
                            textAlign: TextAlign.center,
                            style: header1,
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(
                                    Icons.sentiment_very_dissatisfied),
                                iconSize: 50,
                                color: _selectedValue == 1
                                    ? Colors.redAccent
                                    : Colors.grey[400],
                                onPressed: () {
                                  setState(() {
                                    _selectedValue = 1;
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.sentiment_dissatisfied),
                                iconSize: 50,
                                color: _selectedValue == 2
                                    ? Colors.orangeAccent
                                    : Colors.grey[400],
                                onPressed: () {
                                  setState(() {
                                    _selectedValue = 2;
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.sentiment_satisfied),
                                iconSize: 50,
                                color: _selectedValue == 3
                                    ? Colors.greenAccent
                                    : Colors.grey[400],
                                onPressed: () {
                                  setState(() {
                                    _selectedValue = 3;
                                  });
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.sentiment_very_satisfied),
                                iconSize: 50,
                                color: _selectedValue == 4
                                    ? Colors.blueAccent
                                    : Colors.grey[400],
                                onPressed: () {
                                  setState(() {
                                    _selectedValue = 4;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.popUntil(context, ((route) {
                                if (route.isFirst) {
                                  return true;
                                } else {
                                  return route.settings.name == '/notes';
                                }
                              }));
                            },
                            child: const Text('Submit'),
                            style: elevatedButtonStyle,
                          ),
                        ],
                      ),
                    ),
                  )
                ]))));
  }
}
