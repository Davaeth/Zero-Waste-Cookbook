import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeAllergens {
  final String id;
  final DocumentReference idAllergens;
  final DocumentReference idRecipes;

  RecipeAllergens({this.id, this.idRecipes, this.idAllergens});

  factory RecipeAllergens.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return RecipeAllergens(
        idRecipes: doc['idRecipes'] ?? '',
        idAllergens: data['idAllergens'] ?? '');
  }

  toJson() => {'idRecipes': idRecipes, 'idAllergens': idAllergens};
}
