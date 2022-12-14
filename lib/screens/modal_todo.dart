import 'package:cmsc23_project_villavicencio/models/notification_model.dart';
import 'package:cmsc23_project_villavicencio/models/todo_model.dart';
import 'package:cmsc23_project_villavicencio/providers/notification_provider.dart';
import 'package:cmsc23_project_villavicencio/providers/todo_provider.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class TodoModal extends StatefulWidget {
  String type;
  String uid;
  String displayName;
  TodoModal({
    super.key,
    required this.type,
    required this.uid,
    required this.displayName,
  });

  @override
  _TodoModalState createState() => _TodoModalState();
}

class _TodoModalState extends State<TodoModal> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _deadlineController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _permissionDenied = false;

  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  @override
  void initState() {
    super.initState();
    // _checkCalendarPermission();
  }

  // _checkCalendarPermission() async {
  //   var permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
  //   if (!permissionsGranted.isSuccess) {
  //     setState(() {
  //       _permissionDenied = true;
  //     });
  //   }
  // }

  // Method to show the title of the modal depending on the functionality
  Text _buildTitle() {
    switch (widget.type) {
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

  // builds the required fields when editting or adding
  Form _buildForm(BuildContext context, Map<String, String> hintText) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: _titleController =
                  TextEditingController(text: hintText["title"]),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Title',
                hintText: hintText["title"],
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.teal),
                ),
                errorStyle: TextStyle(color: Colors.pink),
                errorBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedErrorBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Title is required";
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: _descriptionController =
                  TextEditingController(text: hintText["description"]),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Description',
                hintText: hintText["description"],
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.teal),
                ),
                errorStyle: TextStyle(color: Colors.pink),
                errorBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedErrorBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
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
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.teal),
                ),
                errorStyle: TextStyle(color: Colors.pink),
                errorBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedErrorBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.teal),
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
          )
        ],
      ),
    );
  }

  // Method to build the content or body depending on the functionality
  Widget _buildContent(BuildContext context) {
    switch (widget.type) {
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
          "deadline": DateFormat('yMMMMd')
              .format(context.read<TodoListProvider>().selected.deadline),
        };
        return _buildForm(context, hintText);

      default:
        return _buildForm(
            context, {"title": "", "description": "", "deadline": ""});
    }
  }

  TextButton _dialogAction(BuildContext context) {
    return TextButton(
      onPressed: () async {
        switch (widget.type) {
          case 'Add':
            {
              if (_formKey.currentState!.validate()) {
                // Instantiate a todo objeect to be inserted, default userID will be 1, the id will be the next id in the list
                Todo temp = Todo(
                  userId: widget.uid,
                  completed: false,
                  deadline: DateTime.parse(_deadlineController.text),
                  description: _descriptionController.text,
                  title: _titleController.text,
                  lastEditedBy: widget.displayName,
                  lastEditedOn: DateFormat('EEE, MMM d, hh:mm aaa')
                      .format(DateTime.now()),
                );

                Future<String> tid = context
                    .read<TodoListProvider>()
                    .addTodo(temp, widget.displayName);
                String todoId = await tid;

                Notifications notif = Notifications(
                    type: "deadline",
                    sourceId: todoId,
                    body:
                        "Your task ${temp.title} is due on ${DateFormat("MMMMd").format(temp.deadline)}.",
                    timestamp: temp.deadline.subtract(Duration(days: 1)));

                context
                    .read<NotificationsProvider>()
                    .addNotification(temp.userId, notif);

                if (!_permissionDenied) {
                  final Event newEvent = Event(todoId,
                      title: temp.title,
                      description: temp.description,
                      start: tz.TZDateTime.from(temp.deadline, tz.local),
                      allDay: true);

                  final createEventResult =
                      await _deviceCalendarPlugin.createOrUpdateEvent(newEvent);
                  if (createEventResult!.isSuccess) {
                    print("Added to calendar");
                  }
                }
                // Remove dialog after adding
                Navigator.of(context).pop();
              }
              break;
            }
          case 'Edit':
            if (_formKey.currentState!.validate()) {
              Todo todoBefore = context.read<TodoListProvider>().selected;

              context.read<TodoListProvider>().editTodo(
                    _titleController.text,
                    _descriptionController.text,
                    DateTime.parse(_deadlineController.text),
                    widget.displayName,
                  );

              if (todoBefore.userId != widget.uid) {
                // if owner of the todo is not the editor then create a notification
                Notifications notif = Notifications(
                    type: "edit",
                    sourceId: widget.uid,
                    body: todoBefore.title == _titleController.text
                        ? "${widget.displayName} edited ${todoBefore.title}."
                        : "${widget.displayName} changed ${todoBefore.title}'s title to ${_titleController.text}.",
                    timestamp: DateTime.now());
                context
                    .read<NotificationsProvider>()
                    .addNotification(todoBefore.userId, notif);
              }

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
      child: Text(
        widget.type,
        style: TextStyle(color: Colors.teal),
      ),
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
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.teal),
          ),
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
