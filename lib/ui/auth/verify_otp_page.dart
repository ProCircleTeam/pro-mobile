import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
import 'package:pro_mobile/ui/widgets/unfocus_widget.dart';
import 'package:provider/provider.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  Timer? _timer;
  int count = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
            "Verification",
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

          onModelDispose: (model) {},
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
                      "Enter the 6-digit code that was sent to your email.",
                      size: size.height * .018,
                    ),
                    Expanded(
                      child: Form(
                        child: Column(
                          children: [
                            formItemSpace,
                            formItemSpace,
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                                child: PinCodeTextField(
                                  appContext: context,
                                  length: 6,
                                  onChanged: (value) {},
                                  onCompleted: (value) {
                                    print("OTP entered: $value");
                                  },
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: size.width * .12,
                                    fieldWidth: size.width * .1,
                                    activeFillColor: AppColors.grey.withValues(alpha: .02),
                                    activeColor: AppColors.grey ,
                                    selectedFillColor: Colors.white,
                                    inactiveColor: AppColors.grey ,
                                    selectedColor: AppColors.grey ,
                                    disabledColor: AppColors.grey ,
                                    inactiveFillColor: AppColors.grey.withValues(alpha: .02),
                                  ),
                                  keyboardType: TextInputType.number,
                                  animationType: AnimationType.fade,
                                  enableActiveFill: true,
                                ),
                              ),
                            ),
                            formItemSpace,
                            formItemSpace,
                            CustomText(" ${count < 10 ? 0 : ""}$count : 00", size: size.height * .018),
                            formItemSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  "Didn't receive a code?",
                                  size: size.height * .018,
                                ),
                                InkWell(
                                  onTap:
                                      count == 0
                                          ? () {
                                            setState(() {
                                              count = 60;
                                            });
                                            startTimer();
                                          }
                                          : () {},
                                  child: CustomText(
                                    " Resend Code",
                                    color:
                                        count == 0 ? AppColors.richBlue : null,
                                    size: size.height * .018,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        ActionButton(
                          title: "Verify",
                          isLoading: model.initiatingForgotPasswordProcess,
                          onTap: () {
                           Navigator.pushNamed(
                              context,
                              AppRouter.resetPasswordPage,
                            );
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

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (count > 0) {
        setState(() {
          count = count - 1;
        });
        print("count $count");
      } else {
        print("count 2 $count");
        _timer?.cancel();
      }
    });
  }
}
