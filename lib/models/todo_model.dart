import 'dart:convert';

class Todo {
  final String userId;
  String? id;
  String title;
  String description;
  String deadline;
  bool completed;
  String lastEditedBy;
  String lastEditedOn;
  // DateTime lastModified = DateTime.now();

  Todo({
    required this.userId,
    this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.completed,
    required this.lastEditedBy,
    required this.lastEditedOn,
    // required this.modifiedBy,
    // required this.lastModified,
  });

  // Factory constructor to instantiate object from json format
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      description: json['description'],
      deadline: json['deadline'],
      completed: json['completed'],
      lastEditedBy: json['lastEditedBy'],
      lastEditedOn: json['lastEditedOn'],
      // modifiedBy: json['modifiedBy'],
      // lastModified: json['lastModified'],
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
      // 'modifiedBy': todo.modifiedBy,
      // 'lastModified': todo.lastModified,
    };
  }
}
