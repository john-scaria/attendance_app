import 'package:attendance_app/src/fcm/notification_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationHandler {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  void setupFirebase(BuildContext context) async {
    NotificationHandler.initNotification(context);
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    String? _fcmId = await messaging.getToken();
    print('FCM ID : $_fcmId');
    _firebaseCloudMessagingListener(context);
  }

  static Future<String?> getFcmId() async => await messaging.getToken();

  void _firebaseCloudMessagingListener(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        NotificationHandler.flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              NotificationHandler.channel.id,
              NotificationHandler.channel.name,
            ),
          ),
        );
      }
    });
  }
}
