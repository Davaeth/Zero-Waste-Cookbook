import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  final String id;
  final String ingredientName;
  final double quantity;
  final DocumentReference measure;

  Ingredient({this.id, this.ingredientName, this.quantity, this.measure});

  factory Ingredient.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Ingredient(
        id: doc.documentID,
        ingredientName: data['ingredientName'] ?? 'Empty name',
        quantity: data['quantity'] ?? 0,
        measure: data['measure'] ?? null);
  }

  toJson() => {
        'ingredientName': ingredientName,
        'quantity': quantity,
        'measure': measure
      };
}
