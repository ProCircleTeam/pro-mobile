import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:pro_mobile/app/core/failure/failure.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/local/secure_storage.dart';
import 'package:pro_mobile/data/remote/auth/auth_service.dart';
import 'package:pro_mobile/domain/models/user_model.dart';
import 'package:pro_mobile/providers/user_provider.dart';
import 'package:pro_mobile/ui/base/base_view_model.dart';
import 'package:pro_mobile/ui/utils/app_logger.dart';
import 'package:pro_mobile/ui/utils/form_helper.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService authService;
  UserProvider userProvider;
  AuthViewModel({required this.authService, required this.userProvider});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  int _countDownTimer = 60;
  int get countDownTimer => _countDownTimer;
  set countDownTimer(int val) {
    _countDownTimer = val;
    notifyListeners();
  }

  bool _isSigningUp = false;
  bool get isSigningUp => _isSigningUp;
  set isSigninUp(bool val) {
    _isSigningUp = val;
    notifyListeners();
  }

  bool _isCanResendCode = false;
  bool get isCanResendCode => _isCanResendCode;
  set isCanResendCode(bool val) {
    _isCanResendCode = val;
    notifyListeners();
  }

  bool _isSigningIn = false;
  bool get isSigningIn => _isSigningIn;
  set isSigninIn(bool val) {
    _isSigningIn = val;
    notifyListeners();
  }

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;
  set obscurePassword(bool val) {
    _obscurePassword = val;
    notifyListeners();
  }

  bool _initiatingForgotPasswordProcess = false;
  bool get initiatingForgotPasswordProcess => _initiatingForgotPasswordProcess;
  set initiatingForgotPasswordProcess(bool val) {
    _initiatingForgotPasswordProcess = val;
    notifyListeners();
  }

  bool _hasAgreedWithTermsAndConditions = false;
  bool get hasAgreedWithTermsAndConditions => _hasAgreedWithTermsAndConditions;
  set hasAgreedWithTermsAndConditions(bool val) {
    _hasAgreedWithTermsAndConditions = val;
    notifyListeners();
  }

  bool validateSignUp({
    required String name,
    required String password,
    required String email,
    required String confirmPassword,
    required bool hasAcceptedTermsAndCondition,
    required Function(String e) onValidationFail,
  }) {
    String? validateNameError = FormHelper().checkLength(
      txt: name,
      fieldname: "Name",
      len: 3,
    );
    String? validateEmailError = FormHelper().validateEmail(email);
    String? validatePasswordError = FormHelper().checkLength(
      txt: password,
      fieldname: "Password",
      len: 6,
    );

    if (validateNameError != null) {
      onValidationFail(validateNameError);
      return false;
    } else if (validateEmailError != null) {
      onValidationFail(validateEmailError);
      return false;
    } else if (validatePasswordError != null) {
      onValidationFail(validatePasswordError);
      return false;
    } else if (password != confirmPassword) {
      onValidationFail("Passwords do not match");
      return false;
    } else if (!hasAcceptedTermsAndCondition) {
      onValidationFail("Kindly accept terms and condition to proceed!");
      return false;
    } else {
      return true;
    }
  }



  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required Function(String message) onSuccess,
    required Function(String errorMessage) onError,
  }) async {
    SecureStorageService storage = SecureStorageService();

    try {
      isSigninUp = true;

      Response? res = await authService.signUp(
        username: username,
        email: email,
        password: password,
      );

      isSigninUp = false;
      if (res != null && res.data != null) {
        UserModel user = UserModel.fromJson(res.data["data"]);
        userProvider.user = user;

        String token = res.data["data"]["token"];
        String message = res.data["message"];
        await storage.write(key: StringConstants.authToken, val: token);
        await storage.setUser(user);

        onSuccess(message);
      }
    } on Failure catch (e) {
      isSigninUp = false;
      AppLogger.log("Error ==================> ${e.errorMessage}");
      onError(e.errorMessage);
    } catch (e) {
      isSigninUp = false;
      onError(ErrorText.generic);
    }
  }

  Future<void> login({
    required String emailOrUsername,
    required String password,
    required Function(String successMessage) onSuccess,
    required Function(String errorMessage) onError,
  }) async {
    SecureStorageService storage = SecureStorageService();

    try {
      isSigninIn = true;

      Response? res = await authService.login(
        emailOrUsername: emailOrUsername,
        password: password,
      );

      print("The master ========================> ${res?.data["data"]}");
      isSigninIn = false;
      if (res != null && res.data != null) {
        UserModel user = UserModel.fromJson(res.data["data"]);
        userProvider.user = user;

        String token = res.data["data"]["token"];
        String message = res.data["message"];
        await storage.write(key: StringConstants.authToken, val: token);
        await storage.setUser(user);

        onSuccess(message);
      }
    } on Failure catch (e) {
      isSigninIn = false;
      AppLogger.log("Error ==================> ${e.errorMessage}");
      onError(e.errorMessage);
    } catch (e) {
      isSigninIn = false;
      onError(ErrorText.generic);
      AppLogger.log("Error ==================> $e");
    }
  }

  Future<void> initiateForgotPasswordProcess({
    required String email,
    required Function(String successMessage) onSuccess,
    required Function(String errorMessage) onError,
  }) async {
    try {
      String? validateEmailError = FormHelper().validateEmail(email);

      if (validateEmailError != null) {
        onError(validateEmailError);
        return;
      }

      initiatingForgotPasswordProcess = true;

      // Response? res = await authService.login(
      //   emailOrUsername: emailOrUsername,
      //   password: password,
      // );

      // print("The master ========================> ${res?.data["data"]}");
      initiatingForgotPasswordProcess = false;
      // if (res != null && res.data != null) {
      //   UserModel user = UserModel.fromJson(res.data["data"]);
      //   userProvider.user = user;

      //   String token = res.data["data"]["token"];
      //   String message = res.data["message"];
      //   await storage.write(key: StringConstants.authToken, val: token);
      //   await storage.setUser(user);

      onSuccess("OTP Sent");
      // }
    } on Failure catch (e) {
      initiatingForgotPasswordProcess = false;
      AppLogger.log("Error ==================> ${e.errorMessage}");
      onError(e.errorMessage);
    } catch (e) {
      initiatingForgotPasswordProcess = false;
      onError(ErrorText.generic);
      AppLogger.log("Error ==================> $e");
    }
  }
}
