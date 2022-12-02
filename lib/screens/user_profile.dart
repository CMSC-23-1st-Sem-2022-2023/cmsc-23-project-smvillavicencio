import 'package:cmsc23_project_villavicencio/models/user_model.dart';
import 'package:cmsc23_project_villavicencio/providers/auth_provider.dart';
import 'package:cmsc23_project_villavicencio/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  String uid;
  ProfilePage({super.key, required this.uid});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    context.watch<UsersProvider>().fetchOneUser(widget.uid);

    Stream user = context.watch<UsersProvider>().user;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.checklist),
              title: Text('To Do'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                context.read<AuthProvider>().signOut();
                Navigator.pop(context);
              },
            ),
          ],
        )),
        body: Center(
          child: Container(
            child: StreamBuilder(
              stream: user,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error encountered! ${snapshot.error}"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
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

                print(snapshot.data.data());
                // print(snapshot['userName']);
                return Container(
                  child: Column(children: [
                    Text(
                      "Name: ${profileUser.firstName} ${profileUser.lastName}",
                    ),
                    Text(
                      "Birthday: ${profileUser.birthday}",
                    ),
                    Text(
                      "Location: ${profileUser.location}",
                    ),
                    profileUser.bio == ''
                        ? Text(
                            "No bio yet.",
                          )
                        : Text(
                            "Location: ${profileUser.bio}",
                          ),
                  ]),
                );
              },
            ),
          ),
        ));
  }
}
