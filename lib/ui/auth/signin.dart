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
import 'package:pro_mobile/ui/utils/helper.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/form/custom_text_input.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';
import 'package:pro_mobile/ui/widgets/unfocus_widget.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                        SpacingWidget(degree: .09),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                "Welcome Back!",
                                size: 22,
                                weight: FontWeight.bold,
                                color: AppColors.appBlack,
                              ),
                              SpacingWidget(degree: .004),
                              CustomText(
                                "Enter your info to continue",
                                size: 14,
                                color: AppColors.captionColor,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        SpacingWidget(degree: .07),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * .01,
                          ),
                          child: Form(
                            child: Column(
                              children: [
                                CustomTextInput(
                                  hintText: "Enter Email or Username",
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRouter.forgotPasswordPage,
                                        );
                                      },
                                      child: CustomText(
                                        "Forgot Password?",
                                        size: 14,
                                        weight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                spaceFormItems(),
                                ActionButton(
                                  title: "LOGIN",
                                  isLoading: model.isSigningIn || model.isSigningInWithGoogle,
                                  onTap: () {
                                    model.login(
                                      emailOrUsername:
                                          model.emailController.text.trim(),
                                      password:
                                          model.passwordController.text
                                              .toString(),
                                      onSuccess: (successMessage) {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRouter.dashboard,
                                        );
                                         Helper().registerFcmToken();
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
                                  },
                                ),
                                SpacingWidget(degree: .07),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: AppColors.lightBlack,
                                      ),
                                    ),
                                    SpacingWidget(
                                      degree: 0.07,
                                      isVertical: false,
                                    ),
                                    CustomText(
                                      "Or continue with",
                                      color: AppColors.lightBlack,
                                    ),
                                    SpacingWidget(
                                      degree: 0.07,
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
                                SpacingWidget(degree: .07),
                                ActionButton(
                                  title: "Google",
                                  title2: SvgPicture.asset(
                                    SVGImageUrl.googleLogo,
                                    height: 18,
                                  ),
                                  onTap: () async {
                                    await model.signInWithGoogle(
                                      onSuccess: (successMessage) {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRouter.dashboard,
                                        );
                                         Helper().registerFcmToken();
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
                                      }
                                    );
                                  },
                                  bgColor: AppColors.veryLightGrey,
                                ),
                                SpacingWidget(degree: .17),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Don't have account? ",
                                        style: termsAndConditionTextStyle(null),
                                      ),
                                      TextSpan(
                                        text: 'Sign Up',
                                        style: termsAndConditionTextStyle(
                                          AppColors.primary,
                                        ),
                                        recognizer:
                                            _privacyRecognizer
                                              ..onTap = () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  AppRouter.signUp,
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
