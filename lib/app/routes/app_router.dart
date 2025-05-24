import 'package:flutter/material.dart';
import 'package:pro_mobile/ui/home/home.dart';
import 'package:pro_mobile/ui/onboarding_screen/onboarding_screens.dart';

class AppRouter {
  static const home = "/home";
  static const onboarding = "/onboarding";

  Map<String, WidgetBuilder> generateRoutes(BuildContext context) {
    return {
      home: (context) => HomePage(),
      onboarding: (context) => OnboardingScreen(),
    };
  }
}
