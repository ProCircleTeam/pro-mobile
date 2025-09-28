import 'package:flutter/material.dart';
import 'package:pro_mobile/ui/auth/forgot_password.dart';
import 'package:pro_mobile/ui/auth/reset_password_page.dart';
import 'package:pro_mobile/ui/auth/signup.dart';
import 'package:pro_mobile/ui/auth/signin.dart';
import 'package:pro_mobile/ui/auth/success_page.dart';
import 'package:pro_mobile/ui/auth/verify_otp_page.dart';
import 'package:pro_mobile/ui/dashboard/dashboard.dart';
import 'package:pro_mobile/ui/goals/create_and_update_goal.dart';
import 'package:pro_mobile/ui/home/home.dart';
import 'package:pro_mobile/ui/onboarding_screen/onboarding_screens.dart';
import 'package:pro_mobile/ui/settings/notification/notification_page.dart';
import 'package:pro_mobile/ui/settings/profile/engagement_page.dart';
import 'package:pro_mobile/ui/settings/profile/goals_and_interest_page.dart';
import 'package:pro_mobile/ui/settings/profile/partner_profile_page.dart';
import 'package:pro_mobile/ui/settings/profile/personal_info_page.dart';
import 'package:pro_mobile/ui/settings/profile/professional_info_page.dart';
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
      personalInfoUpdatePage: (context) => PersonalInfoPage(),
      professionalInfoUpdatePage: (context) => ProfessionalInfoUpdatePage(),
      goalsAndInterest: (context) => GoalsAndInterestPage(),
      engagementPage: (context) => EngagementPage(),
      partnerProfilePage: (context) => PartnerProfilePage(),
      forgotPasswordPage: (context) => ForgotPasswordPage(),
      otpVerificationPage: (context) => VerifyOtpPage(),
      resetPasswordPage: (context) => ResetPasswordPage(),
      successPage: (context) => SuccessPage(),
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
  static const personalInfoUpdatePage = "/personal_info_update_page";
  static const professionalInfoUpdatePage = "/professional_info_update_page";
  static const goalsAndInterest = "/goals_and_interest_page";
  static const engagementPage = "/engagement_page";
  static const partnerProfilePage = "/partner_page";
  static const forgotPasswordPage = "/forgot_password_page";
  static const otpVerificationPage = "/otp_verification_page";
  static const resetPasswordPage = "/reset_password_page";
  static const successPage = "/success_page";
}

