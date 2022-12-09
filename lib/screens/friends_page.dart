import 'package:cmsc23_project_villavicencio/models/user_model.dart';
import 'package:cmsc23_project_villavicencio/providers/auth_provider.dart';
import 'package:cmsc23_project_villavicencio/providers/user_provider.dart';
import 'package:cmsc23_project_villavicencio/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  late TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

    Stream<QuerySnapshot> usersStream = context.watch<UsersProvider>().users;
    String uid = context.watch<AuthProvider>().user!.uid;
    context.watch<UsersProvider>().fetchOneUser(uid);
    context.watch<UsersProvider>().fetchAllUsers();
    Stream<DocumentSnapshot> currentUserStream =
        context.watch<UsersProvider>().user;
    // Stream<QuerySnapshot> currentUserStream =
    //     context.watch<UsersProvider>().currentUser;

    List<Widget> _widgetOptions = <Widget>[
      _buildFriends(usersStream, currentUserStream), // friends
      _buildRequests(usersStream, currentUserStream), // friend requests
      _buildSearch(usersStream, currentUserStream), // friend requests
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Friends",
        ),
      ),
      drawer: DrawerWidget(),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_add),
            label: 'Friend Requests',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  StreamBuilder _buildFriends(Stream<QuerySnapshot<Object?>> usersStream,
      Stream<DocumentSnapshot<Object?>> currentUserStream) {
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

        return StreamBuilder(
            stream: usersStream,
            builder: (context, snapshotUsers) {
              if (snapshotUsers.hasError) {
                return Center(
                  child: Text("Error encountered! ${snapshotUsers.error}"),
                );
              } else if (snapshotUsers.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshotUsers.hasData) {
                return Center(
                  child: Text("No Users Found"),
                );
              }

              // from fetch current user
              User currUser =
                  User.fromJson(snapshot.data.data() as Map<String, dynamic>);

              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshotUsers.data?.docs.length,
                    itemBuilder: (context, index) {
                      // from fetch all users
                      User user = User.fromJson(snapshotUsers.data?.docs[index]
                          .data() as Map<String, dynamic>);

                      if (currUser.friends.contains(user.id)) {
                        return _buildButtons(user, currUser);
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        "Current user: ${currUser.firstName} ${currUser.lastName}"),
                  ),
                ],
              );
            });
      },
    );
  }

  StreamBuilder _buildRequests(Stream<QuerySnapshot<Object?>> usersStream,
      Stream<DocumentSnapshot<Object?>> currentUserStream) {
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

        return StreamBuilder(
            stream: usersStream,
            builder: (context, snapshotUsers) {
              if (snapshotUsers.hasError) {
                return Center(
                  child: Text("Error encountered! ${snapshotUsers.error}"),
                );
              } else if (snapshotUsers.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshotUsers.hasData) {
                return Center(
                  child: Text("No Users Found"),
                );
              }

              // from fetch current user
              User currUser =
                  User.fromJson(snapshot.data.data() as Map<String, dynamic>);

              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshotUsers.data?.docs.length,
                    itemBuilder: (context, index) {
                      // from fetch all users
                      User user = User.fromJson(snapshotUsers.data?.docs[index]
                          .data() as Map<String, dynamic>);

                      if (currUser.receivedFriendRequests.contains(user.id)) {
                        return _buildButtons(user, currUser);
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Current user: ${currUser.firstName} ${currUser.lastName}")),
                ],
              );
            });
      },
    );
  }

  StreamBuilder _buildSearch(Stream<QuerySnapshot<Object?>> usersStream,
      Stream<DocumentSnapshot<Object?>> currentUserStream) {
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

        return StreamBuilder(
            stream: usersStream,
            builder: (context, snapshotUsers) {
              if (snapshotUsers.hasError) {
                return Center(
                  child: Text("Error encountered! ${snapshotUsers.error}"),
                );
              } else if (snapshotUsers.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshotUsers.hasData) {
                return Center(
                  child: Text("No Users Found"),
                );
              }

              // from fetch current user
              User currUser =
                  User.fromJson(snapshot.data.data() as Map<String, dynamic>);

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            controller: _searchController,
                            decoration: InputDecoration(
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                // borderSide: BorderSide(color: Color(0xFF7E36C5)),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                // borderSide: BorderSide(color: Color(0xFF7E36C5)),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white70,
                              prefixIcon: Icon(
                                Icons.search,
                                // color: Color(0xFF7E36C5),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  _searchController.clear();
                                },
                              ),
                              hintText: 'Search...',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            refresh();
                          },
                          child: Text("Search"),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshotUsers.data?.docs.length,
                    itemBuilder: (context, index) {
                      // from fetch all users
                      User user = User.fromJson(snapshotUsers.data?.docs[index]
                          .data() as Map<String, dynamic>);

                      if (_searchController.text == "") {
                        return Container();
                      } else if ((user.username
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase()) ||
                          user.firstName
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase()) ||
                          user.lastName.toLowerCase().contains(
                              _searchController.text.toLowerCase()))) {
                        return _buildButtons(user, currUser);
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Current user: ${currUser.firstName} ${currUser.lastName}")),
                ],
              );
            });
      },
    );
  }

  ListTile _buildButtons(User user, User currUser) {
    if (currUser.friends.contains(user.id)) {
      return ListTile(
          title: Text("${user.firstName} ${user.lastName}"),
          leading: Text("@${user.username}"),
          onTap: () {
            print("go to profile");
          },
          trailing: ElevatedButton(
            onPressed: () {
              context
                  .read<UsersProvider>()
                  .unfriendUser(currUser.id!, user.id!);
            },
            style: ElevatedButton.styleFrom(
                primary: Color(0xFFE80C3A) // background
                ),
            child: Text("Unfriend"),
          ));
    } else if (currUser.receivedFriendRequests.contains(user.id)) {
      return ListTile(
          title: Text("${user.firstName} ${user.lastName}"),
          leading: Text("@${user.username}"),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            ElevatedButton(
              onPressed: () {
                context
                    .read<UsersProvider>()
                    .acceptRequest(currUser.id!, user.id!);
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF66B032), // background
              ),
              child: Text("Accept"),
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<UsersProvider>()
                    .rejectRequest(currUser.id!, user.id!);
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFE80C3A), // background
              ),
              child: Text("Reject"),
            ),
          ]));
    } else if (currUser.sentFriendRequest.contains(user.id)) {
      return ListTile(
          title: Text("${user.firstName} ${user.lastName}"),
          leading: Text("@${user.username}"),
          trailing: ElevatedButton(
            onPressed: () {
              context
                  .read<UsersProvider>()
                  .cancelRequest(currUser.id!, user.id!);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[600], // background
            ),
            child: Text("Cancel Friend Request"),
          ));
    } else if (currUser.id == user.id) {
      return ListTile(
        title: Text("${user.firstName} ${user.lastName}"),
        leading: Text("@${user.username}"),
      );
    } else {
      return ListTile(
          title: Text("${user.firstName} ${user.lastName}"),
          leading: Text("@${user.username}"),
          trailing: ElevatedButton(
            onPressed: () {
              context.read<UsersProvider>().addFriend(currUser.id!, user.id!);
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF66B032), // background
            ),
            child: Text("Add Friend"),
          ));
    }
  }
}
