// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hivedb.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserNoteAdapter extends TypeAdapter<UserNote> {
  @override
  final int typeId = 0;

  @override
  UserNote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserNote(
      createdNote: fields[0] as DateTime,
      notes: (fields[1] as List).cast<Note>(),
      user: fields[2] as User,
    );
  }

  @override
  void write(BinaryWriter writer, UserNote obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.createdNote)
      ..writeByte(1)
      ..write(obj.notes)
      ..writeByte(2)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      databaseId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(1)
      ..writeByte(3)
      ..write(obj.databaseId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final int typeId = 2;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      question: fields[4] as String,
      answer: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(2)
      ..writeByte(4)
      ..write(obj.question)
      ..writeByte(5)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 3;

  @override
  Note read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Note(
      pageName: fields[6] as String,
      pageId: fields[7] as String,
      dateImported: fields[8] as DateTime,
      createdTime: fields[9] as DateTime,
      questionAnswer: (fields[10] as List).cast<Question>(),
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer
      ..writeByte(5)
      ..writeByte(6)
      ..write(obj.pageName)
      ..writeByte(7)
      ..write(obj.pageId)
      ..writeByte(8)
      ..write(obj.dateImported)
      ..writeByte(9)
      ..write(obj.createdTime)
      ..writeByte(10)
      ..write(obj.questionAnswer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
