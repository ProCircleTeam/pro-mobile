import 'package:pro_mobile/app/core/failure/failure.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/remote/calendar/calendar_service.dart';
import 'package:pro_mobile/ui/base/base_view_model.dart';
import 'package:pro_mobile/ui/utils/app_logger.dart' show AppLogger;

class CalendarViewModel extends BaseViewModel {
  final CalendarService calendarService;
  CalendarViewModel(this.calendarService);

  bool _isSynchingCalendar = false;
  bool get isSynchingCalendar => _isSynchingCalendar;
  set isSynchingCalendar(bool val) {
    _isSynchingCalendar = val;
    notifyListeners();
  }

  bool _isSchedulingCall = false;
  bool get isSchedulingCall => _isSchedulingCall;
  set isSchedulingCall(bool val) {
    _isSchedulingCall = val;
    notifyListeners();
  }

  bool _isGettingPartnerAvailabilityTime = false;
  bool get isGettingPartnerAvailabilityTime =>
      _isGettingPartnerAvailabilityTime;
  set isGettingPartnerAvailabilityTime(bool val) {
    _isGettingPartnerAvailabilityTime = val;
    notifyListeners();
  }

  Future<void> getPartnerCalendarAvailability({
    required Function(String e) onSuccess,
    required Function(String e) onError,
  }) async {
    try {
      isGettingPartnerAvailabilityTime = true;
      await calendarService.getGoogleCalendarUrl();
      isGettingPartnerAvailabilityTime = false;
      onSuccess("Availability time fetched successfully");
    } on Failure catch (e) {
      isGettingPartnerAvailabilityTime = false;
      onError(e.errorMessage);
      AppLogger.log(
        "Error synching calender ==================> ${e.errorMessage}",
      );
    } catch (e) {
      isGettingPartnerAvailabilityTime = false;
      onError(ErrorText.generic);
      AppLogger.log("Error synching calendar ==================> $e");
    }
  }

  Future<void> connectGoogleCalendar({
    required Function(String e) appUrlLauncher,
    required Function(String e) onSuccess,
    required Function(String e) onError,
  }) async {
    try {
      isSynchingCalendar = true;
      String url = await calendarService.getGoogleCalendarUrl();
      await appUrlLauncher(url);
      isSynchingCalendar = false;
      onSuccess("You have successfuly connected your calendar");
    } on Failure catch (e) {
      isSynchingCalendar = false;
      onError(e.errorMessage);
      AppLogger.log(
        "Error synching calender ==================> ${e.errorMessage}",
      );
    } catch (e) {
      isSynchingCalendar = false;
      onError(ErrorText.generic);
      AppLogger.log("Error synching calendar ==================> $e");
    }
  }

  Future<void> scheduleAccountabilityCall({
    required Function(String e) onSuccess,
    required Function(String e) onError,
    required String startTime,
    required String endTime,
    required String partnerEmail,
    required String timeZone,
  }) async {
    try {
      isSchedulingCall = true;
      await calendarService.scheduleAccountabilityCall(
        partnerFullName: partnerEmail,
        startTime: startTime,
        endTime: endTime,
        partnerEmail: partnerEmail,
        timeZone: timeZone,
        createMeetLink: true,
      );
      isSchedulingCall = false;
      onSuccess("Call scheduled successfully");
    } on Failure catch (e) {
      isSchedulingCall = false;
      onError(e.errorMessage);
      AppLogger.log(
        "Error synching calender ==================> ${e.errorMessage}",
      );
    } catch (e) {
      isSchedulingCall = false;
      onError(ErrorText.generic);
      AppLogger.log("Error synching calendar ==================> $e");
    }
  }
}
