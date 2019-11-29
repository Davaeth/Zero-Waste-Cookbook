import 'package:cloud_firestore/cloud_firestore.dart';

class DishTag {
  final String id;
  final String tagName;

  DishTag({this.id, this.tagName});

  factory DishTag.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return DishTag(
        id: doc.documentID, tagName: data['tag_name'] ?? 'Empty name');
  }

  toJson() => {'tagName': tagName};
}
