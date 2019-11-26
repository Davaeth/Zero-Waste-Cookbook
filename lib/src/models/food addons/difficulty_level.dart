import 'package:cloud_firestore/cloud_firestore.dart';

class DifficultyLevel {
  final String id;
  final String difficultyLevelName;

  DifficultyLevel({this.id, this.difficultyLevelName});

  factory DifficultyLevel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return DifficultyLevel(
        id: doc.documentID,
        difficultyLevelName: data['difficulty_level_name'] ?? 'Empty name');
  }

  toJson() => {'difficultyLevelName': difficultyLevelName};
}
