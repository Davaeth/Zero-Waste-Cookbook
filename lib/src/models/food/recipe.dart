import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String id;
  final String recipeTitle;
  final int prepTime;
  final String description;
  final String photoPath;
  final double rank;
  final Timestamp creationTime;
  final DocumentReference user;
  final DocumentReference difficultyLevel;
  final DocumentReference dishRegions;
  final List<DocumentReference> ingredients;

  Recipe(
      {this.id,
      this.recipeTitle,
      this.prepTime,
      this.description,
      this.photoPath,
      this.rank,
      this.creationTime,
      this.user,
      this.difficultyLevel,
      this.dishRegions,
      this.ingredients});

  factory Recipe.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Recipe(
      id: doc.documentID,
      recipeTitle: data['recipeTitle'] ?? '',
      prepTime: data['prepTime'],
      description: data['description'],
      photoPath: data['photoPath'],
      rank: double.parse(data['rank'].toString()) ?? 0.0,
      creationTime: data['creationTime'],
      user: data['user'],
      difficultyLevel: data['difficultyLevel'],
      dishRegions: data['dishRegions'],
      ingredients: List<DocumentReference>.from(data['ingredients']) ??
          List<DocumentReference>(),
    );
  }

  toJson() => {
        'recipeTitle': recipeTitle,
        'prepTime': prepTime,
        'description': description,
        'photoPath': photoPath,
        'rank': rank,
        'creationTime': creationTime,
        'user': user,
        'difficultyLevel': difficultyLevel,
        'dishRegions': dishRegions,
        'ingredients': ingredients
      };
}
