import 'package:dio/dio.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/app/core/client/header.dart';
import 'package:pro_mobile/app/core/endpoints/endpoints.dart';
import 'package:pro_mobile/data/remote/user/user_service.dart';

class UserServiceImpl implements UserService {
  final AppClient appClient;
  UserServiceImpl(this.appClient);
  @override
  Future<Map<String, dynamic>> getUserProfileStatus() async{
     String url = Endpoints.getUserProfileStatus;

    final header = await getAppHeader(isTokenRequired: true);
    Response? res = await appClient.get(url, headers: header);
    return res?.data["data"];
  }
}
