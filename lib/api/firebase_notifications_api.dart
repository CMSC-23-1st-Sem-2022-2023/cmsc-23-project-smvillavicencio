/*
  Created by: Sebastian M. Villavicencio
  Section: D5L
  Date: 13 December 2022
  Description: Flutter mobile application composed of a sign in, sign-up and a shared todo list features with a user’s friends. 
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseNotificationsAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // get list of notifications arranged from newst to oldest
  Stream<QuerySnapshot> getNotifications(String uid) {
    return db
        .collection("users")
        .doc(uid)
        .collection("notifications")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  addNotification(String uid, Map<String, dynamic> notification) async {
    try {
      final docRef = await db
          .collection("users")
          .doc(uid)
          .collection("notifications")
          .add(notification);
      await db
          .collection("users")
          .doc(uid)
          .collection("notifications")
          .doc(docRef.id)
          .update({
        'id': docRef.id,
      });

      return "Notification added";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  editNotificationTimeStamp(
      String uid, String todoId, DateTime timestamp) async {
    try {
      await db
          .collection("users")
          .doc(uid)
          .collection("notifications")
          .where("sourceId", isEqualTo: todoId)
          .where("type", isEqualTo: "deadline")
          .get()
          .then(
        (value) {
          print(value.docs);
        },
      );
      return "Successfullty edited notification";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
