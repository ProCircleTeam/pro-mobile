import 'package:dio/dio.dart';

abstract class AuthService {
  Future<Response?> signUp({
    required String username,
    required String email,
    required String password,
  });
  Future<Response?> login({
    required String emailOrUsername,
     required String password
});
  Future<Response?> requestOtp(
     String email,
  );
  Future<Response?> resetPassword({
    required String email,
    required String otp,
    required String password,
  });
}
