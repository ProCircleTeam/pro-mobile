import 'package:dio/dio.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/app/core/endpoints/endpoints.dart';
import 'package:pro_mobile/data/remote/notification/notification_service.dart';
import 'package:pro_mobile/ui/utils/app_logger.dart';

class NotificationServiceImpl extends NotificationService {
  final AppClient appClient;
  NotificationServiceImpl(this.appClient);
  @override
  Future<Response?> fetchUserNotifications() async {
    String url = Endpoints.getUserNotifications;

    Response? res = await appClient.get(url);
    AppLogger.log("===========================> signup result ==> $res");

    return res;
  }
// }
