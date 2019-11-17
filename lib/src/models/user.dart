import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;

  User({this.id, this.username});

  factory User.fromFitrestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return User(id: doc.documentID, username: data['username'] ?? 'Guest');
  }

  toJson() => {'username': username};
}