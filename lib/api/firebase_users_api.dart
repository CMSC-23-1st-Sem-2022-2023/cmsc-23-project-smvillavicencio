import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUsersAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> getOneUser(String uid) {
    return db.collection("users").doc(uid).snapshots();
  }

  Stream<QuerySnapshot> getAllUsers() {
    // retruns all users except the logged in user
    return db.collection("users").snapshots();
  }

  // Stream<QuerySnapshot> getCurrentUser() {
  //   // returns the logged in user
  //   return db
  //       .collection("users")
  //       .where("id", isEqualTo: )
  //       .snapshots();
  // }

  Future<String> removeFriend(
      String currentUserId, String unfriendedUserId) async {
    try {
      await db.collection("users").doc(currentUserId).update({
        'friends': FieldValue.arrayRemove([unfriendedUserId])
      });
      await db.collection("users").doc(unfriendedUserId).update({
        'friends': FieldValue.arrayRemove([currentUserId])
      });

      return "Successfully unfriended!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> acceptUser(String currentUserId, String senderUserId) async {
    try {
      await db.collection("users").doc(currentUserId).update({
        'friends': FieldValue.arrayUnion([senderUserId]),
        'receivedFriendRequests': FieldValue.arrayRemove([senderUserId])
      });
      await db.collection("users").doc(senderUserId).update({
        'friends': FieldValue.arrayUnion([currentUserId]),
        'sentFriendRequest': FieldValue.arrayRemove([currentUserId])
      });

      return "Successfully accepted!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> rejectUser(String currentUserId, String senderUserId) async {
    try {
      await db.collection("users").doc(currentUserId).update({
        'receivedFriendRequests': FieldValue.arrayRemove([senderUserId])
      });
      await db.collection("users").doc(senderUserId).update({
        'sentFriendRequest': FieldValue.arrayRemove([currentUserId])
      });

      return "Successfully rejected!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> addUser(String currentUserId, String addedUserId) async {
    try {
      await db.collection("users").doc(currentUserId).update({
        'sentFriendRequest': FieldValue.arrayUnion([addedUserId])
      });
      await db.collection("users").doc(addedUserId).update({
        'receivedFriendRequests': FieldValue.arrayUnion([currentUserId])
      });

      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> cancelFriendRequest(
      String currentUserId, String requestedUserId) async {
    try {
      await db.collection("users").doc(currentUserId).update({
        'sentFriendRequest': FieldValue.arrayRemove([requestedUserId])
      });
      await db.collection("users").doc(requestedUserId).update({
        'receivedFriendRequests': FieldValue.arrayRemove([currentUserId])
      });

      return "Successfully cancelled friend request!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> editBio(String bio, String userId) async {
    try {
      await db.collection("users").doc(userId).update({"bio": bio});
      return "Successfully edited bio.";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
