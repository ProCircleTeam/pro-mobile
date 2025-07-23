import 'package:flutter/material.dart';
import 'package:pro_mobile/ui/auth/signup.dart';
import 'package:pro_mobile/ui/auth/signin.dart';
import 'package:pro_mobile/ui/dashboard/dashboard.dart';
import 'package:pro_mobile/ui/goals/goals_home.dart';
import 'package:pro_mobile/ui/home/home.dart';
import 'package:pro_mobile/ui/onboarding_screen/onboarding_screens.dart';

class AppRouter {
  Map<String, WidgetBuilder> generateRoutes(BuildContext context) {
    return {
      signUp: (context) => SignUpPage(),
      signIn: (context) => SignInPage(),
      home: (context) => HomePage(),
      dashboard: (context) => Dashboard(),
      goalsHomePage: (context) => GoalsHomePage(),
      onboarding: (context) => OnboardingScreen(),
    };
  }

  static const signUp = "/signUp";
  static const signIn = "/signIn";
  static const home = "/home";
  static const goalsHomePage = "/goals-home-page";
  static const onboarding = "/onboarding";
  static const dashboard = "/dashboard";
  static const settings = "/settings";
}
