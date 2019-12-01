import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String description;
  final String reviewType;
  final int rate;
  final int rank;
  final DocumentReference recipe;
  final DocumentReference user;

  Review(
      {this.id,
      this.description,
      this.reviewType,
      this.rate,
      this.rank,
      this.recipe,
      this.user});

  factory Review.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Review(
        id: doc.documentID,
        description: data['description'] ?? 'Empty',
        reviewType: data['reviewType'],
        rate: data['rate'] ?? 1,
        rank: data['rank'] ?? 1,
        recipe: data['recipe'],
        user: data['user']);
  }

  toJson() => {
        'description': description,
        'reviewType': reviewType,
        'rate': rate,
        'rank': rank,
        'recipe': recipe,
        'user': user
      };
}
