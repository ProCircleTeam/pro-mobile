import 'package:flutter/material.dart';
import 'package:pro_mobile/app/core/failure/failure.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/ui/base/base_view_model.dart';
import 'package:pro_mobile/ui/utils/app_logger.dart';
import 'package:pro_mobile/ui/utils/form_helper.dart';

class ChangePasswordModalView extends BaseViewModel {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  bool validateChangePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
    required Function(String e) onValidationFail,
  }) {
    if (oldPassword.isEmpty) {
      onValidationFail("Please enter your old password");
      return false;
    }
    
    String? validatePasswordError = FormHelper().checkLength(
      txt: newPassword,
      fieldname: "New Password",
      len: 6,
    );
    
    if (validatePasswordError != null) {
      onValidationFail(validatePasswordError);
      return false;
    }
    
    if (newPassword != confirmPassword) {
      onValidationFail("Passwords do not match");
      return false;
    }
    
    return true;
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
    required Function(String message) onSuccess,
    required Function(String errorMessage) onError,
  }) async {
    try {
      isLoading = true;

      // TODO: Replace with actual API call
      // Response? res = await userService.changePassword(
      //   oldPassword: oldPassword,
      //   newPassword: newPassword,
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      isLoading = false;
      
      // Clear form fields
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      
      onSuccess("Your password has been changed successfully");
    } on Failure catch (e) {
      isLoading = false;
      AppLogger.log("Error ==================> ${e.errorMessage}");
      onError(e.errorMessage);
    } catch (e) {
      isLoading = false;
      onError(ErrorText.generic);
      AppLogger.log("Error ==================> $e");
    }
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
