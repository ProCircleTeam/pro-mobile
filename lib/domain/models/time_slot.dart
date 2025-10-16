import 'package:intl/intl.dart';

class TimeSlot {
  final DateTime start;
  final DateTime end;
  final bool available;

  TimeSlot({required this.start, required this.end, required this.available});

  /// Format time for display (e.g., "9:00 AM - 10:00 AM")
  String get formattedTime {
    final startFormat = DateFormat('h:mm a');
    final endFormat = DateFormat('h:mm a');
    return '${startFormat.format(start)} - ${endFormat.format(end)}';
  }

  /// Short time format (e.g., "9 AM")
  String get shortTime {
    return DateFormat('h a').format(start);
  }

  @override
  String toString() {
    return 'TimeSlot($formattedTime - Available: $available)';
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'available': available,
    };
  }
}
