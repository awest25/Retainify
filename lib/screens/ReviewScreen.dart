import 'package:flutter/material.dart';
import 'package:retainify/global_styles.dart';
import 'package:retainify/screens/NotesScreen.dart';
import 'package:retainify/screens/ReflectScreen.dart';

class ReviewScreen extends StatefulWidget {
  final List<String> questions;
  const ReviewScreen({super.key, required this.questions});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int currentQuestionIndex = 0;
  List<String> answers = ['', '', '', '', ''];
  var txtField = TextEditingController();
  bool _leftIsShow = false;
  bool _rightIsShow = true;
  bool _finishIsShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Review Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
        child: Column(
          children: [
            Card(
              shape: curvedShape,
              elevation: 2,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        widget.questions[currentQuestionIndex],
                        style: header1,
                      ),
                      const SizedBox(height: 30.0),
                      TextField(
                        maxLines: 5,
                        controller: txtField,
                        onChanged: (value) {
                          setState(() {
                            answers[currentQuestionIndex] = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Type your answer here',
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Visibility(
                              visible: _leftIsShow,
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              child: IconButton(
                                iconSize: 50,
                                icon: const Icon(Icons.keyboard_arrow_left),
                                onPressed: () {
                                  // Save the current answer
                                  // TODO: Implement this functionality

                                  // Move to the next question
                                  setState(() {
                                    currentQuestionIndex--;
                                    txtField.text =
                                        answers[currentQuestionIndex];
                                    txtField.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: txtField.text.length));
                                    if (currentQuestionIndex == 0) {
                                      _leftIsShow = false;
                                    }
                                    if (currentQuestionIndex != 4) {
                                      _rightIsShow = true;
                                    }
                                  });
                                },
                              ),
                            ),
                            Visibility(
                              visible: _rightIsShow,
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              child: IconButton(
                                iconSize: 50,
                                icon: const Icon(Icons.keyboard_arrow_right),
                                onPressed: () {
                                  // Save the current answer
                                  // TODO: Implement this functionality

                                  // Move to the next question
                                  setState(() {
                                    currentQuestionIndex++;
                                    txtField.text =
                                        answers[currentQuestionIndex];
                                    txtField.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: txtField.text.length));
                                    _leftIsShow = true;
                                    if (currentQuestionIndex == 4) {
                                      _rightIsShow = false;
                                      _finishIsShow = true;
                                    } else {
                                      _rightIsShow = true;
                                    }
                                  });
                                },
                              ),
                            )
                          ]),
                    ],
                  )),
            ),
            SizedBox(height: 20),
            Visibility(
                visible: _finishIsShow,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReflectScreen()));
                  },
                  child: const Text('Finish'),
                  style: elevatedButtonStyle,
                ))
          ],
        ),
      ),
    );
  }
}
