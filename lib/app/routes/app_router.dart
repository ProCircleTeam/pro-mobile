import 'package:flutter/material.dart';
import 'package:pro_mobile/ui/auth/auth.dart';
import 'package:pro_mobile/ui/home/home.dart';
import 'package:pro_mobile/ui/onboarding_screen/onboarding_screens.dart';

class AppRouter {
  

  Map<String, WidgetBuilder> generateRoutes(BuildContext context) {
    return {
      auth: (context) => AuthPage(),
      home: (context) => HomePage(),
      onboarding: (context) => OnboardingScreen(),
    };
  }

  static const auth = "/auth";
  static const home = "/home";
  static const onboarding = "/onboarding";
}
