/*
  Created by: Sebastian M. Villavicencio
  Date: 17 November 2022
  Description: Friends app with networking
*/

import 'package:cmsc23_project_villavicencio/api/firebase_users_api.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersProvider with ChangeNotifier {
  late FirebaseUsersAPI firebaseService;
  late Stream<QuerySnapshot> _usersStream;
  late Stream<DocumentSnapshot> _user;

  UsersProvider() {
    firebaseService = FirebaseUsersAPI();
    fetchAllUsers();
  }

  Stream<QuerySnapshot> get users => _usersStream;
  Stream<DocumentSnapshot> get user => _user;

  fetchOneUser(String uid) {
    _user = firebaseService.getOneUser(uid);
    // notifyListeners();
  }

  fetchAllUsers() {
    _usersStream = firebaseService.getAllUsers();
    // notifyListeners();
  }

  unfriendUser(String currId, String friendId) {
    firebaseService.removeFriend(currId, friendId);
    notifyListeners();
  }

  acceptRequest(String currId, String senderId) {
    firebaseService.acceptUser(currId, senderId);
    notifyListeners();
  }

  rejectRequest(String currId, String senderId) {
    firebaseService.rejectUser(currId, senderId);
    notifyListeners();
  }

  cancelRequest(String currId, String senderId) {
    firebaseService.cancelFriendRequest(currId, senderId);
    notifyListeners();
  }

  addFriend(String currId, String senderId) {
    firebaseService.addUser(currId, senderId);
    notifyListeners();
  }
}
