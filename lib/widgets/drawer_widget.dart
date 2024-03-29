import 'package:cmsc23_project_villavicencio/providers/auth_provider.dart';
// import 'package:cmsc23_project_villavicencio/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.teal,
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.pink,
                child: Icon(Icons.person),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  '${context.read<AuthProvider>().user!.displayName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              )
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
          onTap: () {
            Navigator.pushNamed(context, "/");
          },
        ),
        ListTile(
          leading: Icon(Icons.checklist),
          title: Text('To Do'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushNamed(context, "/todo");
          },
        ),
        ListTile(
          leading: Icon(Icons.people_alt_rounded),
          title: Text('Friends'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushNamed(context, "/friends");
          },
        ),
        // ListTile(
        //   leading: Icon(Icons.notifications),
        //   title: Text('Notifications'),
        //   onTap: () async {
        //     Navigator.pop(context);
        //     Navigator.pop(context);
        //     Navigator.pushNamed(context, '/notifications');
        //   },
        // ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () async {
            // Navigator.pop(context);
            context.read<AuthProvider>().signOut();
            // Navigator.pop(context);
            Navigator.pushNamed(context, '/');
          },
        ),
      ],
    ));
  }
}
