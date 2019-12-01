import 'package:cloud_firestore/cloud_firestore.dart';

class DishRegion {
  final String id;
  final String regionName;

  DishRegion({this.id, this.regionName});

  factory DishRegion.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return DishRegion(
        id: doc.documentID, regionName: data['regionName'] ?? 'Empty name');
  }

  toJson() => {'regionName': regionName};
}
