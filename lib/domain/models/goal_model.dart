class GoalModel {
  final int id;
  final int userId;
  final List<String> goals;
  final String? pairedWith;
  final String status;
  final DateTime weekStart;
  final DateTime weekEnd;
  final DateTime createdAt;
  final DateTime updatedAt;

  GoalModel({
    required this.id,
    required this.userId,
    required this.goals,
    this.pairedWith,
    required this.status,
    required this.weekStart,
    required this.weekEnd,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      goals: List<String>.from(json['goals']),
      pairedWith: json['paired_with'],
      status: json['status'] as String,
      weekStart: DateTime.parse(json['week_start']),
      weekEnd: DateTime.parse(json['week_end']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'goals': goals,
      'paired_with': pairedWith,
      'status': status,
      'week_start': weekStart.toIso8601String(),
      'week_end': weekEnd.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
