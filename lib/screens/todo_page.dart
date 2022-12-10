import 'package:cmsc23_project_villavicencio/models/todo_model.dart';
import 'package:cmsc23_project_villavicencio/models/user_model.dart';
import 'package:cmsc23_project_villavicencio/providers/todo_provider.dart';
import 'package:cmsc23_project_villavicencio/providers/user_provider.dart';
import 'package:cmsc23_project_villavicencio/screens/modal_todo.dart';
import 'package:cmsc23_project_villavicencio/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/auth_provider.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!context.watch<AuthProvider>().isAuthenticated) {
      return Center(
        child: Column(
          children: [
            Text("You are not logged in!"),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"),
            ),
          ],
        ),
      );
    }

    String currentUserID = context.watch<AuthProvider>().user!.uid;
    // access the list of todos in the provider
    context.watch<UsersProvider>().fetchOneUser(currentUserID);
    Stream<DocumentSnapshot> currentUserStream =
        context.watch<UsersProvider>().user;
    String userDisplayName = context.watch<AuthProvider>().user!.displayName!;
    context.watch<TodoListProvider>().fetchTodos();
    Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todos;

    List<Widget> _widgetOptions = <Widget>[
      _buildMyToDo(todosStream, currentUserID, userDisplayName),
      _buildFriendsToDo(todosStream, currentUserStream, userDisplayName),

      // _buildFriends(usersStream, currentUserStream), // friends
      // _buildRequests(usersStream, currentUserStream), // friend requests
      // _buildSearch(usersStream, currentUserStream), // friend search
    ];

    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(
          "Todo",
        ),
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'My To Dos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Friend\'s To Dos',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _onItemTapped(index);
          print("index ${_selectedIndex}");
        },
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => TodoModal(
                    type: 'Add',
                    uid: currentUserID,
                    displayName: userDisplayName,
                  ),
                );
              },
              // backgroundColor: Color(0xFF5F18C5),
              child: const Icon(Icons.add_outlined),
            )
          : null,
    );
  }

  StreamBuilder _buildMyToDo(Stream<QuerySnapshot<Object?>> todosStream,
      String currentUserID, String userDisplayName) {
    return StreamBuilder(
      stream: todosStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error encountered! ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: Text("No Todos Found"),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: ((context, index) {
            Todo todo = Todo.fromJson(
                snapshot.data?.docs[index].data() as Map<String, dynamic>);
            if (todo.userId != currentUserID) {
              return Container();
            }
            return Dismissible(
              key: Key(todo.id.toString()),
              onDismissed: (direction) {
                context.read<TodoListProvider>().changeSelectedTodo(todo);
                context.read<TodoListProvider>().deleteTodo();

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${todo.title} dismissed')));
              },
              background: Container(
                color: Colors.red,
                child: const Icon(Icons.delete),
              ),
              child: ListTile(
                title: Text(todo.title),
                leading: Checkbox(
                  value: todo.completed,
                  onChanged: (bool? value) {
                    context.read<TodoListProvider>().changeSelectedTodo(todo);
                    context.read<TodoListProvider>().toggleStatus(value!);
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        context
                            .read<TodoListProvider>()
                            .changeSelectedTodo(todo);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => TodoModal(
                            type: 'Edit',
                            uid: currentUserID,
                            displayName: userDisplayName,
                          ),
                        );
                      },
                      icon: const Icon(Icons.create_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        context
                            .read<TodoListProvider>()
                            .changeSelectedTodo(todo);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => TodoModal(
                            type: 'Delete',
                            uid: currentUserID,
                            displayName: userDisplayName,
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete_outlined),
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  StreamBuilder _buildFriendsToDo(
      Stream<QuerySnapshot<Object?>> todosStream,
      Stream<DocumentSnapshot<Object?>> currentUserStream,
      String userDisplayName) {
    return StreamBuilder(
      stream: currentUserStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error encountered! ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: Text("User not Found"),
          );
        }

        User currUser =
            User.fromJson(snapshot.data.data() as Map<String, dynamic>);

        return StreamBuilder(
          stream: todosStream,
          builder: (context, snapshotTodos) {
            if (snapshotTodos.hasError) {
              return Center(
                child: Text("Error encountered! ${snapshotTodos.error}"),
              );
            } else if (snapshotTodos.connectionState ==
                ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshotTodos.hasData) {
              return Center(
                child: Text("No Todos Found"),
              );
            }
            return ListView.builder(
              itemCount: snapshotTodos.data?.docs.length,
              itemBuilder: ((context, index) {
                Todo todo = Todo.fromJson(snapshotTodos.data?.docs[index].data()
                    as Map<String, dynamic>);
                if (!currUser.friends.contains(todo.userId)) {
                  return Container();
                }
                return ListTile(
                  title: Text(todo.title),
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: null,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          context
                              .read<TodoListProvider>()
                              .changeSelectedTodo(todo);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => TodoModal(
                              type: 'Edit',
                              uid: currUser.id!,
                              displayName: userDisplayName,
                            ),
                          );
                        },
                        icon: const Icon(Icons.create_outlined),
                      ),
                    ],
                  ),
                );
              }),
            );
          },
        );
      },
    );
  }
}
