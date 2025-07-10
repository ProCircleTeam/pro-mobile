class Endpoints {
  static const String baseUrl = "https://procirclebe.onrender.com/api/v1";
  static const String signUp = "$baseUrl/auth/signup";
  static const String signIn = "$baseUrl/auth/signin";
  static String getUserById(int id) => "$baseUrl/user/$id";
  static const String createGoal = "$baseUrl/goal";
  static String getGoalById(int id) => "$baseUrl/goal/$id";
  static String getWeeklyGoalByDate(String date) => "$baseUrl/goal?date=$date";
  static String updateGoal(int id) => "$baseUrl/goal/$id";
}