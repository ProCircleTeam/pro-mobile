class BusyTimePeriodModel {
  final DateTime start;
  final DateTime end;

  BusyTimePeriodModel({
    required this.start,
    required this.end,
  });

  factory BusyTimePeriodModel.fromJson(Map<String, dynamic> json) {
    return BusyTimePeriodModel(
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start.toUtc().toIso8601String(),
      'end': end.toUtc().toIso8601String(),
    };
  }


  @override
  String toString() {
    return 'BusyTimePeriodModel(start: $start, end: $end)';
  }
}