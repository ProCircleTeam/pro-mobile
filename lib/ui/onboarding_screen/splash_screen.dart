import 'package:flutter/material.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/local/secure_storage.dart';
import 'package:pro_mobile/domain/models/user_model.dart';
import 'package:pro_mobile/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final UserProvider userProvider;
  const SplashScreen({required this.userProvider, super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SecureStorageService _secureStorageService = SecureStorageService();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    String? token = await _secureStorageService.read(StringConstants.authToken);
    UserModel? user = await _secureStorageService.getUser();
    final preference = await SharedPreferences.getInstance();
    bool? isFirstTimeUser = preference.getBool(StringConstants.isFirstTimeUser);

    if (isFirstTimeUser == null) {
      Navigator.pushReplacementNamed(context, AppRouter.onboarding);
    } else if (token != null && token.isNotEmpty && user != null) {
      widget.userProvider.user = user;
      Navigator.pushReplacementNamed(context, AppRouter.dashboard);
    } else {
      Navigator.pushReplacementNamed(context, AppRouter.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
