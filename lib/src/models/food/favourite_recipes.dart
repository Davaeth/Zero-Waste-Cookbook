import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteRecipes {
  final String id;
  final DocumentReference isUser;
  final DocumentReference idRecipes;

  FavouriteRecipes({this.id, this.idRecipes, this.isUser});

  factory FavouriteRecipes.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return FavouriteRecipes(
        isUser: data['isUser'] ?? '', idRecipes: doc['idRecipes'] ?? '');
  }

  toJson() => {'isUser': isUser, 'idRecipes': idRecipes};
}
