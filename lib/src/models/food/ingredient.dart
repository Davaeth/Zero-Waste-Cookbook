import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  final String id;
  final String name;
  final double quantity;
  final DocumentReference measure;

  Ingredient({this.id, this.name, this.quantity, this.measure});

  factory Ingredient.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Ingredient(
        id: doc.documentID,
        name: data['name'] ?? 'Empty name',
        quantity: data['quantity'] ?? 0,
        measure: data['measure'] ?? null);
  }

  toJson() => {'name': name, 'quantity': quantity, 'measure': measure};
}
