/*
  Created by: Sebastian M. Villavicencio
  Section: D5L
  Date: 13 December 2022
  Description: Flutter mobile application composed of a sign in, sign-up and a shared todo list features with a user’s friends. 
*/

import 'dart:convert';

class Notifications {
  String? id;
  String type;
  String sourceId;
  String body;
  DateTime timestamp;

  Notifications({
    this.id,
    required this.type,
    required this.sourceId,
    required this.body,
    required this.timestamp,
  });

  // Factory constructor to instantiate object from json format
  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      type: json['type'],
      sourceId: json['sourceId'],
      body: json['body'],
      timestamp: json['timestamp'].toDate(),
    );
  }

  static List<Notifications> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<Notifications>((dynamic d) => Notifications.fromJson(d))
        .toList();
  }

  Map<String, dynamic> toJson(Notifications notif) {
    return {
      'type': notif.type,
      'sourceId': notif.sourceId,
      'body': notif.body,
      'timestamp': notif.timestamp,
    };
  }
}
