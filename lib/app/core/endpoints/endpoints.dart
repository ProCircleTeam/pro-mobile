class Endpoints {
  static const String baseUrl = "https://procirclebe.onrender.com/api/v1";
  static const String signUp = "$baseUrl/auth/signup";
  static const String signIn = "$baseUrl/auth/signin";
  static String getUserById(int id) => "$baseUrl/user/$id";
}