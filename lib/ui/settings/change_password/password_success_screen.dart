import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check_circle, color: Colors.green, size: 80),
                  SizedBox(height: 20),
                  CustomText(
                    "Successful",
                    size: 22,
                    weight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  CustomText(
                    "Your password has been changed successfully",
                    size: 16,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

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
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const CustomText(
                  "Continue",
                  color: Colors.white,
                  weight: FontWeight.bold,
                ),
              ),
            ),
               const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
