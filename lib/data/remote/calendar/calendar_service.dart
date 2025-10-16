import 'package:pro_mobile/domain/models/busy_time_model.dart';
import 'package:pro_mobile/domain/models/calendar_event_model.dart';

abstract class CalendarService {
  Future<String> getGoogleCalendarUrl();
  Future<List<BusyTimePeriodModel>?>? getPartnerCalendarAvailability({
    required String weekStart,
    required String weekEnd,
    required String partnerId,
  });
  Future<CalendarEventModel?>? scheduleAccountabilityCall({
    required String partnerFullName,
    required String startTime,
    required String endTime,
    required String partnerEmail,
    required String timeZone,
    required bool createMeetLink,
  });
}
