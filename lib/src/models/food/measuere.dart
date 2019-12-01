import 'package:cloud_firestore/cloud_firestore.dart';

class Measure {
  final String id;
  final String measureName;

  Measure({this.id, this.measureName});

  factory Measure.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Measure(
        id: doc.documentID, measureName: data['measureName'] ?? 'Empty name');
  }

  toJson() => {'measureName': measureName};
}
