import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeMeasures {
  final String id;
  final DocumentReference idRecipes;
  final DocumentReference idMeasures;
  final DocumentReference idIngredients;
  final double quantity;

  RecipeMeasures(
      {this.id,
      this.idRecipes,
      this.idMeasures,
      this.idIngredients,
      this.quantity});

  factory RecipeMeasures.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return RecipeMeasures(
        idRecipes: doc['idRecipes'] ?? '',
        idMeasures: data['idMeasures'] ?? '',
        idIngredients: data['idIngredients'],
        quantity: data['quantity']);
  }

  toJson() => {
        'idRecipes': idRecipes,
        'idMeasures': idMeasures,
        'idIngredients': idIngredients,
        'quantity': quantity
      };
}
