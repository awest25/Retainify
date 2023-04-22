import 'package:hive/hive.dart';

@HiveType()
class User extends HiveObject {
    @HiveField(0)
    // Notion ID of User 
    String databaseId; 
}
class Question extends HiveObject {
    @HiveField(1)
    String question;
    @HiveField(2)
    String answer; 
}

class Note extends HiveObject {
    @HiveField(3)
    String importTime;
    @HiveField(4) 
    List<Question> question_answer;
} 

class UserNote extends HiveObject {
    @HiveField(5)
    User();
    @HiveField(6)
    Note();
}
// question_answer, comprised of an importTime and a list of question objects, this list is able to expand 