import 'package:dio/dio.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/app/core/endpoints/endpoints.dart';
import 'package:pro_mobile/data/remote/auth/auth_service.dart';
import 'package:pro_mobile/domain/models/goal_model.dart';
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
}
