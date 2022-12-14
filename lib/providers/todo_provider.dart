import 'package:cmsc23_project_villavicencio/api/firebase_todo_api.dart';
import 'package:cmsc23_project_villavicencio/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListProvider with ChangeNotifier {
  late FirebaseTodoAPI firebaseService;
  late Stream<QuerySnapshot> _todosStream;
  Todo? _selectedTodo;

  TodoListProvider() {
    firebaseService = FirebaseTodoAPI();
    fetchTodos();
  }

  // getter
  Stream<QuerySnapshot> get todos => _todosStream;
  Todo get selected => _selectedTodo!;

  changeSelectedTodo(Todo item) {
    _selectedTodo = item;
  }

  void fetchTodos() {
    _todosStream = firebaseService.getAllTodos();
    // notifyListeners();
  }

  Future<String> addTodo(Todo item, String displayName) async {
    String todoId =
        await firebaseService.addTodo(item.toJson(item), displayName);
    notifyListeners();
    return todoId;
  }

  void editTodo(String title, String description, DateTime deadline,
      String displayName) async {
    String message = await firebaseService.editTodo(
        _selectedTodo!.id, title, description, deadline, displayName);
    print(message);
    notifyListeners();
  }

  void deleteTodo() async {
    String message = await firebaseService.deleteTodo(_selectedTodo!.id);
    print(message);
    notifyListeners();
  }

  void toggleStatus(bool status) async {
    String message =
        await firebaseService.toggleStatus(_selectedTodo!.id, status);
    print(message);
    notifyListeners();
  }
}
