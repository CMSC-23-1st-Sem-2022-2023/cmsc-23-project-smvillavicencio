import 'package:cmsc23_project_villavicencio/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared To Do'),
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
    );
  }
}