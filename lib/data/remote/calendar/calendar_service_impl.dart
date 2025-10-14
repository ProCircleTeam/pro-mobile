import 'package:dio/dio.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/app/core/client/header.dart';
import 'package:pro_mobile/app/core/endpoints/endpoints.dart';
import 'package:pro_mobile/data/remote/calendar/calendar_service.dart';

class CalendarServiceImpl implements CalendarService {
  final AppClient appClient;
  CalendarServiceImpl(this.appClient);

  @override
  Future<String> getGoogleCalendarUrl() async {
    String url = Endpoints.getGoogleCalendarUrl;

    final header = await getAppHeader(isTokenRequired: true);
    Response? res = await appClient.get(url, headers: header);
    return res?.data["data"]["url"];
  }
}
