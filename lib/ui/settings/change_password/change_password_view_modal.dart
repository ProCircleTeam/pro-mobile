import 'package:flutter/material.dart';
import 'package:pro_mobile/ui/settings/change_password/password_success_screen.dart';

class ChangePasswordModalView extends ChangeNotifier {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> savePassword(BuildContext context) async {
    final oldPass = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (oldPass.isEmpty) {
      _showError(context, "Please enter your old password");
      return;
    }
    if (newPass.isEmpty) {
      _showError(context, "Please enter a new password");
      return;
    }
    if (newPass.length < 6) {
      _showError(context, "Password must be at least 6 characters");
      return;
    }
    if (newPass != confirmPass) {
      _showError(context, "Passwords do not match");
      return;
    }

    _setLoading(true);
    try {
      // TODO: call your real API here
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => const PasswordSuccessScreen()),
      );
    } catch (e) {
      _showError(context, "Something went wrong");
    } finally {
      _setLoading(false);
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
