import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  static NotificationServices instance = NotificationServices._();
  NotificationServices._();
  factory NotificationServices() {
    return instance;
  }
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool notificationsEnabled = true; // Default to true

  void toggleNotifications(bool enabled) {
    notificationsEnabled = enabled;

    if (notificationsEnabled) {
      getDeviceToken();
    } else {
      disableNotifications(); // Disable notifications if they are turned off
    }
  }

  void disableNotifications() async {
    try {
      await messaging.deleteToken();
      if (kDebugMode) {
        log('Notifications disabled successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        log('Error disabling notifications: $e');
      }
    }
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        log('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        log('user granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        log('user denied permission');
      }
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    log("this is token firebase $token");
    return token ?? "";
  }

  void initLocalNotifications() async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
    );
  }

  void firebaseInit() {
    initLocalNotifications();
    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (kDebugMode) {
        log("notifications title:${notification?.title}");
        log("notifications body:${notification?.body}");
        log('count:${android?.count}');
        log('data:${message.data.toString()}');
      }

      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    if (message.notification == null) {
      return;
    }
    print(
      " channel id:  ${message.notification?.android?.channelId.toString()}",
    );
    // AndroidNotificationChannel channel = const AndroidNotificationChannel(
    //   "high_importance_channel",
    //   "high_importance_channel",
    //   importance: Importance.max,
    //   playSound: true,
    // );

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "high_importance_channel",
      "high_importance_channel",
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () async {
      await _flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title.toString() ?? '',
        message.notification?.body.toString() ?? '',
        notificationDetails,
      );
    });
  }
}
