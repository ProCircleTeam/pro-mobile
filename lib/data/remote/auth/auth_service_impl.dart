import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/app/core/endpoints/endpoints.dart';
import 'package:pro_mobile/data/remote/auth/auth_service.dart';
import 'package:pro_mobile/ui/utils/app_logger.dart';
import 'package:pro_mobile/ui/utils/helper.dart';

class AuthServiceImpl implements AuthService {
  final AppClient appClient;
  AuthServiceImpl(this.appClient);

  @override
  Future<Response?> login({
    required String emailOrUsername,
    required String password,
  }) async {
    const String url = Endpoints.signIn;

    Map<String, dynamic> data = {
      "identifier": emailOrUsername,
      "password": password,
    };

    Response res = await appClient.post(url, data);
    AppLogger.log("===========================> signIn result ==> $res");
    return res;
  }

  @override
  Future<Response?> signInWithGoogle() async {
    String serverClientId =
        "668739069836-gbdack0q2hdisf17q8i5rqhua42qtems.apps.googleusercontent.com";
    String url = Endpoints.signInWithGoogle;
    GoogleSignIn googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(serverClientId: serverClientId);

    GoogleSignInAccount account = await googleSignIn.authenticate(
      scopeHint: ['email'],
    );
    String idToken = account.authentication.idToken ?? "";
    Helper().printFull("idToken =========================> $idToken");

    Map<String, dynamic> data = {"idToken": idToken};

    Response res = await appClient.post(url, data);
    AppLogger.log(
      "===========================> Google sign in Success ==> $res",
    );
    return res;
  }

  @override
  Future<Response?> signUp({
    required String username,
    required String email,
    required String password,
    required bool agreeToTermsAndConditions,
  }) async {
    const String url = Endpoints.signUp;
    Map<String, dynamic> data = {
      "username": username,
      "email": email,
      "password": password,
      "agreeToTermsAndConditions": agreeToTermsAndConditions,
    };

    Response res = await appClient.post(url, data);
    AppLogger.log("===========================> signup result ==> $res");

    return res;
  }

  @override
  Future<Response?> requestOtp(String email) async {
    String url = Endpoints.requestOtp;
    Map<String, dynamic> data = {"email": email};

    Response res = await appClient.post(url, data);
    AppLogger.log("===========================> signup result ==> $res");

    return res;
  }

  @override
  Future<Response?> resetPassword({
    required String email,
    required String otp,
    required String password,
  }) async {
    String url = Endpoints.resetPassword;
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
      "otp": otp,
    };

    Response res = await appClient.put(url, data);
    AppLogger.log("===========================> signup result ==> $res");

    return res;
  }

  @override
  Future<Response?> registerFcmToken(String fcmToken) async {
    String url = Endpoints.registerFcmToken;

    try {
      var res = await appClient.put(url, {"fcmToken": fcmToken});
      debugPrint("Token registered successfuly ==============>");
      return res;
    } catch (e) {
      debugPrint("Error registering token =====================> $e");
      return null;
    }
  }
}
