import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print(
      "Handling a background message: ==================>  ${message.messageId}",
    );
  }

  Future<void> listenForNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token;

    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Only now try to get the token
        token = await messaging.getToken();
        print("FCM Token: $token");
      } else {
        print("User declined or has not accepted permission");
      }
    } else {
      token = await messaging.getToken();
    }
    debugPrint("FCM Token: =====================================> $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
        ' ======================> Got a message while in the foreground!',
      );
      if (message.notification != null) {
        debugPrint('Message title: =========> ${message.notification!.title}');
        debugPrint('Message body: ============= ${message.notification!.body}');
      }
    });

    // When app is opened from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint(
          "App opened from terminated state: =====================>  ${message.data}",
        );
      }
    });

    // When app is opened from background via notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint(
        "App opened from background: =====================>  ${message.data}",
      );
    });
  }
}
