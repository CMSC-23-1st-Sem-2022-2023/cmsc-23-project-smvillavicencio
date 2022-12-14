/*
  Created by: Sebastian M. Villavicencio
  Section: D5L
  Date: 2 December 2022
  Description: Flutter mobile application composed of a sign in, sign-up and a shared todo list features with a user’s friends. 
*/

import 'dart:convert';

class User {
  String? id;
  String username;
  String email;
  String firstName;
  String lastName;
  String birthday;
  String location;
  String bio;
  List<dynamic> friends;
  List<dynamic> receivedFriendRequests;
  List<dynamic> sentFriendRequest;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.location,
    required this.bio,
    required this.friends,
    required this.receivedFriendRequests,
    required this.sentFriendRequest,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthday: json['birthday'],
      location: json['location'],
      bio: json['bio'],
      friends: json['friends'],
      receivedFriendRequests: json['receivedFriendRequests'],
      sentFriendRequest: json['sentFriendRequest'],
    );
  }

  static List<User> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<User>((dynamic d) => User.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'username': user.username,
      'email': user.email,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'birthday': user.birthday,
      'location': user.location,
      'bio': user.bio,
      'friends': user.friends,
      'receivedFriendRequests': user.receivedFriendRequests,
      'sentFriendRequest': user.sentFriendRequest,
    };
  }
}
