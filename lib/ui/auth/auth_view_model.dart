import 'package:flutter/widgets.dart';
import 'package:pro_mobile/ui/base/base_view_model.dart';
import 'package:pro_mobile/ui/utils/form_helper.dart';

class AuthViewModel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isSigningUp = false;
  bool get isSigningUp => _isSigningUp;
  set isSigninUp(bool val) {
    _isSigningUp = val;
    notifyListeners();
  }

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;
  set obscurePassword(bool val) {
    _obscurePassword = val;
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

  Future<void> signUp(Function(String successMessage) onSuccess) async {
    isSigninUp = true;

    await Future.delayed(Duration(seconds: 3), () {
      onSuccess("Congratulations !!!");
    });
    isSigninUp = false;
  }
}
