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
                              controller: model.emailController,
                            ),
                            formItemSpace,
                            CustomTextInput2(
                              labelText: "Confirm new password",
                              controller: model.emailController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        ActionButton(
                          title: "Reset",
                          isLoading: model.initiatingForgotPasswordProcess,
                          onTap: () {
                            Navigator.pushNamed(context, AppRouter.successPage);
                            // model.initiateForgotPasswordProcess(
                            //   email: model.emailController.text,
                            //   onSuccess: (e) {
                            //     Navigator.pushNamed(
                            //       context,
                            //       AppRouter.otpVerificationPage,
                            //     );
                            //     AppFlushBar().showSuccess(
                            //       message: e,
                            //       context: context,
                            //     );
                            //   },
                            //   onError: (e) {
                            //     AppFlushBar().showError(
                            //       message: e,
                            //       context: context,
                            //     );
                            //   },
                            // );
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
