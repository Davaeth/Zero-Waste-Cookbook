import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:template_name/src/models/user.dart';

class DatabaseService {
  final _db = Firestore.instance;

  Stream<User> streamUser(String id) => _db
      .collection('Users')
      .document(id)
      .snapshots()
      .map((snap) => User.fromFitrestore(snap));

  Future<void> createUser(Map user) async {
    _db.collection('Users').add(user);
  }
}