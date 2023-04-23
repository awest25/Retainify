import 'package:hive/hive.dart';
import 'package:retainify/hivedb.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxProvider {
  static const String userNoteBoxName = 'userNoteBox';

  Future<void> initialize() async {
    await Hive.openBox<UserNote>(userNoteBoxName);
  }

  Box<UserNote> get userNoteBox => Hive.box<UserNote>(userNoteBoxName);

  void dispose() {
    Hive.close();
  }
}
