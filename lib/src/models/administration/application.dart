import 'package:cloud_firestore/cloud_firestore.dart';

class Application {
  final String id;
  final String message;
  final String status;
  final DocumentReference user;

  Application({this.id, this.message, this.status, this.user});

  factory Application.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Application(
        id: doc.documentID,
        message: data['message'],
        status: data['status'],
        user: data['user']);
  }

  toJson() => {'message': message, 'status': status, 'user': user};
}
