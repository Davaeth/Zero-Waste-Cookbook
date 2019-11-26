import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeTags {
  final String id;
  final DocumentReference idDishTags;
  final DocumentReference idRecipes;

  RecipeTags({this.id, this.idRecipes, this.idDishTags});

  factory RecipeTags.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return RecipeTags(
        idDishTags: data['idDishTags'] ?? '',
        idRecipes: doc['idRecipes'] ?? '');
  }

  toJson() => {'idDishTags': idDishTags, 'idRecipes': idRecipes};
}
