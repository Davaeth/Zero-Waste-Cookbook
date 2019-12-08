import 'package:cloud_firestore/cloud_firestore.dart';

class Photo {
  final String id;
  final String photoPath;
  final DocumentReference recipe;

  Photo({this.id, this.photoPath, this.recipe});

  factory Photo.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Photo(photoPath: data['photoPath'] ?? '', recipe: doc['recipe'] ?? null);
  }

  toJson() => {'photoPath': photoPath, 'recipe': recipe};
}
