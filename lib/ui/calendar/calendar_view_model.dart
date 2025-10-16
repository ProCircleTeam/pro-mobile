import 'package:pro_mobile/app/core/failure/failure.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/remote/calendar/calendar_service.dart';
import 'package:pro_mobile/domain/models/busy_time_model.dart';
import 'package:pro_mobile/ui/base/base_view_model.dart';
import 'package:pro_mobile/ui/utils/app_logger.dart' show AppLogger;

class CalendarViewModel extends BaseViewModel {
  final CalendarService calendarService;
  CalendarViewModel(this.calendarService);

  List<BusyTimePeriodModel> _partnerBusyPeriods = [];
  List<BusyTimePeriodModel> get partnerBusyPeriods => _partnerBusyPeriods;
  set partnerBusyPeriods(List<BusyTimePeriodModel> val) {
    _partnerBusyPeriods = val;
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
    required String weekStart,
    required String weekEnd,
    required String partnerId,
  }) async {
    try {
      isGettingPartnerAvailabilityTime = true;
      var res = await calendarService.getPartnerCalendarAvailability(
        weekStart: weekStart,
        weekEnd: weekEnd,
        partnerId: partnerId,
      );
      if (res != null) {
        partnerBusyPeriods = res;
      }
      isGettingPartnerAvailabilityTime = false;
      onSuccess("Availability time fetched successfully");
    } on Failure catch (e) {
      isGettingPartnerAvailabilityTime = false;
      onError(e.errorMessage);
      AppLogger.log(
        "Error getting partner availability ==================> ${e.errorMessage}",
      );
    } catch (e) {
      isGettingPartnerAvailabilityTime = false;
      onError(ErrorText.generic);
      AppLogger.log(
        "Error getting partner availability ==================> $e",
      );
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
