import 'package:cloud_firestore/cloud_firestore.dart';

class Role {
  final String id;
  final String roleName;

  Role({this.id, this.roleName});

  factory Role.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Role(id: doc.documentID, roleName: data['roleName'] ?? 'User');
  }

  toJson() => {'roleName': roleName};
}
