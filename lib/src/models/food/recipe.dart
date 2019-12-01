import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String id;
  final String recipeTitle;
  final int prepTime;
  final String photoPath;
  final int rank;
  final DateTime creationTime;
  final bool deleted;
  final DocumentReference user;
  final DocumentReference difficultyLevel;
  final DocumentReference dishRegions;
  final List<DocumentReference> reviews;

  Recipe(
      {this.id,
      this.recipeTitle,
      this.prepTime,
      this.photoPath,
      this.rank,
      this.creationTime,
      this.deleted,
      this.user,
      this.difficultyLevel,
      this.dishRegions,
      this.reviews});

  factory Recipe.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Recipe(
        id: doc.documentID,
        recipeTitle: data['recipeTitle'],
        prepTime: data['prepTime'],
        photoPath: data['photoPath'],
        rank: data['rank'],
        creationTime: data['creationTime'],
        deleted: data['deleted'],
        user: data['user'],
        difficultyLevel: data['difficultyLevel'],
        dishRegions: data['dishRegions'],
        reviews: data['reviews']);
  }

  toJson() => {
        'recipeTitle': recipeTitle,
        'prepTime': prepTime,
        'photoPath': photoPath,
        'rank': rank,
        'creationTime': creationTime,
        'deleted': deleted,
        'user': user,
        'difficultyLevel': difficultyLevel,
        'dishRegions': dishRegions,
        'reviews': reviews
      };
}
