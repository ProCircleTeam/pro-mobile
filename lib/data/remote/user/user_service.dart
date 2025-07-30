abstract class UserService {
  Future<List> getSupportedTimeZones();
  Future<Map<String, dynamic>> getUserProfileStatus();
  Future<Map<String, dynamic>> updateUserProfessionalInfo({
    required String careerSummary,
    required int industrySectorId,
    required String jobTitle,
    required int yearsOfExperience,
  });
  Future<Map<String, dynamic>> updateLongTermGoal({
    required List<int> addAreaOfInterests,
    required List<int> removeAreaOfInterests,
    required String longTermGoal,
    required String preferredAccountabilityPartnerTrait,
  });
  Future<void> updateEngagementInfo({
    required List<String> availabilityDays,
    required String funFact,
    required int timeZone,
  });
}
