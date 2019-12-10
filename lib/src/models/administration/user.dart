import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final Timestamp createTime;
  final bool deleted;
  final Map<String, String> account;
  final DocumentReference role;
  final List<DocumentReference> favouriteRecipes;
  final List<DocumentReference> recipes;

  User(
      {this.id,
      this.account,
      this.createTime,
      this.deleted,
      this.role,
      this.favouriteRecipes,
      this.recipes});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return User(
      id: doc.documentID,
      account:
          Map<String, String>.from(data['account']) ?? Map<String, String>(),
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
        'account': account,
        'createTime': createTime,
        'deleted': deleted,
        'role': role,
        'favouriteRecipes': favouriteRecipes,
        'recipes': recipes
      };
}
