import 'package:cloud_firestore/cloud_firestore.dart';

class Allergen {
  final String id;
  final String allergenName;

  Allergen({this.id, this.allergenName});

  factory Allergen.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Allergen(
        id: doc.documentID, allergenName: data['allergenName'] ?? 'Empty name');
  }

  toJson() => {'allergenName': allergenName};
}
