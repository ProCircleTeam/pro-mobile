import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthService {
  Future<Response?> signUp({
    required String username,
    required String email,
    required String password,
    required bool agreeToTermsAndConditions, 
  });
  Future<Response?> login({
    required String emailOrUsername,
    required String password,
  });
  Future<Response?> signInWithGoogle();
}
