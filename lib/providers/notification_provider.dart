/*
  Created by: Sebastian M. Villavicencio
  Date: 13 December 2022
  Description: Shared todo app with authentication
*/

import 'package:cmsc23_project_villavicencio/api/firebase_notifications_api.dart';
import 'package:cmsc23_project_villavicencio/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsProvider with ChangeNotifier {
  late FirebaseNotificationsAPI firebaseService;
  late Stream<QuerySnapshot> _notificationsStream;

  NotificationsProvider() {
    firebaseService = FirebaseNotificationsAPI();
  }

  // getter
  Stream<QuerySnapshot> get notifications => _notificationsStream;

  // fetch notifications of certain user
  void fetchNotifications(String uid) {
    _notificationsStream = firebaseService.getNotifications(uid);
  }

  // add notifications for a specific user
  void addNotification(String uid, Notifications item) async {
    String message =
        await firebaseService.addNotification(uid, item.toJson(item));
    print(message);
    notifyListeners();
  }

  void editNotification(String uid, String todoId, DateTime timestamp) async {
    String message =
        await firebaseService.editNotificationTimeStamp(uid, todoId, timestamp);
    print(message);
    notifyListeners();
  }
}
