class Endpoints {
  static const String baseUrl = "https://procirclebe.onrender.com/api/v1";
  static const String signUp = "$baseUrl/auth/signup";
  static const String signIn = "$baseUrl/auth/signin";
  static String signInWithGoogle = "$baseUrl/auth/sign-with-google";
  static String getUserById(int id) => "$baseUrl/user/$id";
  static const String createGoal = "$baseUrl/goal";
  static String getGoalById(int id) => "$baseUrl/goal/$id";
  static String getWeeklyGoalByDate(String date) => "$baseUrl/goal?date=$date";
  static String updateGoal(int id) => "$baseUrl/goal/$id";
  static String getUserProfileStatus = "$baseUrl/user/profile/status";
  static String updateProfessionalInfo =
      "$baseUrl/user/profile/professional-info/update";
  static String updateLongTermGoal = "$baseUrl/user/profile/goal-info/update";
  static String updatePersonalInfo = "$baseUrl/user/profile/personal-info/update";
  static String updateEngagementInfo =
      "$baseUrl/user/profile/engagement-info/update";
  static String getSupportedTimeZones = "$baseUrl/user/search/timezone";
  static String requestOtp = "$baseUrl/generic/request-otp";
  static String resetPassword = "$baseUrl/auth/reset-password";
  static String registerFcmToken = "$baseUrl/user/register-fcm-token";
  static String getUserNotifications = "$baseUrl/notification";
  static String getGoogleCalendarUrl = "$baseUrl/calendar/calendar-url";
  static String scheduleCalendarEvent = "$baseUrl/calendar/accountability-call";
  static String getCalendarAvailability = "$baseUrl/calendar/busy?startDate=2025-10-20T00:00:00.000Z&endDate=2025-10-27T23:59:59.999Z";
}
