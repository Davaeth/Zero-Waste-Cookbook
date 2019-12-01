import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeCourses {
  final String id;
  final DocumentReference idDishCourses;
  final DocumentReference idRecipes;

  RecipeCourses({this.id, this.idRecipes, this.idDishCourses});

  factory RecipeCourses.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return RecipeCourses(
        idDishCourses: data['idDishCourses'] ?? '',
        idRecipes: doc['idRecipes'] ?? '');
  }

  toJson() => {'idDishCourses': idDishCourses, 'idRecipes': idRecipes};
}
