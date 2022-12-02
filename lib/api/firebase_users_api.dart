import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUsersAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> getOneUser(String uid) {
    return db.collection("users").doc(uid).snapshots();
  }
}
