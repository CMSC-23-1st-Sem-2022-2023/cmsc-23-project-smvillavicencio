import 'package:cmsc23_project_villavicencio/models/todo_model.dart';
import 'package:cmsc23_project_villavicencio/providers/todo_provider.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoModal extends StatelessWidget {
  String type;
  String uid;
  TextEditingController _formFieldController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _deadlineController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TodoModal({
    super.key,
    required this.type,
    required this.uid,
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
            controller: _descriptionController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Description',
              hintText: hintText["description"],
            ),
          ),
          DateTimeFormField(
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.event_note),
              labelText: 'Deadline',
            ),
            mode: DateTimeFieldPickerMode.date,
            onDateSelected: (value) {
              _deadlineController.text =
                  "${value.year.toString()}-${value.month.toString()}-${value.day.toString()}";
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
        };
        return _buildForm(context, hintText);

      default:
        return _buildForm(context, {"title": "", "description": ""});
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
                );

                context.read<TodoListProvider>().addTodo(temp);

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
