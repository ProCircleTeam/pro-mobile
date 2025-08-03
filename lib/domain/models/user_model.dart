import 'package:pro_mobile/domain/models/time_zone.dart';

class UserModel {
  final int id;
  final String email;
  final String type;
  final String? phoneNumber;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? profilePhoto;
  final String? bio;
  final String? jobTitle;
  final int? yearsOfExperience;
  final String? longTermGoal;
  final String? preferredAccountabilityPartnerTrait;
  final List<String>? availabilityDays;
  final String? funFact;
  final String? careerSummary;
  final int? industrySectorId;
  final IndustrySector? industrySector;
  final List<AreaOfInterest>? areasOfInterests;
  final TimeZoneModel? timezone;
  UserModel({
    required this.id,
    required this.email,
    required this.type,
    this.phoneNumber,
    this.username,
    this.firstName,
    this.lastName,
    this.profilePhoto,
    this.bio,
    this.jobTitle,
    this.yearsOfExperience,
    this.longTermGoal,
    this.preferredAccountabilityPartnerTrait,
    this.availabilityDays,
    this.funFact,
    this.careerSummary,
    this.industrySectorId,
    this.industrySector,
    required this.areasOfInterests,
    this.timezone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      type: json['type'],
      phoneNumber: json['phone_number'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profilePhoto: json['profile_photo'],
      bio: json['bio'],
      jobTitle: json['job_title'],
      yearsOfExperience: json['years_of_experience'],
      longTermGoal: json['long_term_goal'],
      preferredAccountabilityPartnerTrait:
          json['preferred_accountability_partner_trait'],
      availabilityDays:
          json['availability_days'] != null
              ? (json['availability_days'] as List<dynamic>).map<String>((el) {
                return el.toString();
              }).toList()
              : [],
      funFact: json['fun_fact'],
      careerSummary: json['career_summary'],
      industrySectorId: json['industry_sector_id'],
      industrySector:
          json['industry_sector'] != null
              ? IndustrySector.fromJson(json['industry_sector'])
              : null,
      areasOfInterests:
          json['areaOfInterests'] != null
              ? (json['areaOfInterests'] as List<dynamic>).map((el) {
                return AreaOfInterest.fromJson(el);
              }).toList()
              : [],
      timezone:
          json['timezone'] != null
              ? TimeZoneModel.fromJson(json['timezone'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'type': type,
      'phone_number': phoneNumber,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'profile_photo': profilePhoto,
      'bio': bio,
      'job_title': jobTitle,
      'years_of_experience': yearsOfExperience,
      'long_term_goal': longTermGoal,
      'preferred_accountability_partner_trait':
          preferredAccountabilityPartnerTrait,
      'availability_days': availabilityDays,
      'fun_fact': funFact,
      'career_summary': careerSummary,
      'industry_sector_id': industrySectorId,
      'industry_sector': industrySector,
      'areaOfInterests': areasOfInterests,
      'timezone': timezone,
    };
  }
}

class IndustrySector {
  final int id;
  final String name;

  IndustrySector({required this.id, required this.name});

  factory IndustrySector.fromJson(Map<String, dynamic> json) {
    return IndustrySector(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class AreaOfInterest {
  final int id;
  final String name;

  AreaOfInterest({required this.id, required this.name});

  factory AreaOfInterest.fromJson(Map<String, dynamic> json) {
    return AreaOfInterest(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
