import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hivedb.g.dart';
// part 'UserNote.g.dart';
// part 'User.g.dart';
// part 'Question.g.dart';
// part 'Note.g.dart';

@HiveType(typeId: 0)
class UserNote extends HiveObject {
  @HiveField(0)
  DateTime createdNote;
  // String pageName;
  @HiveField(1)
  List<Note> notes;

  @HiveField(2)
  User user;

  UserNote({
    required this.createdNote,
    required this.notes,
    required this.user,
  });
}

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(3)
  // Notion ID of User
  String databaseId;
  User({
    required this.databaseId,
  });
}

@HiveType(typeId: 2)
class Question extends HiveObject {
  @HiveField(4)
  String question;
  @HiveField(5)
  String answer;

  Question({
    required this.question,
    this.answer = 'thereisnoanswer',
  });
}

@HiveType(typeId: 3)
class Note extends HiveObject {
  @HiveField(6)
  String pageName;
  @HiveField(7)
  String pageId;
  @HiveField(8)
  DateTime dateImported;
  @HiveField(9)
  // This datetime object is generated by notion
  DateTime createdTime;
  // Use conditional to determine when to send push notification based on createdTime
  @HiveField(10)
  List<Question> questionAnswer;

  Note({
    required this.pageName,
    required this.pageId,
    // Set this to a April 22 3:49,
    required this.dateImported,
    required this.createdTime,
    required this.questionAnswer,
  });
}

// JSON Structure:
/*
UserNote = [
  DateTime createdNote; 
  List<Note> notes = [ [
    String pageName; 
    String pageId; 
    String dateImported; 
    DateTime createdTime; 
    List<Question> questionAnswer = [[
      String question; 
      String answer; 
    ], ...]
    ], ...
  ] 
  User user = [
    String databaseId; 
  ]

]
*/

// question_answer, comprised of an importTime and a list of question objects, this list is able to expand
