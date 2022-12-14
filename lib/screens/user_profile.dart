/*
  Created by: Sebastian M. Villavicencio
  Section: D5L
  Date: 2 December 2022
  Description: Flutter mobile application composed of a sign in, sign-up and a shared todo list features with a user’s friends. 
*/

import 'package:cmsc23_project_villavicencio/models/user_model.dart';
import 'package:cmsc23_project_villavicencio/providers/auth_provider.dart';
import 'package:cmsc23_project_villavicencio/providers/user_provider.dart';
import 'package:cmsc23_project_villavicencio/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  // page where details of the user with the uid parameter are seen
  String uid;
  ProfilePage({super.key, required this.uid});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (!context.watch<AuthProvider>().isAuthenticated) {
      // unauthenticated users cannot access profile pages
      return Center(
        child: Column(
          children: [
            Text("You are not logged in!"),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                fixedSize: Size(100, 40),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"),
            ),
          ],
        ),
      );
    }
    // get  all streams needed for building the profile page
    String currentUserId = context.watch<AuthProvider>().user!.uid;
    context.watch<UsersProvider>().fetchOneUser(widget.uid);
    Stream user = context.watch<UsersProvider>().user;

    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        drawer: DrawerWidget(),
        body: Center(
          child: StreamBuilder(
            stream: user,
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
                  child: Text("No Users Found"),
                );
              }

              User profileUser =
                  User.fromJson(snapshot.data.data() as Map<String, dynamic>);

              return Center(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.pink,
                      child: Icon(Icons.person),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "ID: ${profileUser.id}",
                      )),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Name: ${profileUser.firstName} ${profileUser.lastName}",
                      )),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Birthday: ${profileUser.birthday}",
                      )),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Location: ${profileUser.location}",
                      )),
                  profileUser.bio == ''
                      ? Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "No bio yet.",
                          ))
                      : Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Bio: ${profileUser.bio}",
                          )),
                  profileUser.id != currentUserId
                      ? Container()
                      : profileUser.bio == ''
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                fixedSize: Size(100, 40),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Add bio"),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            TextField(
                                              controller: _bioController,
                                              decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                enabledBorder:
                                                    new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          25.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.teal),
                                                ),
                                                errorStyle: TextStyle(
                                                    color: Colors.pink),
                                                errorBorder:
                                                    new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          25.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.pink),
                                                ),
                                                focusedBorder:
                                                    new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          25.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.teal),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                                labelText: 'Bio',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            'Done',
                                            style:
                                                TextStyle(color: Colors.teal),
                                          ),
                                          onPressed: () {
                                            print('Done');
                                            context
                                                .read<UsersProvider>()
                                                .editBio(_bioController.text,
                                                    widget.uid);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Cancel',
                                              style: TextStyle(
                                                  color: Colors.teal)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text("Add bio"),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Edit bio"),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            TextField(
                                              controller: _bioController =
                                                  TextEditingController(
                                                      text: profileUser.bio),
                                              decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                enabledBorder:
                                                    new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          25.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.teal),
                                                ),
                                                errorStyle: TextStyle(
                                                    color: Colors.pink),
                                                errorBorder:
                                                    new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          25.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.pink),
                                                ),
                                                focusedBorder:
                                                    new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          25.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.teal),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                                labelText: 'Bio',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Done'),
                                          onPressed: () {
                                            print('Done');
                                            context
                                                .read<UsersProvider>()
                                                .editBio(_bioController.text,
                                                    widget.uid);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text("Edit bio"),
                            )
                ]),
              );
            },
          ),
        ));
  }
}
