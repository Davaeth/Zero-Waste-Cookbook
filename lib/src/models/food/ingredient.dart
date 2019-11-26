import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  final String id;
  final String ingredientName;
  final String photoPath;

  Ingredient({this.id, this.ingredientName, this.photoPath});

  factory Ingredient.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Ingredient(
        id: doc.documentID,
        ingredientName: data['ingredientName'] ?? 'Empty name',
        photoPath: data['photoPath' ?? '']);
  }

  toJson() => {'ingredientName': ingredientName, 'photoPath': photoPath};
}
