import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_mobile/app/core/di/service_locator.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/remote/auth/auth_service.dart';
import 'package:pro_mobile/providers/user_provider.dart';
import 'package:pro_mobile/ui/auth/auth_view_model.dart';
import 'package:pro_mobile/ui/base/base_view.dart';
import 'package:pro_mobile/ui/utils/flush_bar/app_flush_bar.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/form/custom_text_input.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';
import 'package:pro_mobile/ui/widgets/unfocus_widget.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TapGestureRecognizer _termsRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _privacyRecognizer = TapGestureRecognizer();

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    spaceFormItems() => SpacingWidget(degree: .025);

    return Scaffold(
      body: BaseView<AuthViewModel>(
        model: AuthViewModel(
          authService: sl.get<AuthService>(),
          userProvider: userProvider,
        ),
        builder:
            (context, model, _) => PaddedContainer(
              child: UnfocusWidget(
                child: Container(
                  child: SizedBox(
                    height: size.height,
                    child: Column(
                      children: [
                        SpacingWidget(degree: .07),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                "Sign Up",
                                size: 22,
                                weight: FontWeight.bold,
                                color: AppColors.appBlack,
                              ),
                              SpacingWidget(degree: .004),
                              CustomText(
                                "Create a new account",
                                size: 14,
                                color: AppColors.captionColor,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        SpacingWidget(degree: .04),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * .01,
                          ),
                          child: Form(
                            child: Column(
                              children: [
                                CustomTextInput(
                                  hintText: "Username",
                                  icon: Icons.person_2_outlined,
                                  controller: model.nameController,
                                ),
                                spaceFormItems(),
                                CustomTextInput(
                                  hintText: "Enter Your Email",
                                  icon: Icons.email_outlined,
                                  controller: model.emailController,
                                ),
                                spaceFormItems(),
                                CustomTextInput(
                                  hintText: "Password",
                                  icon: Icons.lock_outline,
                                  obscureText: model.obscurePassword,
                                  controller: model.passwordController,
                                  trailingIcon: InkWell(
                                    onTap: () {
                                      model.obscurePassword =
                                          !model.obscurePassword;
                                    },
                                    child: Icon(
                                      model.obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: AppColors.iconColor,
                                      size: size.width * .05,
                                    ),
                                  ),
                                ),
                                spaceFormItems(),
                                CustomTextInput(
                                  hintText: "Confirm Password",
                                  icon: Icons.lock_outline,
                                  obscureText: model.obscurePassword,
                                  controller: model.confirmPasswordController,
                                  trailingIcon: InkWell(
                                    onTap: () {
                                      model.obscurePassword =
                                          !model.obscurePassword;
                                    },
                                    child: Icon(
                                      model.obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: AppColors.iconColor,
                                      size: size.width * .05,
                                    ),
                                  ),
                                ),
                                SpacingWidget(degree: .01),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        checkboxTheme: CheckboxThemeData(
                                          shape: const CircleBorder(),
                                          side: BorderSide(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                      child: Checkbox(
                                        value:
                                            model
                                                .hasAgreedWithTermsAndConditions,
                                        onChanged: (e) {
                                          model.hasAgreedWithTermsAndConditions =
                                              !model
                                                  .hasAgreedWithTermsAndConditions;
                                        },
                                        activeColor: AppColors.primary,
                                      ),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'I agree to the ',
                                              style: termsAndConditionTextStyle(
                                                null,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'terms & conditions',
                                              style: termsAndConditionTextStyle(
                                                AppColors.primary,
                                              ),
                                              recognizer:
                                                  _termsRecognizer
                                                    ..onTap = () {
                                                      print(
                                                        'Tapped terms & conditions',
                                                      );
                                                    },
                                            ),
                                            TextSpan(
                                              text: ' and ',
                                              style: termsAndConditionTextStyle(
                                                null,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'privacy policy',
                                              style: termsAndConditionTextStyle(
                                                AppColors.primary,
                                              ),
                                              recognizer:
                                                  _privacyRecognizer
                                                    ..onTap = () {
                                                      print(
                                                        'Tapped privacy policy',
                                                      );
                                                    },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                spaceFormItems(),
                                ActionButton(
                                  title: "REGISTER",
                                  isLoading: model.isSigningUp,
                                  onTap: () {
                                    final String userName =
                                        model.nameController.text.trim();
                                    final String password =
                                        model.passwordController.text.trim();
                                    final String confirmPassword =
                                        model.confirmPasswordController.text
                                            .trim();
                                    final String email =
                                        model.emailController.text.trim();

                                    if (model.validateSignUp(
                                      name: userName,
                                      email: email,
                                      password: password,
                                      confirmPassword: confirmPassword,
                                      hasAcceptedTermsAndCondition:
                                          model.hasAgreedWithTermsAndConditions,
                                      onValidationFail: (e) {
                                        AppFlushBar().showError(
                                          message: e,
                                          context: context,
                                        );
                                      },
                                    )) {
                                      model.signUp(
                                        email: email,
                                        password: password,
                                        username: userName,
                                        onSuccess: (successMessage) {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            AppRouter.dashboard,
                                          );
                                          AppFlushBar().showSuccess(
                                            message: successMessage,
                                            context: context,
                                          );
                                        },
                                        onError: (e) {
                                          AppFlushBar().showError(
                                            message: e,
                                            context: context,
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                                SpacingWidget(degree: .05),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: AppColors.lightBlack,
                                      ),
                                    ),
                                    SpacingWidget(
                                      degree: 0.05,
                                      isVertical: false,
                                    ),
                                    CustomText(
                                      "Or continue with",
                                      color: AppColors.lightBlack,
                                    ),
                                    SpacingWidget(
                                      degree: 0.05,
                                      isVertical: false,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: AppColors.lightBlack,
                                      ),
                                    ),
                                  ],
                                ),
                                SpacingWidget(degree: .05),
                                ActionButton(
                                  title: "Google",
                                  title2: SvgPicture.asset(
                                    SVGImageUrl.googleLogo,
                                    height: 18,
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRouter.onboarding,
                                    );
                                  },
                                  bgColor: AppColors.veryLightGrey,
                                ),
                                SpacingWidget(degree: .09),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Already have an account? ",
                                        style: termsAndConditionTextStyle(null),
                                      ),
                                      TextSpan(
                                        text: 'Login',
                                        style: termsAndConditionTextStyle(
                                          AppColors.primary,
                                        ),
                                        recognizer:
                                            _privacyRecognizer
                                              ..onTap = () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  AppRouter.signIn,
                                                );
                                              },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}

TextStyle termsAndConditionTextStyle(Color? color) => TextStyle(
  fontFamily: 'SourceSan3',
  color: color,
  fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
);
