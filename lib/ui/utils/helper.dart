import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro_mobile/app/core/di/service_locator.dart';
import 'package:pro_mobile/app/core/integrations/firebase_service.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/local/secure_storage.dart';
import 'package:pro_mobile/data/remote/auth/auth_service.dart';
import 'package:pro_mobile/domain/models/busy_time_model.dart';
import 'package:pro_mobile/domain/models/time_slot.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  Future<String?> getAccessToken() async {
    SecureStorageService storage = SecureStorageService();
    return await storage.read(StringConstants.authToken);
  }

  void printFull(String text) {
    const chunkSize = 800; // smaller than the cutoff
    for (var i = 0; i < text.length; i += chunkSize) {
      debugPrint(
        text.substring(
          i,
          i + chunkSize > text.length ? text.length : i + chunkSize,
        ),
      );
    }
  }

  String truncateWithEllipsis(int cutoff, String text) {
    return (text.length <= cutoff) ? text : '${text.substring(0, cutoff)}...';
  }

  Future<void> registerFcmToken() async {
    await FirebaseService().registerToken(sl.get<AuthService>());
  }

  void showInfoMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static Future<void> appUrlLauncher(String url, {bool inApp = false}) async {
    try {
      final Uri uri = Uri.parse(url);

      // Check if URL can be launched
      bool canLaunch = await canLaunchUrl(uri);

      if (canLaunch) {
        await launchUrl(
          uri,
          mode:
              inApp ? LaunchMode.inAppWebView : LaunchMode.externalApplication,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      } else {
        print('Cannot launch URL: $url');
        // Handle the error appropriately
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Handle exception
    }
  }

  static ({String startDate, String endDate}) getCurrentWeekDates() {
    final now = DateTime.now();
    final sunday = now.subtract(Duration(days: now.weekday % 7));
    final saturday = sunday.add(Duration(days: 6));

    final startDate = DateTime.utc(
      sunday.year,
      sunday.month,
      sunday.day,
      0,
      0,
      0,
      0,
    );
    final endDate = DateTime.utc(
      saturday.year,
      saturday.month,
      saturday.day,
      23,
      59,
      59,
      999,
    );

    return (
      startDate: startDate.toIso8601String(),
      endDate: endDate.toIso8601String(),
    );
  }

  static ({String startDate, String endDate, String readableRange})
  getCurrentWeekDatesDetailed() {
    final now = DateTime.now();
    final sunday = now.subtract(Duration(days: now.weekday % 7));
    final saturday = sunday.add(Duration(days: 6));

    final startDate = DateTime.utc(
      sunday.year,
      sunday.month,
      sunday.day,
      0,
      0,
      0,
      0,
    );
    final endDate = DateTime.utc(
      saturday.year,
      saturday.month,
      saturday.day,
      23,
      59,
      59,
      999,
    );

    return (
      startDate: startDate.toIso8601String(),
      endDate: endDate.toIso8601String(),
      readableRange:
          '${DateFormat('MMM dd').format(sunday)} - ${DateFormat('MMM dd, yyyy').format(saturday)}',
    );
  }

  static List<TimeSlot> getDailyTimeSlotsWithAvailability({
    required DateTime date,
    required List<BusyTimePeriodModel> busyPeriods,
  }) {
    final List<TimeSlot> timeSlots = [];
    final utcDate = DateTime.utc(date.year, date.month, date.day);

    // Generate hourly slots from 9 AM to 8 PM (9 to 20 in 24-hour format)
    for (int hour = 9; hour <= 20; hour++) {
      final slotStart = DateTime.utc(
        utcDate.year,
        utcDate.month,
        utcDate.day,
        hour,
        0,
      );
      final slotEnd = DateTime.utc(
        utcDate.year,
        utcDate.month,
        utcDate.day,
        hour + 1,
        0,
      );

      // Check if this slot intersects with any busy period
      final bool isAvailable =
          !_hasTimeIntersection(slotStart, slotEnd, busyPeriods);

      timeSlots.add(
        TimeSlot(start: slotStart, end: slotEnd, available: isAvailable),
      );
    }

    return timeSlots;
  }

  /// Checks if a time slot intersects with any busy period
  static bool _hasTimeIntersection(
    DateTime slotStart,
    DateTime slotEnd,
    List<BusyTimePeriodModel> busyPeriods,
  ) {
    for (final busyPeriod in busyPeriods) {
      if (_timesOverlap(slotStart, slotEnd, busyPeriod.start, busyPeriod.end)) {
        return true;
      }
    }
    return false;
  }

  /// Checks if two time ranges overlap
  static bool _timesOverlap(
    DateTime start1,
    DateTime end1,
    DateTime start2,
    DateTime end2,
  ) {
    return start1.isBefore(end2) && end1.isAfter(start2);
  }

  static List<BusyTimePeriodModel> filterBusyPeriodsForDate({
    required List<BusyTimePeriodModel> busyPeriods,
    required String dateString, // Format: "2025-10-14 00:00:00.000Z"
  }) {
    try {
    print("busyPeriods ===============> ${busyPeriods.length}");
    print("dateString ===============> ${dateString}");

      // Parse the input date string
      final targetDate = DateTime.parse(dateString.replaceAll(' ', 'T'));

      return busyPeriods.where((period) {
        return _isSameDate(period.start, targetDate) ||
            _isSameDate(period.end, targetDate) ||
            _spansMultipleDays(period, targetDate);
      }).toList();
    } catch (e) {
      print('Error filtering busy periods: $e');
      return [];
    }
  }

  /// Check if two DateTime objects represent the same calendar date
  static bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Check if a busy period spans across the target date (starts before and ends after)
  static bool _spansMultipleDays(
    BusyTimePeriodModel period,
    DateTime targetDate,
  ) {
    final periodStart = period.start;
    final periodEnd = period.end;

    return periodStart.isBefore(targetDate) && periodEnd.isAfter(targetDate);
  }
}
