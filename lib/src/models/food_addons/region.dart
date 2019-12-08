import 'package:cloud_firestore/cloud_firestore.dart';

class Region {
  final String id;
  final String name;

  Region({this.id, this.name});

  factory Region.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Region(id: doc.documentID, name: data['name'] ?? 'Empty name');
  }

  toJson() => {'name': name};
}
