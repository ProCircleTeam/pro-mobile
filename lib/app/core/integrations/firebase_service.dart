import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pro_mobile/app/core/integrations/local_notification_service.dart';

class FirebaseService {
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint("Background message: ${message.messageId}");
  }

  Future<void> listenForNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Get token
    final token = await messaging.getToken();
    debugPrint("FCM Token: $token");

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
        "Got foreground message =====================>: ${message.notification?.title}",
      );
      LocalNotificationService().showNotification(message);
    });

    // Terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint("App opened from terminated state: ${message.data}");
      }
    });

    // Background tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint("App opened from background: ${message.data}");
    });
  }
}
