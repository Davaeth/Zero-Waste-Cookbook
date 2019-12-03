import 'package:cloud_firestore/cloud_firestore.dart';

class Tag {
  final String id;
  final String tagName;
  final DocumentReference recipe;

  Tag({this.id, this.tagName, this.recipe});

  factory Tag.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Tag(tagName: data['tagName'] ?? '', recipe: doc['recipe'] ?? null);
  }

  toJson() => {'tagName': tagName, 'recipe': recipe};
}
