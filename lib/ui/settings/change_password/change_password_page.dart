import 'package:flutter/material.dart';
import 'package:pro_mobile/ui/settings/change_password/change_password_view_modal.dart';
import 'package:provider/provider.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/form/custom_text_input_2.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePasswordModalView>(
      create: (_) => ChangePasswordModalView(),
      child: Consumer<ChangePasswordModalView>(
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
                    const CustomText("Change Password",
                        weight: FontWeight.w500, size: 20, color: Colors.black,),
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.richBlue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: viewModel.isLoading
                          ? null
                          : () => viewModel.savePassword(context),
                      child: viewModel.isLoading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                          : const CustomText(
                              "Save",
                              color: Colors.white,
                              weight: FontWeight.bold,
                            ),
                    ),
                  ),
                  const SizedBox(height:35),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
