class ProfileStatusModel {
  final bool personalInfoComplete;
  final bool professionalInfoComplete;
  final bool goalsInfoComplete;
  final bool engagementInfoComplete;

  ProfileStatusModel({
    required this.personalInfoComplete,
    required this.professionalInfoComplete,
    required this.goalsInfoComplete,
    required this.engagementInfoComplete,
  });

  factory ProfileStatusModel.fromJson(Map<String, dynamic> json) {
    return ProfileStatusModel(
      personalInfoComplete: json['personalInfoComplete'] ?? false,
      professionalInfoComplete: json['professionalInfoComplete'] ?? false,
      goalsInfoComplete: json['goalsInfoComplete'] ?? false,
      engagementInfoComplete: json['engagementInfoComplete'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personalInfoComplete': personalInfoComplete,
      'professionalInfoComplete': professionalInfoComplete,
      'goalsInfoComplete': goalsInfoComplete,
      'engagementInfoComplete': engagementInfoComplete,
    };
  }
}
