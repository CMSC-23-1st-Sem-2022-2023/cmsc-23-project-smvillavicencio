import 'package:cmsc23_project_villavicencio/api/firebase_auth_api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  User? userObj;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    authService.getUser().listen((User? newUser) {
      userObj = newUser;
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $newUser');      
      notifyListeners();
    }, onError: (e) {
      // provide a more useful error
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
  }

  User? get user => userObj;

  bool get isAuthenticated {
    return user != null;
  }

  Future<String> signIn(String email, String password) {
    return authService.signIn(email, password);
  }

  void signOut() {
    authService.signOut();
  }

  Future<String> signUp(String email, String password, String firstName, String lastName, String username, String birthday, String location) {
    return authService.signUp(email, password, firstName, lastName, username, birthday, location);
  }
}