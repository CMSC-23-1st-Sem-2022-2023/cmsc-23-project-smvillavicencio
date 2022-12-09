import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

class FirebaseTodoAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  // final db = FakeFirebaseFirestore();

  Future<String> addTodo(Map<String, dynamic> todo) async {
    try {
      final docRef = await db.collection("todos").add(todo);
      await db.collection("todos").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllTodos() {
    return db.collection("todos").snapshots();
  }

  Future<String> deleteTodo(String? id) async {
    try {
      await db.collection("todos").doc(id).delete();

      return "Successfully deleted todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> editTodo(
    String? id,
    String? title,
    String? description,
    String? deadline,
  ) async {
    try {
      if (title!.isNotEmpty) {
        await db.collection("todos").doc(id).update({"title": title});
      }
      if (description!.isNotEmpty) {
        await db
            .collection("todos")
            .doc(id)
            .update({"description": description});
      }
      if (deadline!.isNotEmpty) {
        await db.collection("todos").doc(id).update({"deadline": deadline});
      }

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
