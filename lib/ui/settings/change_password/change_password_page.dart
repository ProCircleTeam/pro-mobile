import 'package:flutter/material.dart';
import 'package:pro_mobile/ui/base/base_view.dart';
import 'package:pro_mobile/ui/settings/change_password/change_password_view_modal.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/form/custom_text_input_2.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ChangePasswordModalView>(
      model: ChangePasswordModalView(),
      builder: (context, viewModel, _) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(
                    "Change Password",
                    weight: FontWeight.w500,
                    size: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 2),
                  CustomText(
                    "Set a new password for your account.",
                    size: 14,
                    weight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    color: AppColors.lightBlack,
                  ),
                ],
              ),
            ),
            centerTitle: true,
          ),
          body: PaddedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                CustomTextInput2(
                  labelText: "Old Password",
                  controller: viewModel.oldPasswordController,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                CustomTextInput2(
                  labelText: "New Password",
                  controller: viewModel.newPasswordController,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                CustomTextInput2(
                  labelText: "Confirm New Password",
                  controller: viewModel.confirmPasswordController,
                  obscureText: true,
                ),
                const Spacer(),

                ActionButton(title: 'Save', onTap: () {}),
                const SizedBox(height: 35),
              ],
            ),
          ),
        );
      },
    );
  }
}
