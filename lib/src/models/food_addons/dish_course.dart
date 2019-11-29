import 'package:cloud_firestore/cloud_firestore.dart';

class DishCourse {
  final String id;
  final String dishCourseName;

  DishCourse({this.id, this.dishCourseName});

  factory DishCourse.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return DishCourse(
        id: doc.documentID,
        dishCourseName: data['dish_course_name'] ?? 'Empty name');
  }

  toJson() => {'dishCourseName': dishCourseName};
}
