import 'package:cmsc23_project_villavicencio/models/todo_model.dart';
import 'package:cmsc23_project_villavicencio/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TodoModal extends StatelessWidget {
  String type;
  String uid;
  String displayName;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _deadlineController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TodoModal({
    super.key,
    required this.type,
    required this.uid,
    required this.displayName,
  });

  // Method to show the title of the modal depending on the functionality
  Text _buildTitle() {
    switch (type) {
      case 'Add':
        return const Text("Add new todo");
      case 'Edit':
        return const Text("Edit todo");
      case 'Delete':
        return const Text("Delete todo");
      default:
        return const Text("");
    }
  }

  Form _buildForm(BuildContext context, Map<String, String> hintText) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _titleController =
                TextEditingController(text: hintText["title"]),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Title',
              hintText: hintText["title"],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Title is required";
              }
            },
          ),
          TextFormField(
            controller: _descriptionController =
                TextEditingController(text: hintText["description"]),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Description',
              hintText: hintText["description"],
            ),
          ),
          TextFormField(
            controller: _deadlineController =
                TextEditingController(text: hintText["deadline"]),
            decoration: InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: "Deadline",
              suffixIcon: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  _deadlineController.text = "";
                },
              ),
            ),
            readOnly: true,
            onTap: () async {
              await showDatePicker(
                context: context,
                initialDate: hintText["deadline"] == ""
                    ? _deadlineController.text == ""
                        ? DateTime.now()
                        : DateTime.parse(_deadlineController.text)
                    : DateTime.parse(hintText["deadline"]!),
                firstDate: DateTime(2022),
                lastDate: DateTime(2122),
              ).then((value) {
                if (value != null) {
                  _deadlineController.text =
                      DateFormat('yyyy-MM-dd').format(value);
                }
              });
            },
          ),
        ],
      ),
    );
  }

  // Method to build the content or body depending on the functionality
  Widget _buildContent(BuildContext context) {
    switch (type) {
      case 'Delete':
        {
          return Text(
            "Are you sure you want to delete '${context.read<TodoListProvider>().selected.title}'?",
          );
        }
      case 'Edit':
        Map<String, String> hintText = {
          "title": context.read<TodoListProvider>().selected.title,
          "description": context.read<TodoListProvider>().selected.description,
          "deadline": context.read<TodoListProvider>().selected.deadline,
        };
        return _buildForm(context, hintText);

      default:
        return _buildForm(
            context, {"title": "", "description": "", "deadline": ""});
    }
  }

  TextButton _dialogAction(BuildContext context) {
    // List<Todo> todoItems = context.read<TodoListProvider>().todo;

    return TextButton(
      onPressed: () {
        switch (type) {
          case 'Add':
            {
              if (_formKey.currentState!.validate()) {
                // Instantiate a todo objeect to be inserted, default userID will be 1, the id will be the next id in the list
                Todo temp = Todo(
                  userId: uid,
                  completed: false,
                  deadline: _deadlineController.text,
                  description: _descriptionController.text,
                  title: _titleController.text,
                  lastEditedBy: displayName,
                  lastEditedOn: DateFormat('EEE, MMM d, hh:mm aaa')
                      .format(DateTime.now()),
                );

                context.read<TodoListProvider>().addTodo(temp, displayName);

                // Remove dialog after adding
                Navigator.of(context).pop();
              }
              break;
            }
          case 'Edit':
            if (_formKey.currentState!.validate()) {
              context.read<TodoListProvider>().editTodo(
                    _titleController.text,
                    _descriptionController.text,
                    _deadlineController.text,
                    displayName,
                  );

              // Remove dialog after editing
              Navigator.of(context).pop();
            }
            break;
          case 'Delete':
            {
              context.read<TodoListProvider>().deleteTodo();

              // Remove dialog after editing
              Navigator.of(context).pop();
              break;
            }
        }
      },
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      child: Text(type),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitle(),
      content: _buildContent(context),
      // Contains two buttons - add/edit/delete, and cancel
      actions: <Widget>[
        _dialogAction(context),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
