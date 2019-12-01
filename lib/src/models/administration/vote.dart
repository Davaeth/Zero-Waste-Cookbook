import 'package:cloud_firestore/cloud_firestore.dart';

class Vote {
  final String id;
  final bool vote;
  final DocumentReference user;
  final DocumentReference application;

  Vote({this.id, this.vote, this.user, this.application});

  factory Vote.fromFirebase(DocumentSnapshot doc) {
    Map data = doc.data;

    return Vote(
        id: doc.documentID,
        vote: data['vote'] ?? false,
        user: data['user'],
        application: data['application']);
  }

  toJson() => {'vote': vote, 'user': user, 'application': application};
}
