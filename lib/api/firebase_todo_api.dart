/*
  Created by: Sebastian M. Villavicencio
  Section: D5L
  Date: 2 December 2022
  Description: Flutter mobile application composed of a sign in, sign-up and a shared todo list features with a user’s friends. 
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirebaseTodoAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  // final db = FakeFirebaseFirestore();

  Future<String> addTodo(Map<String, dynamic> todo, String displayName) async {
    try {
      final docRef = await db.collection("todos").add(todo);
      await db.collection("todos").doc(docRef.id).update({
        'id': docRef.id,
      });

      return docRef.id;
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllTodos() {
    return db.collection("todos").snapshots();
  }

  Stream<QuerySnapshot> getUserTodos(String uid) {
    return db.collection("todos").where("userId", isEqualTo: uid).snapshots();
  }

  Future<String> deleteTodo(String? id) async {
    try {
      await db.collection("todos").doc(id).delete();

      return "Successfully deleted todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> editTodo(String? id, String title, String description,
      DateTime deadline, String displayName) async {
    try {
      await db.collection("todos").doc(id).update({
        "title": title,
        "description": description,
        "deadline": deadline,
        "lastEditedBy": displayName,
        "lastEditedOn":
            DateFormat('EEE, MMM d, hh:mm aaa').format(DateTime.now()),
      });
      return "Successfully edited todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> toggleStatus(String? id, bool status) async {
    try {
      await db.collection("todos").doc(id).update({"completed": status});

      return "Successfully edited todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
