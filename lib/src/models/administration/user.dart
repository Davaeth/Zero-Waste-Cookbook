import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final DateTime createTime;
  final DateTime roleAssignmentDate;
  final bool deleted;
  final DocumentReference role;
  final List<DocumentReference> favouriteRecipes;
  final List<DocumentReference> recipes;

  User(
      {this.id,
      this.username,
      this.createTime,
      this.roleAssignmentDate,
      this.deleted,
      this.role,
      this.favouriteRecipes,
      this.recipes});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return User(
        id: doc.documentID,
        username: data['username'] ?? 'Guest',
        createTime: data['createTime'] ?? DateTime(2019),
        roleAssignmentDate: data['roleAssignmentDate'] ?? DateTime(2019),
        deleted: data['deleted'] ?? false,
        role: data['role'],
        favouriteRecipes: data['favouriteRecipes'],
        recipes: data['recipes']);
  }

  toJson() => {
        'username': username,
        'createTime': createTime,
        'roleAssignmentDate': roleAssignmentDate,
        'deleted': deleted,
        'role': role,
        'favouriteRecipes': favouriteRecipes,
        'recipes': recipes
      };
}
