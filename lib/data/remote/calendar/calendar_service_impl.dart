import 'package:dio/dio.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/app/core/client/header.dart';
import 'package:pro_mobile/app/core/endpoints/endpoints.dart';
import 'package:pro_mobile/data/remote/calendar/calendar_service.dart';
import 'package:pro_mobile/domain/models/busy_time_model.dart';
import 'package:pro_mobile/domain/models/calendar_event_model.dart';

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

  @override
  Future<List<BusyTimePeriodModel>?>? getPartnerCalendarAvailability({
     required String weekStart,
    required String weekEnd,
  }) async {
    String url = Endpoints.getCalendarAvailability(start: weekStart, end: weekEnd);
    final header = await getAppHeader(isTokenRequired: true);
    final res = await appClient.get(url, headers: header);

    List busyPeriods =
        res?.data["data"]["busyPeriods"];
        
    return busyPeriods.isNotEmpty ? busyPeriods.map((period) => BusyTimePeriodModel.fromJson(period)).toList() : [];
  }

  @override
  Future<CalendarEventModel?>? scheduleAccountabilityCall({
    required String partnerFullName,
    required String startTime,
    required String endTime,
    required String partnerEmail,
    required String timeZone,
    required bool createMeetLink,
  }) async {
    String url = Endpoints.scheduleCalendarEvent;

    Map<String, dynamic> data = {
      "title": "Accountability Check-in Call",
      "description":
          "Weekly progress review and goal setting with $partnerFullName",
      "startTime": startTime,
      "endTime": endTime,
      "partnerEmail": partnerEmail,
      "timeZone": timeZone,
      "createMeetLink": true,
    };

    final header = await getAppHeader(isTokenRequired: true);

    Response? res = await appClient.post(url, data, headers: header);
    print(
      "This is the calendar event data  ==================> ${res?.data["data"]["url"]}",
    );
    return null;
  }
}
