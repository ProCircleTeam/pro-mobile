import 'package:dio/dio.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/app/core/client/header.dart';
import 'package:pro_mobile/app/core/endpoints/endpoints.dart';
import 'package:pro_mobile/data/remote/notification/notification_service.dart';

class NotificationServiceImpl extends NotificationService {
  final AppClient appClient;
  NotificationServiceImpl(this.appClient);
  @override
  Future<Response?> fetchUserNotifications() async {
    String url = Endpoints.getUserNotifications;

    final header = await getAppHeader(isTokenRequired: true);
    Response? res = await appClient.get(url, headers: header);
    return res;
  }
}
