import 'package:cloud_firestore/cloud_firestore.dart';

class AppStatu {
  final String id;
  final String status;

  AppStatu({this.id, this.status});

  factory AppStatu.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return AppStatu(id: doc.documentID, status: data['status'] ?? 'Ongoing');
  }

  toJson() => {'status': status};
}
