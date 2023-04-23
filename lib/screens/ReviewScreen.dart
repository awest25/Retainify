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
  var txtField = TextEditingController();
  bool _leftIsShow = false;
  bool _rightIsShow = true;
  bool _finishIsShow = false;

  @override
  Widget build(BuildContext context) {
    // TODO the next 2 declarations are not states and should be moved
    int questionCount = widget.questions.length;
    List<String> answers =
        List<String>.generate(widget.questions.length, (index) => '');

    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Review", style: title),
                      Text(
                        "$currentQuestionIndex / $questionCount",
                        style: const TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 133, 133, 133)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Page Title", style: header1),
                  padding: EdgeInsets.only(left: 15),
                ),
                SizedBox(height: 20),
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
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset:
                                                        txtField.text.length));
                                        if (currentQuestionIndex == 0) {
                                          _leftIsShow = false;
                                        }
                                        if (currentQuestionIndex !=
                                            questionCount - 1) {
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
                                    icon:
                                        const Icon(Icons.keyboard_arrow_right),
                                    onPressed: () {
                                      // Save the current answer
                                      // TODO: Implement this functionality

                                      // Move to the next question
                                      setState(() {
                                        currentQuestionIndex++;
                                        txtField.text =
                                            answers[currentQuestionIndex];
                                        txtField.selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset:
                                                        txtField.text.length));
                                        _leftIsShow = true;
                                        if (currentQuestionIndex ==
                                            questionCount - 1) {
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
        ]));
  }
}
