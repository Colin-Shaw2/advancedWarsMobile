// CSCI 4100U - 06a Notifications

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notification {
  final channelId = 'eventNotifications';
  final channelName = 'Event Notifications';
  final channelDescription = 'Event Notification Channel';

  var _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  NotificationDetails _platformChannelInfo;

  void init() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('logo');
    var initializationSettingsIOS = new IOSInitializationSettings(
      onDidReceiveLocalNotification: (int id, String title, String body, String payload) { return null; }
    );
    var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, 
      initializationSettingsIOS
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification
    );

    // setup a channel for notifications
    var androidPlatformChannelInfo = AndroidNotificationDetails(
      channelId, 
      channelName, 
      channelDescription,
      importance: Importance.Max, 
      priority: Priority.High, 
      ticker: 'ticker');

    var iOSPlatformChannelInfo = IOSNotificationDetails();
    _platformChannelInfo = NotificationDetails(
      androidPlatformChannelInfo, 
      iOSPlatformChannelInfo
    );

  }

  Future onSelectNotification(var payload) async {
    if (payload != null) {
      print('notificationSelected: payload=$payload.');
    }
    // ... redirect to some part of the app, using payload to view correct data item ...
  }

  Future<void> sendNotificationWeekly() async {
    await _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
    0,
    'Start the week off right!',
    'Kick the week off with an action packed battle of Advance Wars!',
    Day.Sunday,
    new Time(9, 0, 0),
    _platformChannelInfo);
  }

  Future<void> sendAbsentNotification(String payload) async {
    _flutterLocalNotificationsPlugin.schedule(
      1, 
      'Get back to the battle!',
      "You haven't played in a few days, your troops need you to lead them to victory in Advance Wars!",
      DateTime.now().add(Duration(days: 3)),
      _platformChannelInfo,
      payload: payload
    );
  }

  Future<List<PendingNotificationRequest>> getPendingNotificationRequests() async {
    return _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }
}