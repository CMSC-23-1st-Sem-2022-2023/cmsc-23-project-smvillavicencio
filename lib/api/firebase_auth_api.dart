/*
  Created by: Sebastian M. Villavicencio
  Date: 24 November 2022
  Description: Todo app with authentication
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // final db = FakeFirebaseFirestore();

  // final auth = MockFirebaseAuth(
  //   mockUser: MockUser(
  //   isAnonymous: false,
  //   uid: 'someuid',
  //   email: 'charlie@paddyspub.com',
  //   displayName: 'Charlie',
  // ));

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

  Future<String> signIn(String email, String password) async {
    UserCredential credential;
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Logging in...";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        print('Invalid email.');
        return 'Invalid email.';
      } else if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 'Wrong password provided for that user.';
      }
      return e.message.toString();
    }
  }

  Future<String> signUp(
      String email,
      String password,
      String firstName,
      String lastName,
      String username,
      String birthday,
      String location) async {
    UserCredential credential;
    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return saveUserToFirestore(credential.user?.uid, email, firstName,
          lastName, username, birthday, location);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 'The account already exists for that email.';
      }
      print(e.message.toString());
      return e.message.toString();
    }
  }

  void signOut() async {
    auth.signOut();
  }

  Future<String> saveUserToFirestore(
      String? uid,
      String email,
      String firstName,
      String lastName,
      String username,
      String birthday,
      String location) async {
    try {
      await db.collection("users").doc(uid).set({
        "id": uid,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "birthday": birthday,
        "location": location,
        "bio": "",
        "friends": [],
        "receivedFriendRequests": [],
        "sentFriendRequest": [],
      });
      print("Successfully signed up!");
      return "Successfully signed up!";
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }
}
