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

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;
    Widget formItemSpace = SizedBox(height: size.height * .02);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return UnfocusWidget(
      child: Scaffold(
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
                    SizedBox(),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height * .14,
                          width: size.height * .14,
                          decoration: BoxDecoration(
                            color: Colors.green[700],
                            borderRadius: BorderRadius.circular(
                              size.height * .07,
                            ),
                          ),
                          child: Icon(Icons.check, color: Colors.white, size: size.height * .09,),
                        ),
                        formItemSpace,
                        formItemSpace,
                        CustomText("Successful", weight: FontWeight.bold, color: AppColors.appBlack, size: size.height * .026,),
                        formItemSpace,
                        CustomText("Your password has been changed \nsuccessfully", color: AppColors.appBlack, size: size.height * .018, textAlign: TextAlign.center,),
                      ],
                    ),

                    Column(
                      children: [
                        ActionButton(
                          title: "Back to Login ",
                          isLoading: model.initiatingForgotPasswordProcess,
                          onTap: () {
                           Navigator.pushNamedAndRemoveUntil(context, AppRouter.signIn, (Route<dynamic> route) => false);

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
