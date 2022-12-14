import 'dart:convert';

class Todo {
  final String userId;
  String? id;
  String title;
  String description;
  DateTime deadline;
  bool completed;
  String lastEditedBy;
  String lastEditedOn;

  Todo({
    required this.userId,
    this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.completed,
    required this.lastEditedBy,
    required this.lastEditedOn,
  });

  // Factory constructor to instantiate object from json format
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      description: json['description'],
      deadline: json['deadline'].toDate(),
      completed: json['completed'],
      lastEditedBy: json['lastEditedBy'],
      lastEditedOn: json['lastEditedOn'],
    );
  }

  static List<Todo> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Todo>((dynamic d) => Todo.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Todo todo) {
    return {
      'userId': todo.userId,
      'title': todo.title,
      'description': todo.description,
      'deadline': todo.deadline,
      'completed': todo.completed,
      'lastEditedBy': todo.lastEditedBy,
      'lastEditedOn': todo.lastEditedOn,
    };
  }
}
