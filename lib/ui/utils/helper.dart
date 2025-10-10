import 'package:flutter/material.dart';
import 'package:pro_mobile/app/core/di/service_locator.dart';
import 'package:pro_mobile/app/core/integrations/firebase_service.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/local/secure_storage.dart';
import 'package:pro_mobile/data/remote/auth/auth_service.dart';

class Helper {
  Future<String?> getAccessToken() async {
    SecureStorageService storage = SecureStorageService();
    return await storage.read(StringConstants.authToken);
  }

  void printFull(String text) {
    const chunkSize = 800; // smaller than the cutoff
    for (var i = 0; i < text.length; i += chunkSize) {
      debugPrint(
        text.substring(
          i,
          i + chunkSize > text.length ? text.length : i + chunkSize,
        ),
      );
    }
  }

  String truncateWithEllipsis(int cutoff, String text) {
    return (text.length <= cutoff) ? text : '${text.substring(0, cutoff)}...';
  }

  Future<void> registerFcmToken() async {

    await FirebaseService().registerToken(sl.get<AuthService>());
  }
}
