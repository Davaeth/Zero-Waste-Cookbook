import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final Timestamp createTime;
  final bool deleted;
  final DocumentReference role;
  final List<DocumentReference> favouriteRecipes;
  final List<DocumentReference> recipes;

  User(
      {this.id,
      this.username,
      this.createTime,
      this.deleted,
      this.role,
      this.favouriteRecipes,
      this.recipes});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return User(
      id: doc.documentID,
      username: data['username'] ?? 'Guest',
      createTime: data['createTime'] ?? Timestamp.fromDate(DateTime.now()),
      deleted: data['deleted'] ?? false,
      role: data['role'],
      favouriteRecipes:
          List<DocumentReference>.from(data['favouriteRecipes']) ??
              List<DocumentReference>(),
      recipes: List<DocumentReference>.from(data['recipes']) ??
          List<DocumentReference>(),
    );
  }

  toJson() => {
        'username': username,
        'createTime': createTime,
        'deleted': deleted,
        'role': role,
        'favouriteRecipes': favouriteRecipes,
        'recipes': recipes
      };
}
