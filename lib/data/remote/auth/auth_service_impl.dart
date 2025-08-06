import 'package:dio/dio.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/app/core/endpoints/endpoints.dart';
import 'package:pro_mobile/data/remote/auth/auth_service.dart';
import 'package:pro_mobile/ui/utils/app_logger.dart';

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
  Future<Response?> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    const String url = Endpoints.signUp;
    Map<String, dynamic> data = {
      "username": username,
      "email": email,
      "password": password,
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
}
