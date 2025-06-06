import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/form/custom_text_input.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';
import 'package:pro_mobile/ui/widgets/unfocus_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
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
    final size = MediaQuery.of(context).size;
    spaceFormItems() => SpacingWidget(degree: .025);

    return Scaffold(
      body: PaddedContainer(
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
                    padding: EdgeInsets.symmetric(horizontal: size.width * .01),
                    child: Form(
                      child: Column(
                        children: [
                          CustomTextInput(
                            hintText: "Full Name",
                            icon: Icons.person_2_outlined,
                          ),
                          spaceFormItems(),
                          CustomTextInput(
                            hintText: "Enter Your Email",
                            icon: Icons.email_outlined,
                          ),
                          spaceFormItems(),
                          CustomTextInput(
                            hintText: "Password",
                            icon: Icons.lock_outline,
                            trailingIcon: Icons.visibility_off_outlined,
                          ),
                          spaceFormItems(),
                          CustomTextInput(
                            hintText: "Confirm Password",
                            icon: Icons.lock_outline,
                            trailingIcon: Icons.visibility_off_outlined,
                          ),
                          SpacingWidget(degree: .01),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  checkboxTheme: CheckboxThemeData(
                                    shape: const CircleBorder(),
                                    side: BorderSide(color: AppColors.primary),
                                  ),
                                ),
                                child: Checkbox(
                                  value: true,
                                  onChanged: (e) {},
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
                                        style: termsAndConditionTextStyle(null),
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
                                        style: termsAndConditionTextStyle(null),
                                      ),
                                      TextSpan(
                                        text: 'privacy policy',
                                        style: termsAndConditionTextStyle(
                                          AppColors.primary,
                                        ),
                                        recognizer:
                                            _privacyRecognizer
                                              ..onTap = () {
                                                print('Tapped privacy policy');
                                              },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          spaceFormItems(),
                          ActionButton(title: "REGISTER", onTap: () {
                             Navigator.pushReplacementNamed(context, AppRouter.home);
                          }),
                          SpacingWidget(degree: .05),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: AppColors.lightBlack,
                                ),
                              ),
                              SpacingWidget(degree: 0.05, isVertical: false),
                              CustomText(
                                "Or continue with",
                                color: AppColors.lightBlack,
                              ),
                              SpacingWidget(degree: 0.05, isVertical: false),
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
                               Navigator.pushReplacementNamed(context, AppRouter.onboarding);
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
                                  text: 'Already have account? ',
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
                                          print('===========> Signing up');
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
    );
  }
}

TextStyle termsAndConditionTextStyle(Color? color) => TextStyle(
  fontFamily: 'SourceSan3',
  color: color,
  fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
);
