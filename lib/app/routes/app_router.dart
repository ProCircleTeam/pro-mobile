import 'package:flutter/material.dart';
import 'package:pro_mobile/ui/auth/signup.dart';
import 'package:pro_mobile/ui/auth/signin.dart';
import 'package:pro_mobile/ui/dashboard/dashboard.dart';
import 'package:pro_mobile/ui/goals/create_and_update_goal.dart';
import 'package:pro_mobile/ui/home/home.dart';
import 'package:pro_mobile/ui/onboarding_screen/onboarding_screens.dart';
import 'package:pro_mobile/ui/settings/notification/notification_page.dart';
import 'package:pro_mobile/ui/settings/profile/profile.dart';
import 'package:pro_mobile/ui/settings/profile/profile_update.dart';

class AppRouter {
  Map<String, WidgetBuilder> generateRoutes(BuildContext context) {
    return {
      signUp: (context) => SignUpPage(),
      signIn: (context) => SignInPage(),
      home: (context) => HomePage(),
      dashboard: (context) => Dashboard(),
      goalsHomePage: (context) => CreateAndUpdateGoalPage(),
      onboarding: (context) => OnboardingScreen(),
      profile: (context) => ProfilePage(),
      notificationPage: (context) => NotificationPage(),
      profileUpdate: (context) => ProfileUpdate(),
    };
  }

  static const signUp = "/signUp";
  static const signIn = "/signIn";
  static const home = "/home";
  static const goalsHomePage = "/goals-home-page";
  static const onboarding = "/onboarding";
  static const dashboard = "/dashboard";
  static const settings = "/settings";
  static const profile = "/profile";
  static const notificationPage = "/notification_page";
  static const profileUpdate = "/Profile_update";
}

