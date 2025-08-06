import 'package:flutter/material.dart';
import 'package:pro_mobile/app/core/di/service_locator.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/data/remote/auth/auth_service.dart';
import 'package:pro_mobile/providers/user_provider.dart';
import 'package:pro_mobile/ui/auth/auth_view_model.dart';
import 'package:pro_mobile/ui/base/base_view.dart';
import 'package:pro_mobile/ui/utils/flush_bar/app_flush_bar.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/form/custom_text_input_2.dart';
import 'package:pro_mobile/ui/widgets/unfocus_widget.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;
    Widget formItemSpace = SizedBox(height: size.height * .02);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String otp = args["otp"];
    String email = args["email"];

    return UnfocusWidget(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            "Reset Password",
            weight: FontWeight.bold,
            color: AppColors.appBlack,
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: BaseView<AuthViewModel>(
          model: AuthViewModel(
            authService: sl.get<AuthService>(),
            userProvider: userProvider,
          ),
          onModelReady: (model) {},
          builder: (context, model, _) {
            return SizedBox(
              height: size.height,
              child: Container(
                padding: EdgeInsets.only(
                  left: size.height * .02,
                  right: size.height * .02,
                  bottom: size.height * .03,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "Set a new password for your account.",
                      size: size.height * .018,
                    ),
                    Expanded(
                      child: Form(
                        child: Column(
                          children: [
                            formItemSpace,
                            formItemSpace,
                            CustomTextInput2(
                              labelText: "New Password",
                              controller: model.passwordController,
                            ),
                            formItemSpace,
                            CustomTextInput2(
                              labelText: "Confirm new password",
                              controller: model.confirmPasswordController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        ActionButton(
                          title: "Reset",
                          isLoading: model.isResettingPassword,
                          onTap: () {
                            String password = model.passwordController.text;
                            String confirmPassword =
                                model.confirmPasswordController.text;
                            if (password.length < 5) {
                              AppFlushBar().showError(
                                message:
                                    "Password length must be greater than 5",
                                context: context,
                              );
                            } else if (password != confirmPassword) {
                              AppFlushBar().showError(
                                message: "Passwords do not match!",
                                context: context,
                              );
                            } else {
                              model.resetPassword(
                                otp: otp,
                                email: email,
                                password: model.passwordController.text,
                                onSuccess: (e) {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouter.successPage,
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

                        SizedBox(
                          height: viewInsets.bottom > 0 ? 0 : size.height * .05,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
